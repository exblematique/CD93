#!/bin/bash

# Creation d'un fichier domain_list_1.txt en incluant uniquement les domaines sans sous-domaines
cd noms-de-domaine-organismes-publics/sources/
cat academies.txt aphp.txt collectivites.txt etablissements-scolaires.txt hopitaux.txt universites.txt | grep --invert-match '\..*\.'  > ../../domain_list_1.txt
cd ../..

if [ -z "$1" ] || [ "$1" != "verbose" -a "$1" != "domain" -a "$1" != "mail" ]
then
    # Erreur d'arguments
    >&2 echo "Veuillez mettre un argument entre 'verbose', 'domain' ou 'mail'"
    exit 1
fi

# Suppression de domaines génériques n'incluant pas d'adresses mail d'un domaine d'une collectivité + ajout d'un \ avant le point (eviter le regex) + Ajout @ ou . (sous-domaine) devant
grep --invert-match --extended-regex "sfr\.fr|wordpress\.com|facebook\.com" domain_list_1.txt | sed -e "s/\./\\\./" -e "s/^/\[\\\.@\]/" > domain_list_2.txt

# Recuperation de la liste des domaines et sous-domaines d'administration compromis des adresses mails + ajout d'un \ avant le point (eviter le regex)
sed -e "s/.*@/@/" leak.txt | uniq | grep --ignore-case --file domain_list_2.txt | sed -e "s/\./\\\./" > domain_list_1_leak.txt

# Generation du fichier final
# S'il n'y a pas l'argument -v :
case "$1" in
    "verbose")
	# Version verbose
	#echo "Liste des domaines :"
	#echo "---------------------"

	for domain in `cat domain_list_1_leak.txt | sort | uniq`
	do
	    echo "Domaine $(echo $domain | sed -e 's/\\//' -e 's/@//'):"
	    echo "---------------------"
	    for mail in `grep --ignore-case "$domain" leak.txt | uniq`
	    do
		echo "$mail"
	    done
	    echo ""
	done
	;;
    "domain")
	# Domaines seulements
        sed -e "s/[\\]//" -e "s/@//" domain_list_1_leak.txt | sort | uniq
	;;
    "mail")
	# Version simplifie
	grep --ignore-case --file domain_list_1_leak.txt leak.txt | uniq
	;;
    *)
	# Erreur d'arguments
	echo "Veuillez mettre un argument entre 'verbose', 'domain' ou 'mail'"
	;;
esac

# Suppression des fichiers intermediaires
rm domain_list_*.txt

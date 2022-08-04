# Script pour retrouver l'ensemble des collectivites présentes dans un fichier de leak
## Explications
A partir d'une base de données corrompue sur internet, il est possible de retrouver l'ensemble des informations liées aux collectivités.

## Etape 1 : générer le fichier de leak
Il faut mettre dans ce répertoire un fichier nommé "leak.txt". Ce fichier doit contenir uniquement des adresses mails, 1 par ligne
Exemple :
```
exemple.sfr.fr
exemple.collectivite.fr
```

Des exemples pour parser les fichiers sont présents dans le fichier : ```retrieve_mail.sh```

## Etape 2 : lancer le script
Ce script nécessite un argument (en position 1 uniquement) :
- "verbose" permet d'afficher l'ensemble des adresses mails corrompus par noms de domaines.
- "domain" affiche uniquement les noms de domaines des présents dans le fichier leak.txt.
- "mail" affiche uniquement les adresses mails des collectivités

Il est également possible de l'enregistrer dans un fichier domain-list.txt avec la commande suivante :
```bash
./generate_leak.sh domain > domain-list.txt
```

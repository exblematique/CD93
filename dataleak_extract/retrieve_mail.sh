grep --text -o -e "|[A-Za-z0-9\.\-]*@[A-Za-z0-9\.\-_]*|" leak.txt.src | sed -e "s/|//" -e "s/|//" > leak.txt

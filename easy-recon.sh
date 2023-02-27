#!/bin/bash


echo "############         ##               ##############           #       #"
echo "#                   #  #              #                         #      #"
echo "#                  #    #             #                          #    #"
echo "#                 #      #            #                           #  #"
echo "############     ##########           ##############               ##"
echo "#               #          #                       #               ##"  
echo "#              #            #                      #               ##" 
echo "#             #              #                     #               ##" 
echo "############ #                #       ##############               ##" 

echo ""

echo "########       ###########       ################      ##############       #                  #"    
echo "#      #       #                 #                     #            #       #  #               #"
echo "#      #       #                 #                     #            #       #    #             #"    
echo "#      #       #                 #                     #            #       #      #           #"
echo "########       ###########       #                     #            #       #        #         #"
echo "# #            #                 #                     #            #       #          #       #"
echo "#   #          #                 #                     #            #       #            #     #"
echo "#     #        #                 #                     #            #       #              #   #"
echo "#       #      #                 #                     #            #       #                # #" 
echo "#         #    ###########       ################      ##############       #                  #"





port=$1 
echo "please enter a domain or use -h to view the available options"  
read domain
domain2=$(echo "$domain" | cut -d "." -f 2,3)


wordlist=$(wget https://raw.githubusercontent.com/rbsec/dnscan/master/subdomains-500.txt)
echo "$wordlist"

#performing subdomain bruteforcing
for y in $(cat subdomains-500.txt)
do
echo $domain | sed "s/www/$y/"
done > brute.txt
append=$(awk '{print "https://" $1}' brute.txt)
echo "$append" > output.txt

remove=$(rm subdomains-500.txt)
remove2=$(rm brute.txt)
echo "$remove"
echo "$remove2"

#extracting subdomains from crt.sh
curl https://crt.sh/?q=$domain2 | grep "$domain2"  | cut -d ">" -f 2 | cut -d "<" -f 1  | uniq | cut -d "*" -f 2  | grep -v " " | sort | uniq | awk '{print "https://" $1}' >> output.txt


#remove dublicates
dublicate=$(cat output.txt | sort | uniq)
echo "$dublicate" > finaloutput.txt
remove=$(rm output.txt)
echo "$remove"


function portscan()
{
portt=$(nc -zv $domain2 1-1000 -w 1 > portscan.txt 2>&1)
echo "$port"
gre=$(cat portscan.txt | grep "succeeded!")
echo "$gre"
rem=$(rm portscan.txt)
echo "$rem"
}

function ip()
{
for y in $(cat finaloutput.txt)
do
ip=$(dig +short $domain2 | tail --lines=1 )
if [[ $ip == "" ]]; then
echo "$y[cannot resolve IP]"
else
echo "$y[$ip]"
fi
done
}


function statuscode(){
for x in $(cat finaloutput.txt)
do
output=$(curl -I -s $x | head --lines=1 | cut -d " " -f 2 )
if [[ $output == "" ]]; then
echo "$x[404]"
else
echo "$x[$output]"
fi
done
}

if [[ $port == "-p" ]]; then
portscan

elif [[ $port == "-h" ]]; then
echo " USAGE:"
echo " -p : enable port scan mode for top ports"
echo " -i : enable ip extraction"
echo " -s : enable status code detection"

elif [[ $port == "-i" ]]; then
ip

elif [[ $port == "-s" ]]; then
statuscode

fi












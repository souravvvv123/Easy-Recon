# Easy-Recon
This tool is made to made reconnaissance easy and smooth which is a must needed concept in penetration testing.

Purpose: 

It is help you Perform Reconnaissance with the help of basic Lunix commands which will not require the installation of any additional tools.


Features:
As soon as the URL is provided it will perform subdomain scrapping and subdomain Bruteforcing.
It can extract IP address from the list of domains.
It can scan for Open ports.
It will sort the subdomains in respect to its status code.
It will automatically remove all the pre-requsites once the tasks are executed.

Usage:

-s Provides you the status code of the subdomain and the main domains
-i extracts IP from the list of domains
-p Scan the working ports for those URL or IPs

./easy-recon.sh -s
 =>  please enter a domain or use -h to view the available options
 =>  www.example.com
 
 ./easy-recon.sh -i
 =>  please enter a domain or use -h to view the available options
 =>  www.example.com
 
 ./easy-recon.sh -p
 =>  please enter a domain or use -h to view the available options
 =>  www.example.com

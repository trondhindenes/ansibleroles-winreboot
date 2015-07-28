#!/bin/bash
output=$(curl -s -f -k -m 10 --header "Content-Type: application/soap+xml;charset=UTF-8" --header "WSMANIDENTIFY: unauthenticated" https://{{ inventory_hostname }}:5986/wsman --data "<s:Envelope xmlns:s=http://www.w3.org/2003/05/soap-envelope xmlns:wsmid=http://schemas.dmtf.org/wbem/wsman/identity/1/wsmanidentity.xsd><s:Header/><s:Body><wsmid:Identify/></s:Body></s:Envelope>" || true);
if [[ $output == *"IdentifyResponse"* ]]
then
	echo "Online";
else
	echo "Offline";
fi
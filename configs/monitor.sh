#!/bin/bash

echo "" > /tmp/conexao.txt
while true
do
response=$(curl --write-out %{http_code} --connect-timeout 5  --silent --output /dev/null http://192.168.42.65/index.html)
	if [ $response -eq 200 ]
	then  
            tempo=`uptime | awk '{print $1}'`
            echo "estabelecida($response): $tempo" >> /tmp/conexao.txt            
        else
            tempo=`uptime | awk '{print $1}'`            
            echo "perdida($response): $tempo" >> /tmp/conexao.txt
        fi

sleep 1
done

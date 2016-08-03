#!/bin/sh
#create self-signed server certificate:
read -p "enter your domain [www.example.com]:" DOMAIN

echo "......generate server key......"
openssl genrsa -des3 -out $DOMAIN.key 2048

echo "......create server certificate signing request......"
SUBJECT="/C=CN/ST=CHINA/L=BEIJING/O=YTWD/OU=IT/CN=$DOMAIN/emailAddress=test123@163.com"
openssl req -new -subj $SUBJECT -key $DOMAIN.key -out $DOMAIN.csr

echo "......remove password......"
mv $DOMAIN.key $DOMAIN.temp.key
openssl rsa -in $DOMAIN.temp.key -out $DOMAIN.key

echo "......sign SSL certificate......"
openssl x509 -req -days 3650 -in $DOMAIN.csr -signkey $DOMAIN.key -out $DOMAIN.crt 

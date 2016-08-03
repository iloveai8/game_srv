#!/bin/sh
# 链接地址：http://www.barretlee.com/blog/2015/10/05/how-to-build-a-https-server/

read -p "enter your domain [www.example.com]:" DOMAIN
# create self-signed CA:
echo ".............generate CA key............."
openssl genrsa -des3 -out ca.key 2048

echo ".............create CA certificate signing request............."
SUBJECT="/C=CN/ST=CHINA/L=BEIJING/O=My-CA/OU=IT/CN=$DOMAIN/emailAddress=test123@163.com"
openssl req -new -subj $SUBJECT -key ca.key -out ca.csr

echo ".............make CA certificate signing crt............."
openssl x509 -req -days 3650 -in ca.csr -signkey ca.key -out ca.crt

echo ".............generate server key............."
openssl genrsa -out server.key 2048
openssl rsa -in server.key -pubout -out server.pem

echo ".............generate client key............."
openssl genrsa -out client.key 2048
openssl rsa -in client.key -pubout -out client.pem

echo ".............create server certificate signing request............."
SUBJECT="/C=CN/ST=CHINA/L=BEIJING/O=Server-CA/OU=IT/CN=$DOMAIN/emailAddress=test123@163.com"
openssl req -new -subj $SUBJECT -key server.key -out server.csr

echo ".............make server CA certificate signing crt............."
openssl x509 -req -days 3650 -CA ca.crt -CAkey ca.key -CAcreateserial -in server.csr -out server.crt

echo ".............create client certificate signing request............."
SUBJECT="/C=CN/ST=CHINA/L=BEIJING/O=Client-CA/OU=IT/CN=$DOMAIN/emailAddress=test123@163.com"
openssl req -new -subj $SUBJECT -key client.key -out client.csr

echo ".............make client CA certificate signing crt............."
openssl x509 -req -days 3650 -CA ca.crt -CAkey ca.key -CAcreateserial -in client.csr -out client.crt



#!/usr/bin/env bash

sudo apt update
openssl req -x509 -newkey rsa:4096 -nodes -out cert.pem -keyout key.pem -days 365 -subj "/C=UK/ST=Lodon/L=London/O=SpartaGlobal/OU=Sparta/CN=Cyber/emailAddress=kdlugosz@spartaglobal.com"
sudo systemctl reload nginx
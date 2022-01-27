#!/usr/bin/bash
echo "Running initial update... "
sudo apt-get update
echo "Installing nginx... "
sudo apt-get install -y nginx-core
echo "Running initial update... "
sudo apt-get update
echo "Installing nginx... "
sudo apt-get install -y nginx-core
echo "Updating config and restarting nginx..."
sudo mv default /etc/nginx/sites-available
sleep 1
sudo systemctl restart nginx
echo "System Ready!"

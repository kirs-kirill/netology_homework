#!/bin/bash

echo "Start docker containers..."
docker run --name centos7 -id pycontribs/centos:7 
docker run --name ubuntu -id pycontribs/ubuntu 
docker run --name fedora -id lansible/fedora

# Ждем пока контейнеры запустятся
sleep 5

echo "Run playbook"
ansible-playbook site.yml -i inventory/prod.yml --ask-vault-pass

echo "Stop containers..."
docker stop centos7 ubuntu fedora

echo "Remove containers..."
docker rm centos7 ubuntu fedora

echo "Done!"
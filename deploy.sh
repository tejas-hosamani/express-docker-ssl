#!/bin/bash

# Fill these things:
REPO=https://github.com/CodingCreate101/express-docker-ssl.git
BRANCH=master
DIRECTORY=express-docker-ssl
REACT_APP_BACKEND_API_PATH=$(curl icanhazip.com)
REACT_APP_FRONT_END_URL=$(curl icanhazip.com)

git clone $REPO

cd $DIRECTORY

git fetch
git checkout $BRANCH
git pull origin $BRANCH
touch .env

# Get current IP of cloud and put it in .env - not recomended
echo REACT_APP_BACKEND_API_PATH=http://$REACT_APP_BACKEND_API_PATH:5000 > .env #http://$(curl icanhazip.com):5000 > .env
echo REACT_APP_FRONT_END_URL=http://$REACT_APP_FRONT_END_URL > .env #http://$(curl icanhazip.com) >> .env

cd ..

sudo apt-get update
sudo apt-get upgrade -y

sudo ufw allow 5000
sudo ufw allow 80

curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

sudo apt install docker-compose -y

sudo usermod -aG docker ubuntu
sudo apt install make -y

cd $DIRECTORY

sudo docker-compose build
sudo docker-compose up -d

# sudo docker volume create --name=mongo_data

# if makefile exists
# make build
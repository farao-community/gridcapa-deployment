#! /bin/bash

git clone https://github.com/farao-community/gridcapa-data-bridge
cd gridcapa-data-bridge
git checkout one-for-all
mvn clean 1> /dev/null 2> /dev/null && mvn package 1> /dev/null 2> /dev/null && docker build -t farao-local/gridcapa-data-bridge . 1> /dev/null 2> /dev/null
docker image tag farao-local/gridcapa-data-bridge:latest $(minikube ip):5000/farao-local/gridcapa-data-bridge:latest
docker push $(minikube ip):5000/farao-local/gridcapa-data-bridge:latest
cd ..
rm -rf gridcapa-data-bridge
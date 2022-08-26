#! /bin/bash


#create an alias for command simplicity
shopt -s expand_aliases
alias minikubectl="minikube kubectl --"

FTP_SERVER=`minikubectl get pods $(minikubectl get pods -n gridcapa | grep ftp-server | cut -d' ' -f1) -n gridcapa -o jsonpath={.status.podIP}`
	until [ -n "$FTP_SERVER" ] ; do
		echo "wait for the ftp-server to have an ip"
		sleep 3
		FTP_SERVER=`minikubectl get pods $(minikubectl get pods -n gridcapa | grep ftp-server | cut -d' ' -f1) -n gridcapa -o jsonpath={.status.podIP}`
	done
	

minikubectl get configmap env-configmap -n gridcapa -o=yaml > ./config-map.yaml
sed -i -E "s/(GRIDCAPA_SOURCE_HOST_.*): ([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3})/\1: $FTP_SERVER/" ./config-map.yaml
minikubectl apply -f config-map.yaml -n gridcapa 2> plop.txt

for pod in $(minikubectl get pods -n gridcapa | grep -E "(data-bridge|task-manager)" | cut -d' ' -f1);
do
	echo deleting $pod
	minikubectl delete -n gridcapa pod $pod
done
rm config-map.yaml


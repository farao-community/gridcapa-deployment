#! /bin/bash

#create an alias for command simplicity
shopt -s expand_aliases
alias minikubectl="minikube kubectl --"
NC='\033[0m' # No Color
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'

SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
cd $SCRIPTPATH

initial_config() {

	#check ingress is enabled
	minikube addons list | grep ingress | grep -q enabled
	if [ $? -eq 1 ]
	then
		minikube addons enable ingress
	fi
	
	#check registry is enabled
	minikube addons list | grep registry | grep -q enabled
	if [ $? = 1 ]
	then
		minikube addons enable registry
		#create registry ingress
		minikubectl apply -f ./registry/deploy-registry-ingress.yaml -n ingress-nginx
		
	fi
	
	#check namespace is created
	minikubectl get namespace | grep -q gridcapa
	if [ $? = 1 ]
	then
		minikubectl create namespace gridcapa
	fi
	
	#check for secrets
	minikubectl get secrets -n gridcapa | grep -q gridcapa-tls
	if [ $? = 1 ]
	then
		openssl genrsa -out ca.key 2048
		openssl req -x509 -new -nodes -days 365 -key ca.key -out ca.crt -subj "/CN=gridcapa-dev.farao-local-community.com"
		minikubectl create secret tls gridcapa-tls --key ca.key --cert ca.crt -n gridcapa
		rm -f ca.key ca.key ca.crt
		minikubectl create secret generic gridcapa-rabbitmq-credentials --from-literal='rabbitmq-user=gridcapa' --from-literal='rabbitmq-password=gridcapa' -n gridcapa
		minikubectl create secret generic admin-rabbitmq-credentials --from-literal='rabbitmq-user=gridcapa' --from-literal='rabbitmq-password=gridcapa' -n gridcapa
		minikubectl create secret generic rabbitmq-secrets --from-literal='rabbitmq-erlang-cookie=gridcapa' -n gridcapa
		minikubectl create secret generic gridcapa-minio-credentials --from-literal='minio-access-key=gridcapa' --from-literal='minio-secret-key=gridcapa' -n gridcapa
		minikubectl create secret generic gridcapa-ftp-credentials --from-literal='ftp-user=gridcapa' --from-literal='ftp-password=gridcapa' -n gridcapa
		minikubectl create secret generic gridcapa-sftp-credentials --from-literal='sftp-user=gridcapa' --from-literal='sftp-password=gridcapa' -n gridcapa
		minikubectl create secret generic gridcapa-filebrowser-credentials --from-literal='fb-user=gridcapa' --from-literal='fb-encrypted-password=gridcapa' -n gridcapa
		minikubectl create secret generic gridcapa-postgresql-credentials --from-literal='postgres-password=gridcapa' --from-literal='config-user=gridcapa' --from-literal='config-password=gridcapa' --from-literal='cse-idcc-user=gridcapa' --from-literal='cse-idcc-password=gridcapa' --from-literal='cse-import-d2cc-user=gridcapa' --from-literal='cse-import-d2cc-password=gridcapa' --from-literal='core-valid-user=gridcapa' --from-literal='core-valid-password=gridcapa' --from-literal='cse-import-idcc-user=gridcapa' --from-literal='cse-import-idcc-password=gridcapa' --from-literal='cse-export-d2cc-user=gridcapa' --from-literal='cse-export-d2cc-password=gridcapa' --from-literal='cse-export-idcc-user=gridcapa' --from-literal='cse-export-idcc-password=gridcapa' -n gridcapa
		minikubectl create secret generic gridcapa-keycloak-credentials --from-literal='keycloak-user=gridcapa' --from-literal='keycloak-password=gridcapa' -n gridcapa
	fi
	
	#check for persistent volumes
	minikubectl get persistentvolume -n gridcapa | grep -q azure-storage-class
	if [ $? = 1 ]
	then	
		#create persistant volumes
		minikubectl apply -f ./volumes/minikube-volumes.yaml -n gridcapa

	fi	

}


deploy () {

	initial_config
	
	#deploy ftp and ftp-filebrowser
	minikubectl apply -f ./ftp/deploy-ftp.yaml -n gridcapa
	echo -e "$(minikube ip)\tfilebrowser.farao-local-community.com" >> /etc/hosts
	
	#deploy postgresql
	minikubectl apply -f ./postgresql/deploy-postgresql.yaml -n gridcapa
	
	
	#deploy minio
	minikubectl apply -f ./minio/deploy-minio.yaml -n gridcapa
	echo -e "$(minikube ip)\tminio.farao-local-community.com" >> /etc/hosts
	
	
	#deploy rabbitmq
	minikubectl apply -f ./rabbitmq/deploy-rabbitmq.yaml -n gridcapa
	echo -e "$(minikube ip)\trabbitmq.farao-local-community.com" >> /etc/hosts
	

	#deploy keycloak
	minikubectl apply -f ./keycloak/deploy-keycloak.yaml -n gridcapa
	echo -e "$(minikube ip)\tauth.farao-local-community.com" >> /etc/hosts 
	#deploy the gateway
	minikubectl apply -f ./gateway/deploy-gateway.yaml -n gridcapa

	#deploy an ingress in order to skip auth
	minikubectl apply -f ./no-keycloak/deploy-no-keycloak.yaml -n gridcapa
	echo -e "$(minikube ip)\tgridcapa-dev.farao-local-community.com" >> /etc/hosts 
	echo -e "$(minikube ip)\tgridcapa-dev-no-auth.farao-local-community.com" >> /etc/hosts 
	
	
	#deploy rao-runner
	minikubectl apply -f ./rao-runner/deploy-rao-runner.yaml -n gridcapa	
	
	#deploy the confi-server-notification$
	minikubectl apply -f ./config-server-notification/deploy-config-server-notification.yaml -n gridcapa
	
	#deploy apps-metadata-server
	minikubectl apply -f ./apps-metadata/deploy-apps-metadata-server.yaml -n gridcapa

	#deploy databridge
	minikubectl apply -f ./bridge/deploy-data-bridge.yaml -n gridcapa
	
	
	#deploy runner common configuration
	minikubectl apply -f ./runner/deploy-runner-config.yaml -n gridcapa
	
	
	#deploy the config-server
	FTP_SERVER=`minikubectl get pods $(minikubectl get pods -n gridcapa | grep ftp-server | cut -d' ' -f1) -n gridcapa -o jsonpath={.status.podIP}`
	until [ -n "$FTP_SERVER" ] ; do
		echo "wait for the ftp-server to have an ip"
		sleep 3
		FTP_SERVER=`minikubectl get pods $(minikubectl get pods -n gridcapa | grep ftp-server | cut -d' ' -f1) -n gridcapa -o jsonpath={.status.podIP}`
	done
	sed "s/13.80.7.121/`minikubectl get pods $(minikubectl get pods -n gridcapa | grep ftp-server | cut -d' ' -f1) -n gridcapa -o jsonpath={.status.podIP}`/g" ./config-server/gridcapa-env-configmap.yaml > ./config-server/gridcapa-env-configmap-configured.yaml
	minikubectl apply -f ./config-server/gridcapa-env-configmap-configured.yaml -n gridcapa
	minikubectl apply -f ./config-server/deploy-config-server.yaml -n gridcapa
}

replace() {
	while read -r result; do
		file=`echo "$result" | cut -d':' -f1`
		current=`echo "$result" | cut -d':' -f3- | xargs`
		read -p "$( echo -e in ${GREEN}${file}${NC} replace ${RED}${current}${NC} with \(leave empty to keep it\) :  )" replace </dev/tty
		if [ -n "$replace" ] 
		then
			sed -i "s&image: ${current}&image: ${replace}&g" "$file"
		fi
	done < <(grep -r "image:" ./* | grep -v $0)
	
	deploy
	
}


echo -e "Please check images versions are corrects :\n"
grep -r "image:" ./* | grep -v $(basename "$0") | grep -v "data-bridge.tar" | awk -v g="${GREEN}" -v n="${NC}" -v b="${BLUE}" -F'image:' '{print g$1n" => "b$2n}' | column -t
read -p "Is it correct ? (yes/no) " yn

case $yn in 
	yes | y | Y ) deploy ;;
	no | n | N ) replace ;;
		
	* ) echo invalid response;
		exit 1;;
esac



 

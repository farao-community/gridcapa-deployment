#! /bin/bash

#create an alias for command simplicity
shopt -s expand_aliases
alias minikubectl="minikube kubectl --"
NC='\033[0m' # No Color
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'

FIRST_PARAM=$1
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
cd $SCRIPTPATH

deploy () {

	#deploy cse-adapter
	minikubectl apply -f ./adapter/deploy-adapter.yaml -n gridcapa

	#deploy output exporter
	minikubectl apply -f ./exporter/deploy-exporter.yaml -n gridcapa

	#deploy gridcapa-app
	if [ "$FIRST_PARAM" = "--no-keycloak" ]
	then
		sed -i "s/value: 'true'/value: 'false'/"	./gridcapa-app/deploy-gridcapa-app.yaml
	else
		sed -i "s/value: 'false'/value: 'true'/"	./gridcapa-app/deploy-gridcapa-app.yaml
	fi
	minikubectl apply -f ./gridcapa-app/deploy-gridcapa-app.yaml -n gridcapa

	#deploy job-launcher
	minikubectl apply -f ./job-launcher/deploy-job-launcher.yaml -n gridcapa

	#deploy rao-log-dispatcher
	minikubectl apply -f ./rao-log-dispatcher/deploy-rao-log-dispatcher.yaml -n gridcapa

	#deploy cse-runner
	minikubectl apply -f ./runner/deploy-runner.yaml -n gridcapa

	#deploy task-manager
	minikubectl apply -f ./task-manager/deploy-task-manager.yaml -n gridcapa
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
	done < <(grep -r "image:" ./* | grep -v $(basename "$0"))
	
	deploy
	
}

echo -e "Please check images versions are corrects :\n"
grep -r "image:" ./* | grep -v $(basename "$0") | awk -v g="${GREEN}" -v n="${NC}" -v b="${BLUE}" -F'image:' '{print g$1n" => "b$2n}' | column -t
read -p "Is it correct ? (yes/no) " yn

case $yn in 
	yes | y | Y ) deploy ;;
	no | n | N ) replace ;;
		
	* ) echo invalid response;
		exit 1;;
esac



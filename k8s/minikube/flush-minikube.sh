#! /bin/bash


#create an alias for command simplicity
shopt -s expand_aliases
alias minikubectl="minikube kubectl --"

minikubectl delete all --all -n gridcapa
minikubectl delete --all configmaps -n gridcapa
minikubectl delete --all ingress -n gridcapa
minikubectl delete -n gridcapa secret rabbitmq-secrets
minikubectl delete -n gridcapa secret gridcapa-tls
minikubectl delete -n gridcapa secret gridcapa-sftp-credentials
minikubectl delete -n gridcapa secret gridcapa-rabbitmq-credentials
minikubectl delete -n gridcapa secret gridcapa-postgresql-credentials
minikubectl delete -n gridcapa secret gridcapa-minio-credentials
minikubectl delete -n gridcapa secret gridcapa-keycloak-credentials
minikubectl delete -n gridcapa secret gridcapa-ftp-credentials
minikubectl delete -n gridcapa secret gridcapa-filebrowser-credentials
minikubectl delete -n gridcapa secret admin-rabbitmq-credentials

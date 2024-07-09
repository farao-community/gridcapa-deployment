# GridCapa deployment module
[![MPL-2.0 License](https://img.shields.io/badge/license-MPL_2.0-blue.svg)](https://www.mozilla.org/en-US/MPL/2.0/)

This repository contains all the deployment files for GridCapa applications:

- Docker Compose scripts for test and development usage
- Kubernetes scripts for production usage

## Deploying using Docker Compose

GridCapa framework instantiates different GridCapa applications by business process.
Docker Compose scripts are designed to run all GridCapa applications independently.

GridCapa currently contains the following applications:
- Gridcapa CORE CC
- GridCapa CORE Validation
- GridCapa CSE EXPORT D2CC
- GridCapa CSE EXPORT IDCC
- GridCapa CSE IMPORT D2CC
- GridCapa CSE IMPORT IDCC
- GridCapa CSE IMPORT_EC D2CC
- GridCapa CSE IMPORT_EC IDCC
- GridCapa SWE BTCC
- GridCapa SWE D2CC
- GridCapa SWE IDCC DACF
- GridCapa SWE IDCC IDCF


### Prerequisites

Docker Compose scripts needs Docker (version >= 18) and docker-compose.

#### Default GridCapa environment

First, you need to deploy the common base of GridCapa application :
```bash
cd docker-compose/common
docker-compose up -d
```

Then, you can deploy independently any process you want. For example to deploy CSE IMPORT D2CC :
```bash
cd docker-compose/cse-import-d2cc
docker-compose up -d
```

After deploying the processes you needed, you will have to modify the nginx.conf file in docker-compose/nginx by commenting 
the sections you don't need in the upstreams and in the locations. In IntelliJ, to comment, select the block 
and click on ctrl + /. After that you can deploy nginx :
```bash
cd docker-compose/nginx
docker-compose up -d
```

**Be careful to your local resources if you try to deploy too many processes it could be quite heavy.**

Multiple environment are available:
- Main GridCapa UI on pages : http://localhost/core/cc/, http://localhost/core/valid/, http://localhost/cse/export/d2cc/, http://localhost/cse/export/idcc/, http://localhost/cse/import/d2cc/, http://localhost/cse/import/idcc/, http://localhost/cse/import-ec/d2cc/, http://localhost/cse/import-ec/idcc/, http://localhost/swe/btcc/, http://localhost/swe/d2cc/, http://localhost/swe/idcc/, http://localhost/swe/idcf/ according to what has been deployed.
- FTP server file browser on page http://localhost/utils/filebrowser/. Default credentials are gridcapa/gridcapa.
- SFTP server file browser on page http://localhost/utils/filebrowser/. Default credentials are gridcapa/gridcapa.
- RabbitMQ management UI on page http://localhost/utils/rabbitmq/. Default credentials are gridcapa/gridcapa.
- MinIO browser on page http://localhost/minio/. Default credentials are gridcapa/gridcapa.

#### Specific GridCapa front-end app development environment 

```bash
cd docker-compose-for-front-end-development
docker-compose up -d
```
- Now you have the gridcapa back-end running with docker-compose 
- Then run locally gridcapa-app following the application [README](https://github.com/farao-community/gridcapa-app/blob/master/README.md).
- You should be able now to debug locally your front-end application

### MinIO bucket notifications

GridCapa platform needs bucket notifications activated on MinIO server to run correctly.

First, start by downloading [MinIO client application](https://docs.min.io/docs/minio-client-quickstart-guide).
Then add the MinIO server to the list of servers available:
```bash
./mc alias set gridcapa_compose http://localhost:9000 gridcapa gridcapa
```
Check correct connectivity:
```bash
./mc ls gridcapa_compose
```

Register all PULL and DELETE events to be notified by MinIO in the RabbitMQ broker. MinIO bucket ARN (here*arn:minio:sqs::_:amqp*)
can be obtained in MinIO logs at startup.

```bash
./mc event add gridcapa_compose/gridcapa arn:minio:sqs::_:amqp --event put,delete
```

Check that they have been correctly saved by listing current notifications enabled.

```bash
./mc event list gridcapa_compose/gridcapa
```

### XPRESS Solver licence
Xpress is a commercial solver and as such requires a licence to be used. 
Please copy yours (xprauth.xpr file) inside the following folder :

```bash
docker-compose/common/xpr-licence
```


## Deploying using Kubernetes

Kubernetes deployment is still under development. This documentation is still to be provided.

### Prerequisites

Some secrets are needed on the cluster as deployment prerequisites. Encrypted password can be obtained by default bcrypt algorithm.

```bash
kubectl create secret generic gridcapa-rabbitmq-credentials --from-literal='rabbitmq-user=<RABBITMQ_USER>' --from-literal='rabbitmq-password=<RABBITMQ_PASSWORD>'
kubectl create secret generic admin-rabbitmq-credentials --from-literal='rabbitmq-user=<RABBITMQ_USER>' --from-literal='rabbitmq-password=<RABBITMQ_PASSWORD>'
kubectl create secret generic rabbitmq-secrets --from-literal='rabbitmq-erlang-cookie=<RABBITMQ_ERLANG_COOKIE>'
kubectl create secret generic gridcapa-minio-credentials --from-literal='minio-access-key=<MINIO_ACCESS_KEY>' --from-literal='minio-secret-key=<MINIO_SECRET_KEY>'
kubectl create secret generic gridcapa-ftp-credentials --from-literal='ftp-user=<FTP_USER>' --from-literal='ftp-password=<FTP_PASSWORD>'
kubectl create secret generic gridcapa-postgresql-credentials --from-literal='postgres-password=<POSTGRES_PASSWORD>' --from-literal='config-user=<CONFIG_USER>' --from-literal='config-password=<CONFIG_PASSWORD>' --from-literal='core-cc-user=<CORE_CC_USER>' --from-literal='core-cc-password=<CORE_CC_PASSWORD>' --from-literal='core-valid-user=<CORE_VALID_USER>' --from-literal='core-valid-password=<CORE_VALID_PASSWORD>' --from-literal='cse-export-d2cc-user=<CSE_EXPORT_D2CC_USER>' --from-literal='cse-export-d2cc-password=<CSE_EXPORT_D2CC_PASSWORD>' --from-literal='cse-export-idcc-user=<CSE_EXPORT_IDCC_USER>' --from-literal='cse-export-idcc-password=<CSE_EXPORT_IDCC_PASSWORD>' --from-literal='cse-import-d2cc-user=<CSE_IMPORT_D2CC_USER>' --from-literal='cse-import-d2cc-password=<CSE_IMPORT_D2CC_PASSWORD>' --from-literal='cse-import-idcc-user=<CSE_IMPORT_IDCC_USER>' --from-literal='cse-import-idcc-password=<CSE_IMPORT_IDCC_PASSWORD>' --from-literal='cse-import-ec-d2cc-user=<CSE_IMPORT_EC_D2CC_USER>' --from-literal='cse-import-ec-d2cc-password=<CSE_IMPORT_EC_D2CC_PASSWORD>' --from-literal='cse-import-ec-idcc-user=<CSE_IMPORT_EC_IDCC_USER>' --from-literal='cse-import-ec-idcc-password=<CSE_IMPORT_EC_IDCC_PASSWORD>' --from-literal='cse-valid-d2cc-user=<CSE_VALID_D2CC_USER>' --from-literal='cse-valid-d2cc-password=<CSE_VALID_D2CC_PASSWORD>' --from-literal='cse-valid-idcc-user=<CSE_VALID_IDCC_USER>' --from-literal='cse-valid-idcc-password=<CSE_VALID_IDCC_PASSWORD>' --from-literal='swe-btcc-user=<SWE_BTCC_USER>' --from-literal='swe-btcc-password=<SWE_BTCC_PASSWORD>' --from-literal='swe-d2cc-user=<SWE_D2CC_USER>' --from-literal='swe-d2cc-password=<SWE_D2CC_PASSWORD>' --from-literal='swe-idcc-user=<SWE_IDCC_USER>' --from-literal='swe-idcc-password=<SWE_IDCC_PASSWORD>' --from-literal='swe-idcc-idcf-user=<SWE_IDCC_IDCF_USER>' --from-literal='swe-idcc-idcf-password=<SWE_IDCC_IDCF_PASSWORD>'
kubectl create secret generic gridcapa-keycloak-credentials --from-literal='keycloak-user=<KEYCLOAK_USER>' --from-literal='keycloak-password=<KEYCLOAK_PASSWORD>'
kubectl create secret tls gridcapa-tls --key <private key file> --cert <certificate file>
```
### MinIO bucket notifications

GridCapa platform needs bucket notifications activated on MinIO server to run correctly.

First, start by downloading [MinIO client application](https://docs.min.io/docs/minio-client-quickstart-guide).
Then add the MinIO server to the list of servers available:
```bash
./mc alias set gridcapa_k8s <minio-url> <minio-user> <minio-password>
```
Check correct connectivity:
```bash
./mc ls gridcapa_k8s
```

Register all PULL and DELETE events to be notified by MinIO in the RabbitMQ broker. MinIO bucket ARN (here*arn:minio:sqs::_:amqp*)
can be obtained in MinIO logs at startup.

```bash
./mc event add gridcapa_k8s/gridcapa arn:minio:sqs::_:amqp --event put,delete
```

Check that they have been correctly saved by listing current notifications enabled.

```bash
./mc event list gridcapa_k8s/gridcapa
```

### Deployment of authentication for Azure
There is a specific folder overlays/azure/authentication/ that enables to deploy a homemade keycloak solution. It will
then be used by gridcapa-app with authentication to get a token, so that gateway can identify the user.

It will be deployed in default namespace but is completely independent of azure dev deployment that concerns GridCapa 
applications. 

It is deployed on a different ingress controller and the address is auth.farao-community.com, on which you can reach
admin keycloak UI.

### Deployment on Azure DEV
This environment is used for CI for all gridcapa processes

- host: gridcapa-dev.farao-community.com
- namespace: default

```bash
kubectl kustomize k8s/overlays/azure/dev --load-restrictor LoadRestrictionsNone |  ssh -o "ProxyCommand=connect-proxy -H proxy-metier:8080 %h %p"  farao@51.137.209.168 kubectl apply -f -
```

Info: need to install connect-proxy with "dzdo apt install connect-proxy"

### Deployment on Azure TEST
This environment is used to test CSE gridcapa processes for CORESO

- host: gridcapa.farao-community.com
- namespace: gridcapa

```bash
kubectl kustomize k8s/overlays/azure/test --load-restrictor LoadRestrictionsNone |  ssh -o "ProxyCommand=connect-proxy -H proxy-metier:8080 %h %p"  farao@51.137.209.168 kubectl apply -n gridcapa -f -
```


### Using local gridcapa-app

In order to be able to use a local gridcapa-app and all elements deployed in the docker environment, you have to deal with CORS limitation.
In react when you locally launch gridcapa-app, it will be available on localhost:3000 (typically) but all others services in dockers are available through the nginx server at localhost.
The web browser see that "localhost:3000" and "localhost" are different, so it is a cross domain request and that's not allowed.

In order to avoid this, a new docker-compose is available in the folder nginx-dev. This nginx acts as a proxy in order to redirect a request to the gridcapa-app to the local instance.

Before using it you must modify the file nginx.conf in the folder nginx-dev.

on line 22 you will find :
```
    upstream front-end-local-dev {
        server 172.17.0.1:3000;
    }
```
this line is responsible to redirect the request to your local instance of gridcapa-app. You have to put the correct IP adress.
the correct IP is shown when the react gridcapa-app runs for example :

```
You can now view gridcapa-app in the browser.

  Local:            http://localhost:3000
  On Your Network:  http://10.135.83.74:3000
```
For the example you have to use the second address. **Do not use localhost:3000**.

When the nginx-dev docker is up you can access to the gridcapa-app with the url "http://localhost/cse/export/d2cc/".
Don't forget to change the REACT_APP_PUBLIC_URL variable in the .env.development file to the corresponding URL.

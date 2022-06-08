# GridCapa deployment module
[![MPL-2.0 License](https://img.shields.io/badge/license-MPL_2.0-blue.svg)](https://www.mozilla.org/en-US/MPL/2.0/)

This repository contains all the deployment files for GridCapa applications:

- Docker Compose scripts for test and development usage
- Kubernetes scripts for production usage

## Deploying using Docker Compose

GridCapa framework instantiates different GridCapa applications by business process.
Docker Compose scripts are designed to run all GridCapa applications independently.

GridCapa currently contains the following applications:
- GridCapa CSE IMPORT D2CC
- GridCapa CSE IMPORT IDCC
- GridCapa CSE EXPORT D2CC
- GridCapa CSE EXPORT IDCC
- GridCapa CORE Validation

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
- Main GridCapa UI on pages : http://localhost/cse/import/d2cc/, http://localhost/cse/import/idcc/, http://localhost/cse/export/d2cc/,http://localhost/cse/export/idcc/, http://localhost/core/valid/, according to what has been deployed.
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
kubectl create secret generic gridcapa-postgresql-credentials --from-literal='postgres-password=<POSTGRES_PASSWORD>' --from-literal='config-user=<CONFIG_USER>' --from-literal='config-password=<CONFIG_PASSWORD>' --from-literal='cse-import-idcc-user=<CSE_IMPORT_IDCC_USER>' --from-literal='cse-import-idcc-password=<CSE_IMPORT_IDCC_PASSWORD>' --from-literal='cse-import-d2cc-user=<CSE_IMPORT_D2CC_USER>' --from-literal='cse-import-d2cc-password=<CSE_IMPORT_D2CC_PASSWORD>' --from-literal='cse-export-idcc-user=<CSE_EXPORT_IDCC_USER>' --from-literal='cse-export-idcc-password=<CSE_EXPORT_IDCC_PASSWORD>' --from-literal='cse-export-d2cc-user=<CSE_EXPORT_D2CC_USER>' --from-literal='cse-export-d2cc-password=<CSE_EXPORT_D2CC_PASSWORD>' --from-literal='core-valid-user=<CORE_VALID_USER>' --from-literal='core-valid-password=<CORE_VALID_PASSWORD>'
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

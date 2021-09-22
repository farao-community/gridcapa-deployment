# GridCapa deployment module
[![MPL-2.0 License](https://img.shields.io/badge/license-MPL_2.0-blue.svg)](https://www.mozilla.org/en-US/MPL/2.0/)

This repository contains all the deployment files for GridCapa applications:

- Docker Compose scripts for test and development usage
- Kubernetes scripts for production usage

## Deploying using Docker Compose

Docker Compose scripts are designed to run all GridCapa applications independently. A
GridCapa application is an instanciation of GridCapa framework for a given business process.

GridCapa currently contains the following applications.
- GridCapa CSE D2CC
- GridCapa CORE Validation

### Prerequisites

Docker Compose scripts needs Docker (version >= 18) and docker-compose.

### Deployment

#### GridCapa CSE D2CC

```bash
cd docker-compose/cse/d2cc
docker-compose up -d
```

Multiple environment are available:
- Main GridCapa UI on page http://localhost/cse/d2cc.
- FTP server file browser on page http://localhost/utils/filebrowser. Default credentials are gridcapa/gridcapa.
- RabbitMQ management UI on page http://localhost/utils/rabbitmq. Default credentials are gridcapa/gridcapa.
- MinIO browser on page http://localhost/minio. Default credentials are gridcapa/gridcapa.

#### GridCapa CORE Validation

```bash
cd docker-compose/core/valid
docker-compose up -d
```

Multiple environment are available:
- Main GridCapa UI on page http://localhost/core/valid.
- SFTP server file browser on page http://localhost/utils/filebrowser. Default credentials are gridcapa/gridcapa.
- RabbitMQ management UI on page http://localhost/utils/rabbitmq. Default credentials are gridcapa/gridcapa.
- MinIO browser on page http://localhost/minio. Default credentials are gridcapa/gridcapa.

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
kubectl create secret generic gridcapa-ftp-credentials --from-literal='ftp-user=<FTP_USER>' --from-literal='ftp-password=<FTP_PASSWORD>' --from-literal='ftp-encrypted-password=<FTP_ENCRYPTED_PASSWORD>'
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

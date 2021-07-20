# GridCapa deployment module
[![MPL-2.0 License](https://img.shields.io/badge/license-MPL_2.0-blue.svg)](https://www.mozilla.org/en-US/MPL/2.0/)

This repository contains all the deployment files for GridCapa application:

- Docker Compose scripts for test and development usage
- Kubernetes scripts for production usage

## Deploying using Docker Compose

### Prerequisites

Docker Compose scripts needs Docker (version >= 18) and docker-compose.

### Deployment

```bash
cd docker-compose
docker-compose up -d
```

Multiple environment are available:
- Main GridCapa UI on page http://localhost/cse/d2cc.
- FTP server file browser on page http://localhost/utils/filebrowser. Default credentials are gridcapa/gridcapa.
- RabbitMQ management UI on page http://localhost/utils/rabbitmq. Default credentials are gridcapa/gridcapa.

## Deploying using Kubernetes

Kubernetes deployment is still under development. This documentation is still to be provided.

### Prerequisites

Some secrets are needed on the cluster as deployment prerequisites.

```bash
kubectl create secret generic gridcapa-rabbitmq-credentials --from-literal='rabbitmq-user=<RABBITMQ_USER>' --from-literal='rabbitmq-password=<RABBITMQ_PASSWORD>'
kubectl create secret generic admin-rabbitmq-credentials --from-literal='rabbitmq-user=<RABBITMQ_USER>' --from-literal='rabbitmq-password=<RABBITMQ_PASSWORD>'
kubectl create secret generic rabbitmq-secrets --from-literal='rabbitmq-erlang-cookie=<RABBITMQ_ERLANG_COOKIE>'
```

If deploying integrated dev version including FTP server and browser, some secrets must be created on Kubernetes cluster.
Encrypted password can be obtained by default bcrypt algorithm. 

```bash
kubectl create secret generic gridcapa-ftp-credentials --from-literal='ftp-user=<FTP_USER>' --from-literal='ftp-password=<FTP_PASSWORD>' --from-literal='ftp-encrypted-password=<FTP_ENCRYPTED_PASSWORD>'
```

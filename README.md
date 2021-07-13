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

Then open your favorite browser on page http://localhost/cse/d2cc.

## Deploying using Kubernetes

Kubernetes deployment is still under development. This documentation is still to be provided.

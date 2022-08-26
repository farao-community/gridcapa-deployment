Before starting installing, be aware that I configure all of this in my particular environnement. I have made some script that help to deploy and these script will rewrite the yaml files on the fly when needed.

Second point, I used my unified version of data-bridge to reduce the complexity. I try to include this particular image but its is too big for github. So It is up to you to get the sources and build the image localy (see chapter 14)


# 1. Installation de minikube sur ubuntu :
```bash    
cd
mkdir minikube
cd $_
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb
sudo dpkg -i minikube_latest_amd64.deb
```
# 2. Hardware configuration for minikube
## 2.1 Collect information
The first step is to determine the total of memoy on your computer
```bash	
free -m
              total       utilisé      libre     partagé tamp/cache   disponible
Mem:          31830       11612       10819        1479        9399       18327
Partition d'échange:        7811           0        7811	
```
In the above example the important value is the total : 31830  

Now we have to check the number of available CPU  
```bash
lscpu | grep "Processeur(s)"
Processeur(s) :                         16
```
In the above example ther is 16 CPUs available.

## 2.2 Configuration for minikube

In function of the previous results set the configuration for minikube. In the example in chapter 2.1 there is on the machine 31830 Mo of RAM and 16 processors.
I will use 14 processors and 30720 Mo of memory for minikube :

```bash	
minikube config set cpus 14
minikube config set memory 30720
```
minikube will not use the total of his ressources at every time.
	
	
# 3. Configure environnement variable for the proxy : 
In the RTE facilities you need to set environnemental variable for the proxy. minikube will use them for his network connection.
```bash
export HTTP_PROXY=http://<login>:<password>@proxy-config.interne:8081
export HTTPS_PROXY=http://<login>:<password>@proxy-config.interne:8081
export NO_PROXY=minio,localhost,127.0.0.0/8,rte-france.com,192.168.49.2,172.17.0.1,auth.farao-local-community.com,gridcapa-dev.farao-local-community.com
```
in order to run command for minikube I create an alias. This alias is defined and use used in all shell script.
With this alias you don't need to modify an existing configuration of kubectl and you can't deploy something on the wrong envirnnement.
```bash
alias minikubectl="minikube kubectl --"
```
You can add the alias at the end of your "~/.bashrc" file
```bash
echo 'alias minikubectl="minikube kubectl --"' >> ~/.bashrc
source ~/.bashrc
```

# 3. Minikube common commands

## 3.1 Start minikube :
```bash
minikube start	
```

## 3.2 Stop minikube :
```bash
minikube stop	
```

## 3.2 Delete minikube :
```bash
minikube delete	
```

	
# 4. Deployment of common element in gridcapa CSE

Use the deployment script in the common folder. This script is very important because it finishes to configure minikube.  
1. enable the ingress capability
2. enable local registry which you can use in order to import your own docker.  
3. create the namespace gridcapa which will be used for all future deployment  
4. configure all secret and persistent volumes   
5. ask if the images used in the deployment are correct. If they are not correct you will have to redefine them.  
 

**VERY VERY IMPORTANT** : be sure that the pod ftp-server does not restart or its IP adress may change and some functionnality will be lost (see chapter 12)
	
```bash	
cd ./common
./deploy-common.sh
```

Once the script finished you can acces :
- keycloak via the url : **auth.farao-local-community.com**
- rabbitmq via the url : **rabbitmq.farao-local-community.com**
- minio via the url : **minio.farao-local-community.com**
- file-browser via the url : **filebrowser.farao-local-community.com**


You now have to configure keycloak (if you don't want see chapter 11) :
- Create a new realm named "**Gridcapa**" (the case is important), with FrontEnd URL "**https://auth.farao-local-community.com**"
- Create a new client named "**gridcapa-dev**". You juste have to check if the option "*Implicit Flow Enabled*" is on
- Create a user. The following fields are mandatory : Username, Email, First Name, Last Name. **If they are empty you will not be abble to log in**
- Set the password of all your user 
	
	
	


# 5. Deploy the export D2CC

use the deployment script in the export-d2cc folder.
```bash
cd ./export-d2cc
./deploy-export-d2cc.sh
```
the script deploy eveything needed for the process.
you can acces the process via the url : **https://gridcapa-dev.farao-local-community.com/cse/export/d2cc**

if you disable keycloak (see chapter 11) : https://gridcapa-dev-no-auth.farao-local-community.com/cse/export/d2cc


# 6. Deploy the export IDCC

use the deployment script in the export-idcc folder.
```bash
cd ./export-idcc
./deploy-export-idcc.sh
```
the script deploy eveythind needed
you can acces the process via the url : **https://gridcapa-dev.farao-local-community.com/cse/export/idcc**

if you disable keycloak (see chapter 11) : https://gridcapa-dev-no-auth.farao-local-community.com/cse/export/idcc

# 7. Deploy import D2CC

use the deployment script in the import-d2cc folder.
```bash
cd ./import-d2cc
./deploy-import-d2cc.sh
```
the script deploy eveythind needed
you can acces the process via the url : **https://gridcapa-dev.farao-local-community.com/cse/import/d2cc**

if you disable keycloak (see chapter 11) : https://gridcapa-dev-no-auth.farao-local-community.com/cse/import/d2cc

# 8. Deploy import IDCC

use the deployment script in the import-idcc folder.
```bash
#cd ./import-idcc
#./deploy-import-idcc.sh
```
the script deploy eveythind needed
you can acces the process via the url : **https://gridcapa-dev.farao-local-community.com/cse/import/idcc**

if you disable keycloak (see chapter 11) : https://gridcapa-dev-no-auth.farao-local-community.com/cse/import/idcc

# 9. Deploy core valid

**WARNING**: When these lines are written the latest core-valid-runner available on docker.io is not abble to deserialize the response of the latest rao-runner available on docker.io:
*"Cannot deserialize RaoResult: unexpected field (angleCnecResults)"*  

use the deployment script in the core-valid folder.
```bash
cd ./core-valid
./deploy-core-valid.sh
```
the script deploy eveythind needed
you can acces the process via the url : **https://gridcapa-dev.farao-local-community.com/core/valid**
	
if you disable keycloak (see chapter 11) : https://gridcapa-dev-no-auth.farao-local-community.com/core/valid



# 10. How to deploy your own docker image

- first you have to build your image for example you create the image : *my-new-image:latest*
- You have to tag it in order to be abble to push it to another registry : 
```bash
docker image tag my-new-image:latest $(minikube ip):5000/my-new-image:latest
```
- now push the image to the minikube registry :
```bash
docker push $(minikube ip):5000/my-new-image:latest
```
- when you want to use it inside minikube you have to change the "image" field in the container specification of your deployment. 


**VERY IMPORTANT when you want to use it in minikube you have to specified on which registry the image can be found. In our case it will be *127.0.0.1:5000/my-new-image:latest*
you can use the bash script to update your deployment files. When asking if images are correct say "no" and set the right value to the right deployment**



# 11. How to disable keycloak login

If you don't want to configure keycloak you can disable it. In all deployment script (except common), you can add an extra parameter *"--no-keycloak"* in order to change the gridcapa-app behavior. For example :
```bash
./deploy-import-idcc.sh --no-keycloak
```
With this extra parameter, when the pod gridcapa-app starts, it will modify some of his own file. This functionnality has been insert in the deployment file (yaml) of each gridcapa, you have to look after the "*lifecycle*" word in the yaml file to see how it is done (tips : it is very ugly). 


**WARNING** : if you disable keycloak, you will have to change the url for access. instead of "gridcapa-dev.farao-local-community.com" you have to hit "gridcapa-dev-no-auth.farao-local-community.com"

**WARNING**: When you disable keycloak there is a little side effect. The request for getting link of others processes will fail (https://gridcapa-dev.farao-local-community.com/apps-metadata/apps-metadata.json) because of a cross site request
	 
# 12. reset the ftp-server IP adress
	
If the FTP server change his internal IP, you will not be abble to manipulate entry files. It will affect all data-bridges and the task-manager. 
In order to solve this situation, you have to get the new IP adress of the pod, report it in the config map "env-configmap" and restart the impacted pods.

All theese steps are automaticaly done with the script *set-ftp-server-ip.sh*

# 13. Flushing minikube

If you want to wipe all deployment, you can use the script *flush-minikube.sh*. This script will only keep the persistent volumes. All other element are wipe (deployment, statefullstate, configmap, service, ingress and secret)

# 14. Unified data bridge

In order to simplify deployment you can use the unified data bridge currently in code review.
The script "unified-data-bridge.sh" will get the sources, build the image and push it to minikube.
otherwise you can manualy add all conventional data-bridge and configuration in each process.
It is an exemple for the chapter 10
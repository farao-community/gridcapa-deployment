import yaml
import os
import argparse

parser = argparse.ArgumentParser()
parser.add_argument("--kustomize")
args = parser.parse_args()

with open(args.kustomize) as file:
    document = yaml.load(file, Loader=yaml.FullLoader)

    for image in document['images']:
        imageDockerIoToPull = image['newName'] + ":" + image['newTag']
        print("image to pull "+ imageDockerIoToPull)
        os.system("docker pull " + imageDockerIoToPull)
        # replace tag by inca.rte-france.com/gridcapa
        if "docker.io/rabbitmq" in image['newName']:
            imageIncaToPush = imageDockerIoToPull.replace("docker.io/", "inca.rte-france.com/gridcapa/")
        if "docker.io/springcloudstream/" in image['newName']:
            imageIncaToPush = imageDockerIoToPull.replace("docker.io/springcloudstream/", "inca.rte-france.com/gridcapa/")
        if "docker.io/bitnami/" in image['newName']:
            imageIncaToPush = imageDockerIoToPull.replace("docker.io/bitnami/", "inca.rte-france.com/gridcapa/")
        if "docker.io/farao/" in image['newName']:
           imageIncaToPush = imageDockerIoToPull.replace("docker.io/farao/", "inca.rte-france.com/gridcapa/")
        if "docker.io/gridsuite/" in image['newName']:
           imageIncaToPush = imageDockerIoToPull.replace("docker.io/gridsuite/", "inca.rte-france.com/gridcapa/")

        print("image to push "+ imageIncaToPush)
        # replace tag by inca.rte-france.com/gridcapa
        os.system("docker tag " + imageDockerIoToPull + " " + imageIncaToPush)
        os.system("docker push " + imageIncaToPush)
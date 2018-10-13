# Reference: https://medium.com/google-cloud/how-to-run-cloud-datalab-on-your-laptop-14520195aa8c
# Author: Lak Lakshmanan

#!/bin/bash
IMAGE=gcr.io/cloud-datalab/datalab:latest
DATALAB_IMAGE=gcr.io/cloud-datalab/datalab
DATALAB_TAG=latest
CONTENT=${HOME}/code/training-data-analyst # your git repo
PROJECT_ID=$(gcloud config get-value project)

# Check if the Docker image has already been downloaded
if [[ "$(docker images -q $DATALAB_IMAGE:$DATALAB_TAG 2> /dev/null)" == "" ]]; then
	echo "Image: "$DATALAB_IMAGE":"$DATALAB_TAG "does not exists. Pulling" $DATALAB_TAG
	docker pull $IMAGE
else
	echo "Image exists:" $DATALAB_IMAGE":"$DATALAB_TAG 
fi

# Setup the network communication
if [ "$OSTYPE" == "linux"* ]; then
	PORTMAP="127.0.0.1:8081:8080"
else
	PORTMAP="8081:8080"
fi

docker run -it \
	   -p $PORTMAP \
	   -v "$CONTENT:/content" \
	   -e "PROJECT_ID=$PROJECT_ID" \
	   $IMAGE


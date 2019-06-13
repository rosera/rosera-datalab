# Datalab

## Introduction
An extension to the [medium post](https://medium.com/google-cloud/how-to-run-cloud-datalab-on-your-laptop-14520195aa8c) by Lak Lakshmanan. 

The basic premise is to allow Datalab to run locally, so no network connection is required. This repository enables Crostini enabled Chromebooks to get in on the fun. 

## Pixelbook installation
By default on a linux enabled Pixelbook, there should already a virtual machine created. To access the virtual machine instance, press CTRL-ALT-T on the keyboard to open a CROSH browser tab. 

Personally when I am experimenting with new configurations, I like to  do this in a separate VM. If you would rather create this in the default VM, please ignore this step and start the default VM as usual.

### Create a new VM

To begin, lets create a new vm named sandbox. We will conduct our test in this VM and attempt to isolate any changes to this environment.

```vmc start sandbox ```
    
We are now working within our VM. Let’s commence experimentation by making a Linux container. In this instance we will create a container based on the debian stretch operating system and name it “datalab”.

```lxc launch image:debian/stretch datalab ```
    
Once the image has been downloaded, we should be able to see the list of existing containers using the following command:

```lxc list ```

Note: the container will not automatically be started once created. 

To start the container and perform some configuration, use the following command:

```lxc exec datalab /bin/bash ```
    
    
We are now within the container and we can see that our user shown as part of the command line has changed now root@datalab.

Ensure the container has the updates applied.

```apt-get update && apt-get upgrade ```
    
- Docker installation [link](https://docs.docker.com/install/linux/docker-ce/debian/#install-docker-ce-1)
- GCloud SDK [link](https://cloud.google.com/sdk/docs/quickstart-debian-ubuntu)
- Ngrok installation [link](https://ngrok.com/download)
- Datalab-init (see added BASH script)

Note: Datalab- init references needs to point to where your code resides. In my case, code sits in the rosera-datalab/code directory as per the configuration in the Datalab-init script.

```./datalab-init.sh ```
    
At this point, there should be a running container serving Datalab. The final step is to add a proxy to enable access via a browser.

- ngrok [link](https://ngrok.com/download)

NGROK is an awesome tool for establishing a proxy on your machine. In a new window, start a proxy service to access datalab via the enabled port.

Example:
    ```./ngrok http-region eu 8081 ```

Once Ngrok is running, there will be a number proxy values displayed. Take a note of this information as this data contains the URI to access Datalab browser interface.


- Chrome Connection Forwarder [link](https://chrome.google.com/webstore/detail/connection-forwarder/ahaijnonphgkgnkbklchdhclailflinn)

Connection Forwarder is a Chrome extension that does the same job as Ngrok, only its much more user friendly. Open the port 8081 using this extension.

## Issues
Please feel free to fork the code and raise a pull request for any changes to be applied. Let me know if you find it helpful.



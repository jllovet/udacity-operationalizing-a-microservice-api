# Udacity Devops Nanodegree Project - Operationalizing a Microservice API:
[![jllovet](https://circleci.com/gh/jllovet/udacity-operationalizing-a-microservice-api.svg?style=svg)](https://app.circleci.com/pipelines/github/jllovet/udacity-operationalizing-a-microservice-api)

## Overview

This is an example of how to operationalize a Machine Learning Microservice API using standard devops tools like Docker and Kubernetes.

This repository is based on the project `Operationalize a Machine Learning Microservice API` in the Udacity Devops Nanodegree. The rubric for the project can be found [here](https://review.udacity.com/#!/rubrics/2576/view).

Given a pre-trained `sklearn` model based on a [Kaggle dataset](https://www.kaggle.com/c/boston-housing) that has been trained to predict housing prices in Boston according to several features, such as average rooms in a home and data about highway access, teacher-to-pupil ratios, and so on, the task is to operationalize the deployment of an API based on that model. The code for the API is also provided, but some extensions are made to validate that a pipeline of automated linters and tests work properly.

### Project Tasks

We are going to operationalize this working, machine learning microservice using [kubernetes](https://kubernetes.io/), which is an open-source system for automating the management of containerized applications.

To get there, we also do the following:

* Validate the project code using linting
* Complete a Dockerfile to containerize this application
* Deploy the containerized application using Docker and make a prediction
* Improve the log statements in the source code for this application
* Configure Kubernetes and create a Kubernetes cluster
* Deploy a container using Kubernetes and make a prediction
* Upload a complete Github repo with CircleCI to indicate that the code has been tested

### A Tour

Some files of interest in the repository:

#### Python Files

* `app.py` - source code for the API that uses the model to make predictions
* `requirements.txt` - a set of python dependencies required for the application
* `Makefile` - an abstraction of commands needed in setting up and working with a python virtual environment
* `make_prediction.sh` - a curl command to make an HTTP request for a prediction

#### Docker Files

* `Dockerfile` - a definition of a Docker image that provides a standard environment for the API to run in
* `upload_docker.sh` - a script to upload a docker image to Docker Hub
* `run_docker.sh` - a script to run the application in a docker container

#### Kubernetes Files

* `jllovet-udacitydevops.yaml` - a definition of a Kubernetes deployment for the API
* `run_kubernetes.sh` - a script to run the application in a Kubernetes cluster

#### CircleCI Files

* `.circleci/config.yml` - a definition of the job that runs in CircleCI to validate and build our changes

---

## Setup

We will describe a few ways to run the project. The first will be in a Python [virtual environment](https://docs.python.org/3/library/venv.html) on your host, the second will be in a Docker container, and the third will be in a Kubernetes cluster.

### Virtual Environment
* Create a virtualenv with Python 3.7 and activate it. Refer to this link for help on specifying the Python version in the virtualenv. 
```bash
python3 -m pip install --user virtualenv
# You should have Python 3.7 available in your host. 
# Check the Python path using `which python3`
# Use a command similar to this one:
python3 -m virtualenv --python=<path-to-Python3.7> .devops
source .devops/bin/activate
```

This will create a virtualenv and activate it. From here, we need to install dependencies, and then we can get predictions.

* Run `make install` to install the necessary dependencies
* Run the standalone application with  `python app.py`. This will start the server that generates predictions.

Run the following example taken from `make_prediction.sh` to send an HTTP request to the application for a prediction.

```shell
curl -d '{  
   "CHAS":{  
      "0":0
   },
   "RM":{  
      "0":6.575
   },
   "TAX":{  
      "0":296.0
   },
   "PTRATIO":{  
      "0":15.3
   },
   "B":{  
      "0":396.9
   },
   "LSTAT":{  
      "0":4.98
   }
}'\
     -H "Content-Type: application/json" \
     -X POST http://localhost:80/predict

```

### Docker Container

There is a script to make running this more convenient. This time, to run the application, you can run `run_docker.sh`. That script has three steps:

1. Build and tag the image
2. List the docker images available locally
3. Run the flask app, forwarding port 80 in the container to port 8000 on the host.

Finally, you can run `make_prediction.sh` to make a prediction with the API.

### Kubernetes Cluster

Our last option is to run the application in a Kubernetes cluster. Like before, there is a script to make this easier:  `run_kubernetes.sh`

* Setup and Configure Docker locally

* Setup and Configure Kubernetes locally

  * Crash Course with setup instructions: [Kubernetes Tutorial for Beginners [FULL COURSE in 4 Hours]
](https://www.youtube.com/watch?v=X48VuDVv0do)

* Create Flask app in Container
  
  * See instructions above

* Run via kubectl

Here you can run the script `run_kubernetes.sh`. It will:

1. Set a value for the dockerpath
2. Create a deployment with an external service for load balancer using the config in jllovet-udacitydevops.yaml
3. List kubernetes pods
4. Forward the container port to a host

> Note:
> If you receive an error about the port forwarding failing, then you can try running the following to expose the port in the pod to the port on the host machine:
> `kubectl port-forward service/jllovet-udacitydevops-service 8000:8000`

When you're done, run `minikube delete` to remove the cluster.
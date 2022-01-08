# Chapter 6: Clustering with Kubernetes

All the instructions assumes that:
* You have Kubernetes client and server installed and configured

## Code Samples

### Code Sample 1: Deploying an application to Kubernetes

The [sample1](sample1) includes a YAML configuration to start Docker container in multiple replicas on a Kubernetes cluster.

To install the deployment, run the following command.

    $ kubectl apply -f deployment.yaml

You can check that 3 pods, each containing one Docker container, are created.

    $ kubectl get pods
    NAME                                    READY   STATUS    RESTARTS   AGE
    calculator-deployment-dccdf8756-h2l6c   1/1     Running   0          1m
    calculator-deployment-dccdf8756-tgw48   1/1     Running   0          1m
    calculator-deployment-dccdf8756-vtwjz   1/1     Running   0          1m

To check the logs of a running pod, run the following command.

    $ kubectl logs pods/calculator-deployment-dccdf8756-h2l6c

### Code Sample 2: Exposing application

The [sample2](sample2) includes a YAML configuration to create a service which exposes the deployment created in the Code Sample 1.

To install the service, run the following command.

    $ kubectl apply -f service.yaml

To check that the service points to the 3 Pod replicas we created in Code Sample 1, run the following command.

    $ kubectl describe service calculator-service | grep Endpoints
    Endpoints: 10.16.1.5:8080,10.16.2.6:8080,10.16.2.7:8080

### Code Sample 3: Scaling application

If you want to scale up (or down) the application from Code Sample 1, run the following command.

    $ kubectl scale --replicas 5 deployment calculator-deployment

You should see that Kubernetes increased the number of Calculator Pods from 3 to 5.

    $ kubectl get pods
    NAME                                    READY   STATUS    RESTARTS   AGE
    calculator-deployment-dccdf8756-h2l6c   1/1     Running   0          19h
    calculator-deployment-dccdf8756-j87kg   1/1     Running   0          36s
    calculator-deployment-dccdf8756-tgw48   1/1     Running   0          19h
    calculator-deployment-dccdf8756-vtwjz   1/1     Running   0          19h
    calculator-deployment-dccdf8756-zw748   1/1     Running   0          36s

### Code Sample 4: Updating application

The [sample4](sample4) includes a YAML configuration with the updated deployment from Code Sample 1. To observe how Kubernetes update deployments, run the following command.

    $ kubectl apply -f deployment.yaml

Then, you should see that all old Pods are being terminated and Kubernetes started new Pods.

    $ kubectl get pods
    NAME                                       READY STATUS      RESTARTS AGE
    pod/calculator-deployment-7cc54cfc58-5rs9g 1/1   Running     0        7s
    pod/calculator-deployment-7cc54cfc58-jcqlx 1/1   Running     0        4s
    pod/calculator-deployment-7cc54cfc58-lsh7z 1/1   Running     0        4s
    pod/calculator-deployment-7cc54cfc58-njbbc 1/1   Running     0        7s
    pod/calculator-deployment-7cc54cfc58-pbthv 1/1   Running     0        7s
    pod/calculator-deployment-dccdf8756-h2l6c  0/1   Terminating 0        20h
    pod/calculator-deployment-dccdf8756-j87kg  0/1   Terminating 0        18m
    pod/calculator-deployment-dccdf8756-tgw48  0/1   Terminating 0        20h
    pod/calculator-deployment-dccdf8756-vtwjz  0/1   Terminating 0        20h
    pod/calculator-deployment-dccdf8756-zw748  0/1   Terminating 0        18m

to start Docker container in multiple replicas on a Kubernetes cluster.

### Code Sample 5: Rolling update

The [sample5](sample5) includes a YAML configuration with the deployment from Code Sample 1 enhanced with the rolling update configuration. To observe how Kubernetes performs the rolling update, run the following command.

    $ kubectl apply -f deployment.yaml

You can now check by running `kubectl get pods` that Pods terminate and run one by one.

    $ kubectl get pods
    NAME                                   READY STATUS      RESTARTS AGE
    calculator-deployment-78fd7b57b8-npphx 0/1   Running     0        4s
    calculator-deployment-7cc54cfc58-5rs9g 1/1   Running     0        3h
    calculator-deployment-7cc54cfc58-jcqlx 0/1   Terminating 0        3h
    calculator-deployment-7cc54cfc58-lsh7z 1/1   Running     0        3h
    calculator-deployment-7cc54cfc58-njbbc 1/1   Running     0        3h
    calculator-deployment-7cc54cfc58-pbthv 1/1   Running     0        3h

### Code Sample 6: Application dependencies

The [sample6](sample6) includes Hazelcast Kubernetes deployment configuration and the source code for the Calculator application using Hazelcast.

First, start the Hazelcast application.

    $ kubectl apply -f hazelcast.yaml

You can check that the Hazelcast is running by checking its Pod logs. Next, you'll build the application which uses Hazelcast as a caching. You should also build the Docker image and push it in your Docker Hub account.

    $ ./gradlew build
    $ docker build -t <username>/calculator:caching .
    $ docker push <username>/calculator:caching

Finally, change `<username>` in `deployment.yaml` to your Docker Hub account and apply Deployment and Service.

    $ kubectl apply -f deployment.yaml
    $ kubectl apply -f service.yaml

You can check that the Calculator application connected successfully into Hazelcast server by looking finding the following line in the logs.

    Members [1] {
        Member [10.16.2.15]:5701 - 3fca574b-bbdb-4c14-ac9d-73c45f56b300
    } 


## Exercise solutions

### Exercise 1: Run a hello world application on the Kubernetes cluster

The [exercise1](exercise1) directory contains the source code for the hello world application and the Kubernetes YAML configuration to deploy it.

First we need to build the hello world application Docker image and push it into Docker Hub.

    $ docker build -t <username>/hello-service:0.1 .
    $ docker push <username>/hello-service:0.1

Change `<username>` to your Docker Hub account in `deployment.yaml`. Then install the application into Kubernetes with the following command.

    $ kubectl apply -f deployment.yaml

Make a request to check that the application works fine.

    $ curl http://<NODE-IP>:<NODE-PORT>/hello
    Hello World!

### Exercise 2: Implement new feature "Goodbye World!" and deploy it using rolling update

The [exercise2](exercise2) directory contains the source code for the hello world application with the "Goodbye World!" feature and the Kubernetes YAML configuration to deploy it using the RollingUpdate strategy.

First we need to build the new version of hello world.

    $ docker build -t <username>/hello-service:0.2 .
    $ docker push <username>/hello-service:0.2

Change `<username>` to your Docker Hub account in `deployment.yaml`. Then, perform the rolling update using the following command.

    $ kubectl apply -f deployment.yaml

Make a request to check that the new application version works correctly.

    $ curl http://<NODE-IP>:<NODE-PORT>/bye
    Goodbye World!

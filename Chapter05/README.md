# Chapter 5: Automated Acceptance Testing

All the instructions assumes that:
* You have Docker installed and configured
* You have Java JDK 8+ installed
* You have a running Jenkins instance
* Your Jenkins agents (executors) must have JDK 8+ and Docker installed
* You have Ruby (Dev) and Cucumber tools installed

## Code Samples

### Code Sample 1: Using Docker registry

The [sample1](sample1) includes a project to build Docker image which contains the Python interpreter. You can build it with the following command.

    $ docker build -t ubuntu_with_python .

Tag the image to use Docker Hub registry (if you don't have an account, you can create it [here](https://hub.docker.com/signup)).

    $ docker tag ubuntu_with_python <username>/ubuntu_with_python:1

Log into Docker Hub.

    $ docker login --username <username> --password <password>

Push image into the registry.

    $ docker push <username>/ubuntu_with_python:1

To check that the image was pushed, you can remove it from the Docker Daemon and pull from the registry.

    $ docker rmi ubuntu_with_python <username>/ubuntu_with_python:1
    $ docker pull <username>/ubuntu_with_python:1

### Code Sample 2: Dockerizing Spring Boot Application

 The [sample2](sample2) includes a Spring Boot Application and the related Dockerfile. You can build it with the following commands.

	$ ./gradlew build
	$ docker build -t calculator .

To test if the Docker image is correct we can run it and use `curl` to make a GET request.

	$ docker run -p 8080:8080 --name calculator calculator
	$ curl localhost:8080/sum?a=1\&b=2
    3

To include Gradle build and Docker build stages in the Jenkins pipeline, add the following part to `Jenkinsfile`.

```
stage("Package") {
     steps {
          sh "./gradlew build"
     }
}

stage("Docker build") {
     steps {
          sh "docker build -t <username>/calculator ."
     }
}
```

Note that you need to change `<username>` to your Docker Hub ID. Note also that your Jenkins executor needs to have Docker configured.

As the last part of this sample, you can add a stage which logs into Docker Hub and pushes Docker image.

```
stage("Docker login") {
     steps {
          withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'docker-hub-credentials',
                   usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD']]) {
               sh "docker login --username $USERNAME --password $PASSWORD"
          }
     }
}

stage("Docker push") {
     steps {
          sh "docker push <username>/calculator"
     }
}
```

Before executing the Jenkins build you have to set up the credentials `docker-hub-credentials` in Jenkins.

### Code Sample 3: Acceptance testing stage

To run the simplest Acceptance testing stage on the [sample2](sample2) project, create the following `acceptance_test.sh` file.

```bash
#!/bin/bash
test $(curl localhost:8765/sum?a=1\&b=2) -eq 3
```

Then, add the following stages to your `Jenkinsfile`:
```
stage("Deploy to staging") {
     steps {
          sh "docker run -d --rm -p 8765:8080 --name calculator <username>/calculator"
     }
}

stage("Acceptance test") {
     steps {
          sleep 60
          sh "chmod +x acceptance_test.sh && ./acceptance_test.sh"
     }
}
```

Add the clean up stage to avoid keeping the test container alive.

```
post {
     always {
          sh "docker stop calculator"
     }
}
```

### Code Sample 4: Writing Cucumber acceptance test

The [sample4](sample4) includes a Spring Boot Application with the Acceptance Test which uses Cucumber framework. Please check the following files:
* `src/test/resources/feature/calculator.feature`: Acceptance Testing Scenario (acceptance criteria)
* `src/test/java/acceptance/StepDefinitions.java`: Step Definitions
* `src/test/java/acceptance/AcceptanceTest.java`: Cucumber JUnit Runner

You can run the acceptance test with the following command:

    $ ./gradlew acceptanceTest -Dcalculator.url=http://localhost:8765

Change `calculator.url` to the address of your running Calculator service.

To use this acceptance test in your `Jenkinsfile`, use the following stage:
```
stage("Acceptance test") {
     steps {
          sleep 60
          sh "./gradlew acceptanceTest -Dcalculator.url=http://localhost:8765"
     }
}
```

## Exercise solutions

### Exercise 1: Book Library web service in Ruby

The [exercise1](exercise1) directory contains the source code for the `book-library` web service and the related Cucumber acceptance test.

Install required Ruby dependencies.

    $ gem install rest-client sinatra json

Check that the test fails.

    $ cucumber
    ...
    1 scenario (1 failed)
    3 steps (1 failed, 1 skipped, 1 passed)
    0m0.116s

Start the web service.

    $ ruby book-library.rb -p 8080

Check that the test passes.

    $ cucumber
    ...
    1 scenario (1 passed)
    3 steps (3 passed)
    0m0.195s

### Exercise 2: Dockerize Book Library

The [exercise2](exercise2) directory contains the `book-library` web service and `Dockerfile`.

To build the Docker image, run the following command.

    $ docker build -t <username>/book-library .

You can then try to run it locally with the following command.

    $ docker run -p 8080:8080 <username>/book-library

To push the image into your Docker Hub, you need to use `docker login` and then the following command.

    $ docker push <username>/book-library

### Exercise 3: Jenkinsfile for Book Library

The [exercise3](exercise3) directory contains `Jenkinsfile` used to build and push `book-library` Docker image.

Note that you need to:
* change `<username>` to your Docker Hub account name
* put your Docker Hub credentials into Jenkins.
# Chapter 3: Configuring Jenkins

All the instructions assumes that:
* You have Docker installed and configured
* You have an account on Docker Hub
* You are logged into Docker Hub (`docker login`)

## Code Samples

### Code Sample 1: Building Jenkins agent

The [sample1](sample1) includes a project to build Jenkins agent which contains the Python interpreter. You can build it with the following command.

    $ docker build -t leszko/jenkins-agent-python .

Please change `leszko` to your Docker Hub account name.

Then, you can push the image into the Docker Hub registry.

    $ docker push leszko/jenkins-agent-python

After this step, make your your registry is public (or configure Docker Hub credentials in your Jenkins master).

### Code Sample 2: Building Jenkins master

The [sample2](sample2) includes a project to build a custom Jenkins master Docker image. You can build and run it with the following commands.

    $ docker build -t jenkins-master .

Then, you can run the created Jenkins master.

    $ docker run -p 8080:8080 jenkins-master

## Exercise solutions

### Exercise 1: Build Jenkins master and agent Docker images

The [exercise1](exercise1) directory contains the source code for the Jenkins master ([exercise1/master](exercise1/master)) and Jenkins agent ([exercise1/agent](exercise1/agent)) Docker images.

In the master directory execute the following command to build and run Jenkins master.

    $ docker build -t jenkins-master .
    $ docker run -p 8080:8080 jenkins-master

In the agent directory execute the following command (change `leszko` to your Docker Hub account).

    $ docker build -t leszko/jenkins-agent-ruby .
    $ docker push leszko/jenkins-agent-ruby

Change `leszko/jenkins-agent-ruby` repository to public in Docker Hub and set this image as an agent in Jenkins master.


### Exercise 2: Create a pipeline which creates and run Ruby script

The pipeline to create and run Ruby hello world script looks as follows.

```
pipeline {
    agent any
    stages {
        stage("Hello") {
            steps {
                sh "echo \"puts 'Hello World from Ruby'\" > hello.rb"
                sh "ruby hello.rb"
            }
        }
    }
}
```
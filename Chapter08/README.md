# Chapter 8: Continuous Delivery Pipeline

All the instructions assumes that you have:
* Jenkins instance (with Java 8+, Docker, and kubectl installed on Jenkins agents)
* Docker registry (e.g. account on Docker Hub)
* Two Kubernetes clusters (one available as the context `staging`, the other as `production`)
* Build Timestamp Plugin installed in Jenkins (and timestamp format configured to contain no whitespaces)
* Credentials for Docker Hub set in Jenkins

## Code Samples

### Code Sample 1: Complete Continuous Delivery pipeline

The [sample1](sample1) includes a Calculator project with the complete Continuous Delivery pipeline defined in `Jenkinsfile`.

## Exercise solutions

### Exercise 1: Create performance test for the Hello World service

The [exercise1](exercise1) directory contains the source code for the hello world application and the performance test to run against it.

To start the Hello World application run the following command.

	$ python app.py

To run the performance test, run the following command.

	$ ./performance-test.sh localhost:5000

If the command runs `0` as the result, then the performance test passed correctly.

### Exercise 2: Create Jenkins pipeline for the Hello World service

The [exercise2](exercise2) directory contains the complete Hello World service together with `Jenkinsfile`.

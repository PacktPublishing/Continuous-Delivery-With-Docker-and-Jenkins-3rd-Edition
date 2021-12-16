# Chapter 4: Continuous Integration Pipeline

All the instructions assumes that:
* You have a running Jenkins instance
* You have Java JDK 8+ installed
* You have Python installed

## Code Samples

### Code Sample 1: Basic Commit pipeline for Spring Boot project

The [sample1](sample1) includes a simple Spring Boot web service which is able to sum two numbers. You can start it with the following command.

    $ ./gradlew bootRun

You can check it works by making a REST call.

    $ curl localhost:8080/sum?a=1\&b=2
    3

To execute the automated unit tests, run the following command.

    $ ./gradlew test

Continuous Integration pipeline for this project is included in `Jenkinsfile` and looks as follows.

```
pipeline {
     agent any
     stages {
          stage("Compile") {
               steps {
                    sh "./gradlew compileJava"
               }
          }
          stage("Unit test") {
               steps {
                    sh "./gradlew test"
               }
          }
     }
}
```

### Code Sample 2: Code Coverage stage

The [sample2](sample2) extends the web service from Code Sample 1 with the code coverage check. You can execute it with the following command.

    $ ./gradlew test jacocoTestCoverageVerification

You can also generate the code coverage report.

    $ ./gradlew test jacocoTestReport

The report is created in the `build/reports/jacoco/test` directory.

To include the code coverage in the Jenkins pipeline, add the following stage.

```
stage("Code coverage") {
     steps {
          sh "./gradlew jacocoTestReport"
          sh "./gradlew jacocoTestCoverageVerification"
     }
}
```

### Code Sample 3: Static Code Analysis stage

The [sample3](sample3) extends the web service from Code Sample 1 with the static code analysis check. You can execute it with the following command.

    $ ./gradlew checkstyleMain

To include the static code analysis check in the Jenkins pipeline, add the following stage.

```
stage("Static code analysis") {
     steps {
          sh "./gradlew checkstyleMain"
     }
}
```

## Exercise solutions

### Exercise 1: Create Python project with unit test

The [exercise1](exercise1) directory contains the source code for the Python Calculator project. It consists of two files: `calculator.py` (Calculator program) and `test_calculator.py` (Calculator unit test).

You can run the program with the following command.

    $ python calculator.py 2 2
    4

To run the unit test, execute the following command.

    $ python test_calculator.py
    .
    ----------------------------------------------------------------------
    Ran 1 test in 0.002s
    OK

### Exercise 2: Build Python-based Continuous Integration pipeline

Continuous Integration pipeline for the Calculator Python project can specified as the following `Jenkinsfile`.

```
pipeline {
    agent any
    triggers {
        pollSCM('* * * * *')
    }
    stages {
        stage("Unit test") {
            steps {
                sh "python test_calculator.py"
            }
        }
    }
}
```
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
pipeline {
     agent any
     triggers {
          pollSCM('* * * * *')
     }
     stages {
          stage("Docker build") {
               steps {
                    sh "docker build -t leszko/hello-service:${BUILD_TIMESTAMP} ."
               }
          }

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
                    sh "docker push leszko/hello-service:${BUILD_TIMESTAMP}"
               }
          }

          stage("Update version") {
               steps {
                    sh "sed  -i 's/{{VERSION}}/${BUILD_TIMESTAMP}/g' deployment.yaml"
               }
          }
          
          stage("Deploy to staging") {
               steps {
                    sh "kubectl config use-context staging"
                    sh "kubectl apply -f deployment.yaml"
               }
          }

          stage("Performance test") {
               steps {
                    sleep 20
                    sh "chmod +x performance-test.sh && ./performance-test.sh"
               }
          }
     }
}

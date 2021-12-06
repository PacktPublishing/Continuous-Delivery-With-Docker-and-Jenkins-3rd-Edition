FROM jenkins/jenkins:lts-jdk11
COPY executors.groovy /usr/share/jenkins/ref/init.groovy.d/executors.groovy
RUN jenkins-plugin-cli --plugins docker-plugin github-branch-source:1.8

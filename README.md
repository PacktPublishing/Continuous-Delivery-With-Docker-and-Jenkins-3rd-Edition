


# Continuous Delivery With Docker and Jenkins, 3rd Edition

<a href="https://www.packtpub.com/product/continuous-delivery-with-docker-and-jenkins-third-edition/9781803237480?utm_source=github&utm_medium=repository&utm_campaign=9781803237480"><img src="https://static.packt-cdn.com/products/9781803237480/cover/smaller" alt="About the Author" height="256px" align="right"></a>

This is the code repository for [Continuous Delivery With Docker and Jenkins, 3rd Edition](https://www.packtpub.com/product/continuous-delivery-with-docker-and-jenkins-third-edition/9781803237480?utm_source=github&utm_medium=repository&utm_campaign=9781803237480), published by Packt.

**Create secure applications by building complete CI/CD pipelines**

## What is this book about?
This updated third edition of Continuous Delivery with Docker and Jenkins will explain the advantages of combining Jenkins and Docker to improve the continuous integration and delivery process of app development. 

This book covers the following exciting features:
* Grasp Docker fundamentals and dockerize applications for the CD process
* Understand how to use Jenkins on-premises and in the cloud
* Scale a pool of Docker servers using Kubernetes
* Write acceptance tests using Cucumber
* Run tests in the Docker ecosystem using Jenkins
* Provision your servers and infrastructure using Ansible and Terraform
* Publish a built Docker image to a Docker registry
* Deploy cycles of Jenkins pipelines using community best practices

If you feel this book is for you, get your [copy](https://www.amazon.com/dp/1803237481) today!

<a href="https://www.packtpub.com/?utm_source=github&utm_medium=banner&utm_campaign=GitHubBanner"><img src="https://raw.githubusercontent.com/PacktPublishing/GitHub/master/GitHub.png" 
alt="https://www.packtpub.com/" border="5" /></a>

## Instructions and Navigations
All of the code is organized into folders. For example, Chapter02.

The code will look like the following:
```
pipeline {
 agent any
 stages {
 stage("Checkout") {
 steps {
 git url: 'https://github.com/leszko/calculator.git', branch: 'main'
 }
 }
 }
}
```

**Following is what you need for this book:**
The book is for DevOps engineers, system administrators, Docker professionals, or anyone who wants to explore the power of working with Docker and Jenkins together. No prior knowledge of DevOps is required to get started.

With the following software and hardware list you can run all code files present in the book (Chapter 1-9).
### Software and Hardware List
| Chapter | Software required | OS required |
| -------- | ------------------------------------ | ----------------------------------- |
| 1-9 | Jave 8+ | Windows, Mac OS X, and Linux (Any) |
| 1-9 | Docker | Windows, Mac OS X, and Linux (Any) |
| 1-9 | Jenkins | Windows, Mac OS X, and Linux (Any) |
| 1-9 | Python | Windows, Mac OS X, and Linux (Any) |
| 1-9 | Kubernetes | Windows, Mac OS X, and Linux (Any) |
| 1-9 | Ansible | Windows, Mac OS X, and Linux (Any) |
| 1-9 | Terraform | Windows, Mac OS X, and Linux (Any) |


We also provide a PDF file that has color images of the screenshots/diagrams used in this book. [Click here to download it](https://static.packt-cdn.com/downloads/9781803237480_ColorImages.pdf).

### Code in Action
Click on following link to see the Code in Action:

[Youtube link](https://bit.ly/3NSEPNA)

### Related products
* Docker for Developers [[Packt]](https://www.packtpub.com/product/docker-for-developers/9781789536058?utm_source=github&utm_medium=repository&utm_campaign=9781789536058) [[Amazon]](https://www.amazon.com/dp/1789536057)

* Learn Docker - Fundamentals of Docker 19.x - Second Edition [[Packt]](https://www.packtpub.com/product/learn-docker-fundamentals-of-docker-19-x-second-edition/9781838827472?utm_source=github&utm_medium=repository&utm_campaign=9781838827472) [[Amazon]](https://www.amazon.com/dp/1838827471)


## Get to Know the Author
**Rafal Leszko**
is a passionate software developer, trainer, and conference speaker living in Krakow, Poland. He has spent his career writing code, designing architecture, and is a tech leader in a number of companies and organizations, including Hazelcast, Google, and CERN. Always open to new challenges, he has given talks and conducted workshops at numerous international conferences, including Devoxx and Voxxed Days.

### Download a free PDF

 <i>If you have already purchased a print or Kindle version of this book, you can get a DRM-free PDF version at no cost.<br>Simply click on the link to claim your free PDF.</i>
<p align="center"> <a href="https://packt.link/free-ebook/9781803237480">https://packt.link/free-ebook/9781803237480 </a> </p>
# Chapter 7: Configuration Management with Ansible

All the instructions assumes that you have:
* Ansible tool installed
* Two Ubuntu machines with SSH configured (you should be able to `ssh` into each machine without password)
* Ansible inventory file created (`/etc/ansible/hosts`) pointing to your remote machines

Sample Ansible inventory file:

	[webservers]
	web1 ansible_host=<machine-ip-1> ansible_user=<machine-user-1>
	web2 ansible_host=<machine-ip-2> ansible_user=<machine-user-2>

## Code Samples

### Code Sample 1: Ad hoc commands

To check that your inventory is correct, run the Ansible ad hoc `ping` command.

	$ ansible all -m ping
	web1 | SUCCESS => {
	    "ansible_facts": {
	        "discovered_interpreter_python": "/usr/bin/python3"
	    },
	    "changed": false,
	    "ping": "pong"
	}
	web2 | SUCCESS => {
	    "ansible_facts": {
	        "discovered_interpreter_python": "/usr/bin/python3"
	    },
	    "changed": false,
	    "ping": "pong"
	}

### Code Sample 2: Playbooks

The [sample2](sample2) includes a Playbook to install and run `apache2` on the `web1` host.

You can execute it using the following command.

	$ ansible-playbook playbook.yml

### Code Sample 3: Handlers

The [sample3](sample3) includes a Playbook which, apart from installing and running `apache2`, copies the local `apache2` configuration and restarts the server only if the configuration has changed.

To create the configuration and start the playbook, run the following commands.

	$ touch foo.conf
	$ ansible-playbook playbook.yml

Note that if you run `ansible-playbook` mutliple times, nothing changes. Now, if you create a new configuration and start the Playbook again, you should see that the `apache2` server is restarted.

	$ echo "something" > foo.conf
	$ ansible-playbook playbook.yml

### Code Sample 4: Variables

The [sample4](sample4) includes a Playbook presenting the use of variables.

Execute the following command to see the result.

	$ ansible-playbook playbook.yml

### Code Sample 5: Deployment with Ansible

The [sample5](sample5) includes a Playbook to start Hazelcast server on `web1` and the Calculator service (which uses Hazelcast) on `web2`.

To run the playbook, you need first to modify `src/main/java/com/leszko/calculator/CalculatorApplication.java` and change `<machine-ip-1>` to your `web1` machine IP address. Then, you can build the project and apply the Ansible Playbook.

	$ ./gradlew build
	$ ansible-playbook playbook.yml

In result, you deployed two dependent applications. You can test it by running the following command.

	$ curl http://<machine-ip-2>:8080/sum?a=1\&b=2
	3

### Code Sample 6: Ansible Docker playbook

The [sample6](sample6) includes two playbooks:
 * `install-docker-playbook.yml`: playbook which installs Docker Community Edition on an Ubuntu 18.04 server
 * `hazelcast-playbook.yml`: playbook which starts Hazelcast Docker container on a server which has Docker Daemon running

 To install Docker Daemon on a server, run the following command.

	$ ansible-playbook install-docker-playbook.yml

If the command fails at some point, re-run it.

Then, to start Hazelcast container, run the following command.

	$ ansible-playbook hazelcast-playbook.yml

## Exercise solutions

### Exercise 1: Create the server infrastructure and use Ansible to manage it

You can use VirtualBox, one of Cloud providers (AWS, GCP, or Azure), or a bare-metal server. Configure your SSH public key into `authorized_keys`. Then, install Python on each of the servers. Finally, put the servers IPs and user names into your inventory file (`/etc/ansible/hosts`).

With such configuration you should be able to `ping` all the servers.

	$ ansible all -m ping

### Exercise 2: Deploy a Python-based "hello world" web service using Ansible

The [exercise2](exercise2) directory contains the source code for the hello world application and the Ansible playbook to deploy it.

To install Hello World service on the `web1` server, run the following command.

	$ ansible-playbook playbook.yml

After that you should be able to call the Hello World service.

	$ curl http://<web1-ip>:5000/hello
	Hello World!


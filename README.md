# Deis-workflow v2 demo
* This is a deis-workflow v2 using Kubernetes on DigitalOcean demo
* terraform scripts to launch instances on DigitalOcean
* ansible playbook is in ansible
* provision scripts for Deis can be found in scripts/
# configuration
* Create terraform/terraform.tfvars
```
DO_TOKEN = "generate new api key and put here"
PUBLIC_SSH_KEY = "/path/to/.ssh/id_rsa.pub"
PRIVATE_SSH_KEY = "/path/to/.ssh/id_rsa"
```
* Create Ansible inventory file ansible/inventory:
```
[coreos]
ip1
ip2
ip3

[kubernetes-master]
ip1

[kubernetes-workers]
ip2
ip3

```
* Set variables in ansible/group_vars/all
# how to run
* Spin up DigitalOcean instances:
```
$ cd terraform
$ terraform apply
```
* Run the ansible playbook
```
$ cd ansible
$ ansible-playbook kubernetes.yml -i inventory
```
* Install kubectl
```
$ scripts/kubectl.sh
```
* Install Deis
```
$ scripts/install_deis.sh
```
* Install Deis client
```
$ scripts/install_client.sh
```
* Start the LB. First find out the EndPoints and change them in config
```
kubectl describe service deis-router --namespace=deis
# edit group_vars/all
# edit inventory file
ansible-playbook kubernetes.yml -i inventory --limit loadbalancer-ip
```
* Register to Deis and Deploy the app
```
$ deis register http://deis.public-ip.nip.io
$ mv demo-project ../app && cd ../app
$ git init
$ git add .
$ git commit -am "initial commit"
$ deis create
$ deis keys:add
$ ssh-agent bash
$ ssh-add ~/.ssh/mykey
$ git push deis master
$ curl appname.public-ip.nip.io
```

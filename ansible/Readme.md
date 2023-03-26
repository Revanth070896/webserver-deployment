# Ansible

The ansible playbook is used to configure webserver application including installation of certs


The fodler has below components:

1. roles
2. dynamic inventory
3. site.yaml


# Roles

nginx deploy role is ansibel role to coonfigure the server

The role install required packages for nginx and certbot as certs are created using certbot which require vars `domain_name` and `certbot_email`

The role even confiugre the ssl config for nginx using ansible jija template

# Dynamic inventory

As the instacnes are in aws  i made use of ansible dynamic inventory of aws which fies the below

Filter the instances with running state and has tag name `Application` . As our terraform depoloy instance with application tag


# site.yaml 

Has the role to run and the vars for teh role



# List hosts

set Aws profile 

export AWS_PROFILE=`profile`


```
 ansible-inventory  -i aws_ec2.yml --list

```

# Deploy application 

```

ansible-playbook -i aws_ec2.yml site.yaml --private-key ~/Downloads/interviews.pem -u ubuntu

````


# 

This folder has the terraform code for below resources

1. Create dynamo db for locking state file stores in `backend` folder
2. Create ec2 instance 


# Export AWS_PROFILE

# dynamo db 

Only one dynamo db table is created for single az for all terraform available to lock the statefile
Howeere we will be having different s3 buckets or  different fodlers in same s3 bucket for mutliple terraform codes 

`cd terraform/backend`

1. Initialise

```

terraform init

```

2. plan

```

terraform plan -out infra.tfplan


```


3. apply

```

terraform apply infra.tfplan

```


# Ec2

Change directory to terraform

`cd terraform`

1. Initialise

```

terraform init

```

2. plan

```

terraform plan -out infra.tfplan


```


3. apply

```

terraform apply infra.tfplan

```




# Destroy the instance

```
terraform destroy
```



# TERRAFORM Configs
To init instances:
```
terraform init
```

To be able to execute this code, you need to define this variables before apply the deployment instructions below:
```
export AWS_ACCESS_KEY_ID="XXXX"
export AWS_SECRET_ACCESS_KEY="XXXX"
```

Then to apply the deployment instructions:
```
terraform apply
```

If you need to apply a specific vars file, use this command:
```
terraform apply -var-file "dev.tfvars" -auto-approve
```

Example of **X.tfvars** file in autre.tfvars
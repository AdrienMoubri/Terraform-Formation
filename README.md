
# Terraform AWS ECS tests and exercises
[![N|Solid](https://upload.wikimedia.org/wikipedia/commons/thumb/0/04/Terraform_Logo.svg/512px-Terraform_Logo.svg.png)]( https://www.terraform.io)

# Write, Plan, Apply
Terraform is an open-source infrastructure as code software tool that provides a consistent CLI workflow to manage hundreds of cloud services. Terraform codifies cloud APIs into declarative configuration files.


## Write
Write infrastructure as code using declarative configuration files. HashiCorp Configuration Language (HCL) allows for concise descriptions of resources using blocks, arguments, and expressions.

  
## Plan
Run terraform plan to check whether the execution plan for a configuration matches your expectations before provisioning or changing infrastructure.

## Installation
Install [Terraform](https://www.terraform.io/downloads.html).

```cmd

cd your_terraform_directory

terraform init

```

# Amazon Web Service
Install [AWS Cli V2](https://docs.aws.amazon.com/fr_fr/cli/latest/userguide/install-cliv2.html).

To use an aws account simply launch :

```bash

aws configure

```

Terraform will use your default credentials to access and create your infra.

## VsCode

To use Terraform, you will learn HashiCorp Configuration Language (HCL).

It's a good idea to have a nice IDE

You can install [Vscode](https://code.visualstudio.com/download)
You can then install the [Terraform](https://marketplace.visualstudio.com/items?itemName=HashiCorp.terraform) extension for ease of use
  

## Exercises

Once installed, you can create a new workspace.
We will use Terraform [Documentation](
https://registry.terraform.io/providers/hashicorp/aws/latest/docs)  for setting up our providers : 
and create a file named `first.tf` paste the following code inside
```
## define the source and version of our provider
terraform { 
	required_providers {
		aws = {
			source = "hashicorp/aws"
			version = "~> 3.27"
		}
	}
	required_version = ">= 0.14.9"
}
## define for the provider AWS the profile and region
provider "aws" {
	profile = "default"
	region = "eu-west-3"
}
``` 

Then launch a terminal.

```sh

terraform init #initialise the directory (download all verify providers configuration)

terraform plan #show the planned changes.
#There are no changes because there are still no ressources in this directory

terraform apply #apply the planned changes if there are any

```


### 000 : create a simple ec2
[![N|Solid](assets/000-EC2.png)]
Create a new directory name `000`
Inside the `000` directory, create a file named `ec2.tf` with the configuration of the aws provider.
Open the aws console. Select the region you've configured in the provider region.
Then Go AMI Market place and find an image containing a server running on port 80. Example Nginx, Lamp,  Apache2. 
Then find the Ami Id. (Inside the browser url after the ami is selected and you clicked to the button `Launch Instance with AMI`

I will use `ami-02f89a178c735778a` it is free image of Nginx provided by Bitnami on eu-west-3. 

we will then add an EC2 resource inside the `ec2.tf` file. [EC2 resource documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance)

```
resource "aws_instance"  "my_first_terraform_ec2" {
	ami = "ami-02f89a178c735778a" ## use your ami here 
	instance_type = "t2.micro" # The smallest type availlable potentially free of charge for your region 
	tags = {
		Name = "first_ec2_with_terraforms" #For EC2 we use Tags as a way to name our resource
	}
}
```
Then Launch using 
```sh
terraform init #initialise the directory (download all verify providers configuration)
terraform plan #show the planned changes.
terraform apply #apply the planned changes if there are any
```

Go back to your aws console your ec2 instance is now running. 

### 001 : create and configure vpcs
[![N|Solid](assets/001-VPC.png)]
Start by creating a new directory and new file name `vpc.tf`
VPC can be tricky to configure we will follow the [Terraform VPC documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc)

Let's start by creating the VPC : 


```

```


Attention trouver les bonnes range d'adresse pour les subnets

Parler des zones d'avalability

  

### 010 : create an ec2 inside a vpc

 
terraform init



terraform apply -var-file vpc.tfvars

  
  

### 011 : create

  

terraform init

terraform apply -var-file vpc.tfvars

  
  
  
  

### 100 : create

  

terraform init

terraform apply -var-file vpc.tfvars

# Going Further

## Saving infra state using [Terraforms Backends](https://www.terraform.io/language/settings/backends)
Backends primarily determine where Terraform stores its [state](https://www.terraform.io/language/state). Terraform uses this persisted [state](https://www.terraform.io/language/state) data to keep track of the resources it manages. Since it needs the state in order to know which real-world infrastructure objects correspond to the resources in a configuration, everyone working with a given collection of infrastructure resources must be able to access the same state data.
###  S3 
Stores the state as a given key in a given bucket on [Amazon S3](https://aws.amazon.com/s3/).
Example Configuration

```hcl
terraform {  
	backend "s3" {    
	bucket = "mybucket"    
	key    = "path/to/my/key"    
	region = "eu-west-3"  
	}
}
```
## Using [ECS](https://aws.amazon.com/fr/ecs/) to host Docker Image
  [![N|Solid](https://blog.alterway.fr/images/services/AmazonECS.png)](https://aws.amazon.com/fr/ecs/?whats-new-cards.sort-by=item.additionalFields.postDateTime&whats-new-cards.sort-order=desc&ecs-blogs.sort-by=item.additionalFields.createdDate&ecs-blogs.sort-order=desc)

Amazon Elastic Container Service (Amazon ECS) is a fully managed container orchestration service that helps you easily deploy, manage, and scale containerized applications. It deeply integrates with the rest of the AWS platform to provide a secure and easy-to-use solution for running container workloads in the cloud and now on your infrastructure with Amazon ECS Anywhere.



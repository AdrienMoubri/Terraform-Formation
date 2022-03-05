
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
and create a file named `first.tf` paste the following code inside
```
terraform {
	required_providers {
		aws = {
			source = "hashicorp/aws"
			version = "~> 3.27"
		}
	}
	required_version = ">= 0.14.9"
}
provider "aws" {
	profile = "default"
	region = "eu-west-3"
}
``` 

Then launch a terminal.

```sh

terraform init #initialise the directory

terraform plan #show the planned changes

terraform apply #apply the planned changes

```

[Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)

  

### 000 : create a simple ec2
[EC2 documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance)

Image Attention trouver la bonne dans la console aws

utiliser le bon Id d'ami pour avoir apache2.


  

### 001 : create vpcs

[VPC documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance)


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



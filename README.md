# Terraform AWS ECS tests and exercices

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

# Amazon Elastic Container Service

Amazon Elastic Container Service (Amazon ECS) is a fully managed container orchestration service that helps you easily deploy, manage, and scale containerized applications. It deeply integrates with the rest of the AWS platform to provide a secure and easy-to-use solution for running container workloads in the cloud and now on your infrastructure with Amazon ECS Anywhere.

[![N|Solid](https://blog.alterway.fr/images/services/AmazonECS.png)](https://aws.amazon.com/fr/ecs/?whats-new-cards.sort-by=item.additionalFields.postDateTime&whats-new-cards.sort-order=desc&ecs-blogs.sort-by=item.additionalFields.createdDate&ecs-blogs.sort-order=desc)

Install [AWS Cli V2](https://docs.aws.amazon.com/fr_fr/cli/latest/userguide/install-cliv2.html).


To use an aws account simply launch :
```bash
aws configure
```
Terraform will use your credentials to access and create your infra.

## VsCode
To use Terraform, you will learn HashiCorp Configuration Language (HCL).
It's a good idea to have a nice IDE 
You can install [Vscode](https://code.visualstudio.com/download) 

## Exercises 
Once installed, 
```sh 
terraform init #initialise the directory
terraform plan #show the planned changes
terraform apply #apply the planned changes
```
[Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)

### 000 : create a simple ec2 
[EC2 documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance)
Attention trouver les bonnes range d'adresse pour les subnets
Parler des zones d'avalability

### 001 : create vpcs
[EC2 documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance)
Image Attention trouver la bonne dans la console aws
utiliser le bon Id d'ami pour avoir apache2.
ajouter la bonne zone de disponibilité

### 010 : create an ec2 inside a vpc

terraform init
terraform apply -var-file vpc.tfvars


### 011 : create 

terraform init
terraform apply -var-file vpc.tfvars



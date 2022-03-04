terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
  required_version = ">= 0.14.9"
}
provider "aws" {
  profile = "default"
  region  = "eu-west-3"
}
# Création VPC
resource "aws_vpc" "vpc_dev" {
  cidr_block = "10.16.0.0/16"
  tags = {
    Name = "vpc_dev"
  }
}
resource "aws_vpc" "vpc_rec" {
  cidr_block = "10.32.0.0/16"

  tags = {
    Name = "vpc_rec"
  }
}
resource "aws_vpc" "vpc_bac" {
  cidr_block = "10.48.0.0/16"
  tags = {
    Name = "vpc_bac"
  }
}
# création Internet Gateway
resource "aws_internet_gateway" "gatway_dev" {
  vpc_id = aws_vpc.vpc_dev.id
  tags = {
    Name = "gatway_dev"
  }
}

resource "aws_internet_gateway" "gatway_bac" {
  vpc_id = aws_vpc.vpc_bac.id

  tags = {
    Name = "gatway_bac"
  }
}

resource "aws_internet_gateway" "gatway_rec" {
  vpc_id = aws_vpc.vpc_rec.id

  tags = {
    Name = "gatway_rec"
  }
}

# Création Subnets
resource "aws_subnet" "subnet_dev_public_a" {
  vpc_id            = aws_vpc.vpc_dev.id
  cidr_block        = "10.16.12.0/24"
  availability_zone = "eu-west-3a"
  tags = {
    Name = "subnet_dev_public_a"
  }
}
resource "aws_subnet" "subnet_dev_public_b" {
  vpc_id            = aws_vpc.vpc_dev.id
  cidr_block        = "10.16.11.0/24"
  availability_zone = "eu-west-3b"
  tags = {
    Name = "subnet_dev_public_b"
  }
}
resource "aws_subnet" "subnet_dev_internal_a" {
  vpc_id            = aws_vpc.vpc_dev.id
  cidr_block        = "10.16.1.0/24"
  availability_zone = "eu-west-3a"
  tags = {
    Name = "subnet_dev_internal_a"
  }
}
resource "aws_subnet" "subnet_dev_internal_b" {
  vpc_id            = aws_vpc.vpc_dev.id
  cidr_block        = "10.16.2.0/24"
  availability_zone = "eu-west-3b"
  tags = {
    Name = "subnet_dev_internal_b"
  }
}
resource "aws_subnet" "subnet_dev_external_a" {
  vpc_id            = aws_vpc.vpc_dev.id
  cidr_block        = "10.16.5.0/24"
  availability_zone = "eu-west-3a"
  tags = {
    Name = "subnet_dev_external_a"
  }
}
resource "aws_subnet" "subnet_dev_external_b" {
  vpc_id            = aws_vpc.vpc_dev.id
  cidr_block        = "10.16.6.0/24"
  availability_zone = "eu-west-3b"
  tags = {
    Name = "subnet_dev_external_b"
  }
}
# bac vpc-011dd3a9b9caca1e3
resource "aws_subnet" "subnet_bac_public_a" {
  vpc_id            = aws_vpc.vpc_bac.id
  cidr_block        = "10.48.12.0/24"
  availability_zone = "eu-west-3a"
  tags = {
    Name = "subnet_bac_public_a"
  }
}
resource "aws_subnet" "subnet_bac_public_b" {
  vpc_id            = aws_vpc.vpc_bac.id
  cidr_block        = "10.48.11.0/24"
  availability_zone = "eu-west-3b"
  tags = {
    Name = "subnet_bac_public_b"
  }
}
resource "aws_subnet" "subnet_bac_internal_a" {
  vpc_id            = aws_vpc.vpc_bac.id
  cidr_block        = "10.48.1.0/24"
  availability_zone = "eu-west-3a"
  tags = {
    Name = "subnet_bac_internal_a"
  }
}
resource "aws_subnet" "subnet_bac_internal_b" {
  vpc_id            = aws_vpc.vpc_bac.id
  cidr_block        = "10.48.2.0/24"
  availability_zone = "eu-west-3b"
  tags = {
    Name = "subnet_bac_internal_b"
  }
}
resource "aws_subnet" "subnet_bac_external_a" {
  vpc_id            = aws_vpc.vpc_bac.id
  cidr_block        = "10.48.5.0/24"
  availability_zone = "eu-west-3a"
  tags = {
    Name = "subnet_bac_external_a"
  }
}
resource "aws_subnet" "subnet_bac_external_b" {
  vpc_id            = aws_vpc.vpc_bac.id
  cidr_block        = "10.48.6.0/24"
  availability_zone = "eu-west-3b"
  tags = {
    Name = "subnet_bac_external_b"
  }
}
# rec vpc-0136fec62572f3cdf
resource "aws_subnet" "subnet_rec_public_a" {
  vpc_id            = aws_vpc.vpc_rec.id
  cidr_block        = "10.32.12.0/24"
  availability_zone = "eu-west-3a"
  tags = {
    Name = "subnet_rec_public_a"
  }
}
resource "aws_subnet" "subnet_rec_public_b" {
  vpc_id            = aws_vpc.vpc_rec.id
  cidr_block        = "10.32.11.0/24"
  availability_zone = "eu-west-3b"
  tags = {
    Name = "subnet_rec_public_b"
  }
}
resource "aws_subnet" "subnet_rec_internal_a" {
  vpc_id            = aws_vpc.vpc_rec.id
  cidr_block        = "10.32.1.0/24"
  availability_zone = "eu-west-3a"
  tags = {
    Name = "subnet_rec_internal_a"
  }
}
resource "aws_subnet" "subnet_rec_internal_b" {
  vpc_id            = aws_vpc.vpc_rec.id
  cidr_block        = "10.32.2.0/24"
  availability_zone = "eu-west-3b"
  tags = {
    Name = "subnet_rec_internal_b"
  }
}
resource "aws_subnet" "subnet_rec_external_a" {
  vpc_id            = aws_vpc.vpc_rec.id
  cidr_block        = "10.32.5.0/24"
  availability_zone = "eu-west-3a"
  tags = {
    Name = "subnet_rec_external_a"
  }
}
resource "aws_subnet" "subnet_rec_external_b" {
  vpc_id            = aws_vpc.vpc_rec.id
  cidr_block        = "10.32.6.0/24"
  availability_zone = "eu-west-3b"
  tags = {
    Name = "subnet_rec_external_b"
  }
}




resource "aws_route" "route-dev-public" {
  route_table_id              = aws_vpc.vpc_dev.default_route_table_id
  destination_ipv6_cidr_block = "::/0"
  destination_cidr_block      = "0.0.0.0/0"
  gateway_id                  = aws_internet_gateway.gatway_dev.id
}

resource "aws_route" "route-bac-public" {
  route_table_id              = aws_vpc.vpc_bac.default_route_table_id
  destination_ipv6_cidr_block = "::/0"
  destination_cidr_block      = "0.0.0.0/0"
  gateway_id      = aws_internet_gateway.gatway_bac.id
}

resource "aws_route" "route-dev-public" {
  route_table_id              = aws_vpc.vpc_rec.default_route_table_id
  destination_ipv6_cidr_block = "::/0"
  destination_cidr_block      = "0.0.0.0/0"
  gateway_id      = aws_internet_gateway.gatway_rec.id
}



# outputs
output "vpc_ids" {
  value = {
    dev = aws_vpc.vpc_dev.id
    rec = aws_vpc.vpc_rec.id
    bac   = aws_vpc.vpc_bac.id
  }
  description = "ids des vpcs créer"
  sensitive = false
}


# # bac vpc-011dd3a9b9caca1e3
# resource "aws_subnet" "subnet_bac_public_a" {
#   vpc_id            = "vpc-0f6980fcb97d7a309"
#   cidr_block        = "10.48.12.0/24"
#   availability_zone = "eu-west-3a"
#   tags = {
#     Name = "subnet_bac_public_a"
#   }
# }
# resource "aws_subnet" "subnet_bac_public_b" {
#   vpc_id            = "vpc-0f6980fcb97d7a309"
#   cidr_block        = "10.48.11.0/24"
#   availability_zone = "eu-west-3b"
#   tags = {
#     Name = "subnet_bac_public_b"
#   }
# }
# resource "aws_subnet" "subnet_bac_internal_a" {
#   vpc_id            = "vpc-0f6980fcb97d7a309"
#   cidr_block        = "10.48.1.0/24"
#   availability_zone = "eu-west-3a"
#   tags = {
#     Name = "subnet_bac_internal_a"
#   }
# }
# resource "aws_subnet" "subnet_bac_internal_b" {
#   vpc_id            = "vpc-0f6980fcb97d7a309"
#   cidr_block        = "10.48.2.0/24"
#   availability_zone = "eu-west-3b"
#   tags = {
#     Name = "subnet_bac_internal_b"
#   }
# }
# resource "aws_subnet" "subnet_bac_external_a" {
#   vpc_id            = "vpc-0f6980fcb97d7a309"
#   cidr_block        = "10.48.5.0/24"
#   availability_zone = "eu-west-3a"
#   tags = {
#     Name = "subnet_bac_external_a"
#   }
# }
# resource "aws_subnet" "subnet_bac_external_b" {
#   vpc_id            = "vpc-0f6980fcb97d7a309"
#   cidr_block        = "10.48.6.0/24"
#   availability_zone = "eu-west-3b"
#   tags = {
#     Name = "subnet_bac_external_b"
#   }
# }
# # rec vpc-0136fec62572f3cdf
# resource "aws_subnet" "subnet_rec_public_a" {
#   vpc_id            = "vpc-0e5d6ef3d20cfea2b"
#   cidr_block        = "10.32.12.0/24"
#   availability_zone = "eu-west-3a"
#   tags = {
#     Name = "subnet_rec_public_a"
#   }
# }
# resource "aws_subnet" "subnet_rec_public_b" {
#   vpc_id            = "vpc-0e5d6ef3d20cfea2b"
#   cidr_block        = "10.32.11.0/24"
#   availability_zone = "eu-west-3b"
#   tags = {
#     Name = "subnet_rec_public_b"
#   }
# }
# resource "aws_subnet" "subnet_rec_internal_a" {
#   vpc_id            = "vpc-0e5d6ef3d20cfea2b"
#   cidr_block        = "10.32.1.0/24"
#   availability_zone = "eu-west-3a"
#   tags = {
#     Name = "subnet_rec_internal_a"
#   }
# }
# resource "aws_subnet" "subnet_rec_internal_b" {
#   vpc_id            = "vpc-0e5d6ef3d20cfea2b"
#   cidr_block        = "10.32.2.0/24"
#   availability_zone = "eu-west-3b"
#   tags = {
#     Name = "subnet_rec_internal_b"
#   }
# }
# resource "aws_subnet" "subnet_rec_external_a" {
#   vpc_id            = "vpc-0e5d6ef3d20cfea2b"
#   cidr_block        = "10.32.5.0/24"
#   availability_zone = "eu-west-3a"
#   tags = {
#     Name = "subnet_rec_external_a"
#   }
# }
# resource "aws_subnet" "subnet_rec_external_b" {
#   vpc_id            = "vpc-0e5d6ef3d20cfea2b"
#   cidr_block        = "10.32.6.0/24"
#   availability_zone = "eu-west-3b"
#   tags = {
#     Name = "subnet_rec_external_b"
#   }
# }


resource "aws_instance" "myFirstInstance" {
  ami           = "ami-0be2609ba883822ec"
  count=1
  key_name = "EC2key"
  instance_type = "t2.micro"
  security_groups= [ "security_port"]
  tags= {
    Name = "rds_master"
  }
}
#Create Elastic IP
resource "aws_eip" "myeip" {
  instance = "${aws_instance.myFirstInstance.id}"
  vpc      = false
}
#Create Security group
resource "aws_security_group" "security_port" {
  name        = "security_port"
  description = "security group rds"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

   ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags= {
    Name = "security_port"
  }
}
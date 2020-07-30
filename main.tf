provider "aws" {
    region = "ca-central-1"
}

resource "aws_instance" "example" {
    # ami            = "ami-0700f7228dc5eb47b" # This is a Windows 2019 Server with containers
    ami            = "ami-04312317b9c8c4b51"
    instance_type  = "t2.micro"

    tags = {
        Name = "terraform-example"
    }
}
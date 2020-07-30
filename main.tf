provider "aws" {
    region = "ca-central-1"
}

resource "aws_instance" "example" {
    # ami            = "ami-0700f7228dc5eb47b" # This is a Windows 2019 Server with containers
    # ami            = "ami-04312317b9c8c4b51" # RHEL ami
    ami            = "ami-0e2df0719252d4491" # Ubuntu 16.04 ami
    instance_type  = "t2.micro"
    vpc_security_group_ids = aws_security_group.instance.*.id

    user_data = <<-EOF
                #!/bin/bash
                echo "Hello, World" > index.html
                nohup busybox httpd -f -p 8080 &
                EOF

    tags = {
        Name = "terraform-example"
    }
}

resource "aws_security_group" "instance" {
    name = "terraform-example-instance"

    ingress {
        from_port = 8080
        to_port     = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
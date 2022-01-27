resource "aws_instance" "java10x_netproject_group2_server_proxy_tf" {
    ami = var.var_ami_linux_ubuntu_tf
    instance_type = "t2.micro"
    key_name = "cyber-10x-group2"
<<<<<<< HEAD

=======
    /*
>>>>>>> dev
    subnet_id = aws_subnet.java10x_netproject_group2_subnet_db_tf.id
    vpc_security_group_ids = [aws_security_group.java10x_netproject_group2_sg_db_tf.id]
    */
    subnet_id = aws_subnet.java10x_netproject_group2_subnet_proxy_tf.id
    vpc_security_group_ids = [aws_security_group.java10x_netproject_group2_sg_proxy_tf.id]
    associate_public_ip_address = false

    depends_on = [var.var_app_id_tf]

    connection {
        type = "ssh"
        host = self.public_ip
        user = "ubuntu"
        private_key = file(var.var_key_file_path_tf)
    }

//COPY CERTS | QQ: Show certs be in GitHub repo ?
    # provisioner "file" {
    #     source = "./certs"
    #     destination = "/home/ubuntu/certs"
    # }
//START NGINX
    # provisioner "remote-exec" {
    #     inline = [
    #         "sudo systemctl start nginx",
    #     ]
    # }


    tags = {
        Name = "java10x_netproject_group2_server_proxy"
    }
}

resource "aws_route53_record" "java10x_netproject_group2_r53_record_proxy_tf" {
    zone_id = var.var_zone_id_tf
    name = "proxy"
    type = "A"
    ttl = "30"

    records = [aws_instance.java10x_netproject_group2_server_proxy_tf.private_ip]
}

resource "aws_subnet" "java10x_netproject_group2_subnet_proxy_tf" {
    vpc_id = var.var_vpc_id_tf
    cidr_block = var.var_proxy_subnet_ip_tf

    tags = {
        Name = "java10x_netproject_group2_subnet_proxy_tf"
    }
}

resource "aws_route_table_association" "java10x_netproject_group2_rt_assoc_app_tf" {
    subnet_id = aws_subnet.java10x_netproject_group2_subnet_proxy_tf.id
    route_table_id = var.var_public_route_table_id_tf
}

resource "aws_security_group" "java10x_netproject_group2_sg_proxy_tf" {
    name = var.var_proxy_security_group_name_tf
    vpc_id = var.var_vpc_id_tf

    ingress {
        protocol = "tcp"
        from_port = 22
        to_port = 22
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        protocol = "tcp"
        from_port = 443
        to_port = 443
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        protocol = "tcp"
        from_port = 1024
        to_port = 65535
        cidr_blocks = ["0.0.0.0/0"]
    }


    egress {
        protocol = "tcp"
        from_port = 443
        to_port = 443
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        protocol = "tcp"
        from_port = 8080
        to_port = 8080
        cidr_blocks = ["0.0.0.0/0"]
    }


    tags = {
        Name = "java10x_netproject_group2_sg_proxy_tf"
    }
}

resource "aws_network_acl" "java10x_netproject_group2_nacl_proxy_tf" {
    vpc_id = var.var_vpc_id_tf

   ingress {
        protocol = "tcp"
        rule_no = 100
        action = "allow"
        cidr_block = "0.0.0.0/0"
        from_port = 22
        to_port = 22
    }

    ingress {
        protocol = "tcp"
        rule_no = 300
        action = "allow"
        cidr_block = "0.0.0.0/0"
        from_port = 1024
        to_port = 65535
    }

    ingress {
        protocol = "tcp"
        rule_no = 400
        action = "allow"
        cidr_block = "0.0.0.0/0"
        from_port = 443
        to_port = 443
    }


    egress {
        protocol = "tcp"
        rule_no = 200
        action = "allow"
        cidr_block = "0.0.0.0/0"
        from_port = 443
        to_port = 443
    }

    egress {
        protocol = "tcp"
        rule_no = 1000
        action = "allow"
        cidr_block = "0.0.0.0/0"
        from_port = 1024
        to_port = 65535
    }

    subnet_ids = [aws_subnet.java10x_netproject_group2_subnet_proxy_tf.id]

    tags = {
        Name = "java10x_netproject_group2_nacl_proxy"
    }
}

# Bastion Subnet
resource "aws_subnet" "java10x_netproject_group2_subnet_bastion_tf" {
    vpc_id = var.var_vpc_id_tf
    cidr_block = "10.15.3.0/24"

    tags = {
      Name = "java10x_netproject_group2_subnet_bastion"
    }
}

# Bastion Route Association
resource "aws_route_table_association" "java10x_netproject_group2_rt_assoc_bastion_tf" {
    subnet_id = aws_subnet.java10x_netproject_group2_subnet_bastion_tf.id
    route_table_id = var.var_rt_id_tf
}

# Bastion NACL
resource "aws_network_acl" "java10x_netproject_group2_nacl_bastion_tf" {
    vpc_id = var.var_vpc_id_tf

    tags = {
      Name = "java10x_netproject_group2_nacl_bastion"
    }
}

# Bastion SG

resource "aws_security_group" "java10x_netproject_group2_sg_bastion_tf" {
    name = "java10x_netproject_group2_sg_bastion"
    vpc_id = var.var_vpc_id_tf

    tags = {
      Name = "java10x_netproject_group2_sg_bastion"
    }
}

resource "aws_instance" "java10x_netproject_group2_server_bastion_tf" {
    ami = var.var_ami_linux_ubuntu_tf
    instance_type = "t2.micro"
    key_name = "cyber-10x-group2"

    subnet_id = aws_subnet.java10x_netproject_group2_subnet_bastion_tf.id
    vpc_security_group_ids = [aws_security_group.]
    associate_public_ip_address = true

    tags = {
      Name = "java10x_netproject_group2_server_bastion"
    }
}

resource "aws_route53_record" "java10x_netproject_group2_r53_record_bastion_tf" {
  zone_id = var.var_zone_id_tf
  name = "bastion"
  type = "A"
  ttl = "30"

  records = [aws_instance.java10x_netproject_group2_server_bastion_tf.private_ip]
}

// Subnet (DB)
resource "aws_subnet" "java10x_netproject_group2_subnet_db_tf" {
  vpc_id = var.var_vpc_id_tf
  cidr_block = "10.15.2.0/24"

  tags = {
    Name = "java10x_netproject_group2_subnet_db"
  }
}

// NACL (DB)
resource "aws_network_acl" "java10x_netproject_group2_nacl_db_tf" {
  vpc_id = var.var_vpc_id_tf

  // Inbound
  ingress { // HTTP
    protocol = "tcp"
    rule_no = 100
    action = "allow"
    cidr_block = "10.15.1.0/24"
    from_port = 3306
    to_port = 3306
  }

  ingress { // SSH
    protocol = "tcp"
    rule_no = 200
    action = "allow"
    cidr_block = "10.15.3.0/24"
    from_port = 22
    to_port = 22
  }

  egress { // Ephemeral
    protocol = "tcp"
    rule_no = 100
    action = "allow"
    cidr_block = "10.15.1.0/24"
    from_port = 1024
    to_port = 65535
  }

  egress { // Ephemeral
    protocol = "tcp"
    rule_no = 200
    action = "allow"
    cidr_block = "10.15.3.0/24"
    from_port = 1024
    to_port = 65535
  }
  subnet_ids = [aws_subnet.java10x_netproject_group2_subnet_db_tf.id]

  tags = {
    Name = "java10x_netproject_group2_nacl_db"
  }
}

// SECURITY GROUP (DB)
resource "aws_security_group" "java10x_netproject_group2_sg_db_tf" {

  name = "java10x_netproject_group2_sg_db" // name = "" is mandatory in SG
  vpc_id = var.var_vpc_id_tf

  ingress {
    protocol = "tcp"
    from_port = 3306
    to_port = 3306
    cidr_blocks = ["10.15.1.0/24"]
  }

  ingress {
    protocol = "tcp"
    from_port = 22
    to_port = 22
    cidr_blocks = ["10.15.3.0/24"]
  }

  tags = {
    Name = "java10x_netproject_group2_sg_db"
  }
}

// INSTANCE (DB)

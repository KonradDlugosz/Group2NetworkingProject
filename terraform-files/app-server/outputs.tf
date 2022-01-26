output "output_webserver_id" {
  value = aws_instance.java10x_netproject_group2_server_tf.*.id
}

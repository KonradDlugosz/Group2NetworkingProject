output "output_webserver_id" {
  value = aws_instance.java10x_sakila_rjanani_server_tf.*.id
}

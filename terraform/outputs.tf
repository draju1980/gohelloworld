output "app_node_public_ip" {
    description = "Public IP address of our demo node"
  value = aws_instance.app_node.public_ip
}
output "app_node_private_ip" {
    description = "Private IP address of our demo node"
  value = aws_instance.app_node.private_ip
}
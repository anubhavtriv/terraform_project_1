output "web_make_ouput" {
    value = null_resource.web_make
}
output "ec2_out" {
    value = aws_instance.apache_web
}
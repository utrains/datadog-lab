output "instance_id" {
  value = aws_instance.lab.id
}

output "public_ip" {
  value = aws_instance.lab.public_ip
}

output "public_dns" {
  value = aws_instance.lab.public_dns
}

output "app_url" {
  value = "http://${aws_instance.lab.public_ip}"
}

output "api_url" {
  value = "http://${aws_instance.lab.public_ip}:5000"
}

output "frontend_url" {
  value = "http://${aws_instance.lab.public_ip}"
}

# output "vpc_id" {
#   value = aws_vpc.lab.id
# }

# output "public_subnet_id" {
#   value = aws_subnet.public.id
# }

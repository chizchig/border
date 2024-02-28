output "instance_keys" {
  value = keys(local.instances)
}

output "subnet_keys" {
  value = keys(aws_subnet.internal_subnets)
}

output "instance_ids" {
  value = aws_instance.database_instance[*].id
}

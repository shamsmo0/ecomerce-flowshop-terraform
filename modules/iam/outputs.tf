output "ec2_instance_profile_name" {
  value = aws_iam_instance_profile.ec2_profile.name
}

output "ec2_role_arn" {
  value = aws_iam_role.ec2_role.arn
}
output "cicd_user_name" {
  value = aws_iam_user.cicd.name
}
output "cicd_access_key_id" {
  value     = aws_iam_access_key.cicd.id
  sensitive = true
}

output "cicd_secret_access_key" {
  value     = aws_iam_access_key.cicd.secret
  sensitive = true
}
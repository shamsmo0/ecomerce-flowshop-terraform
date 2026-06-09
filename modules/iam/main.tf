locals {
  tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}



resource "aws_iam_role" "ec2_role" {
  name = "${var.project_name}-${var.environment}-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name        = "${var.project_name}-${var.environment}-ec2-role"
    Environment = var.environment
    Project     = var.project_name
  }
}

resource "aws_iam_policy" "ec2_ecr_cloudwatch" {
  name        = "${var.project_name}-${var.environment}-ec2-ecr-cw-policy"
  description = "Allow EC2 to pull from ECR and send logs to CloudWatch"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogStreams"
        ]
        Resource = "arn:aws:logs:${var.aws_region}:${var.account_id}:*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ec2_ecr_cloudwatch" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.ec2_ecr_cloudwatch.arn
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "${var.project_name}-${var.environment}-ec2-profile"
  role = aws_iam_role.ec2_role.name

  tags = {
    Name        = "${var.project_name}-${var.environment}-ec2-profile"
    Environment = var.environment
    Project     = var.project_name
  }
}

resource "aws_iam_group" "developers" {
  name = "${var.project_name}-developers"
}

resource "aws_iam_group" "operators" {
  name = "${var.project_name}-operators"
}

resource "aws_iam_group" "viewers" {
  name = "${var.project_name}-viewers"
}

resource "aws_iam_group" "admins" {
  name = "${var.project_name}-admins"
}

resource "aws_iam_group_policy_attachment" "developers_ecr" {
  group      = aws_iam_group.developers.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
}

resource "aws_iam_group_policy_attachment" "developers_ec2_read" {
  group      = aws_iam_group.developers.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
}

resource "aws_iam_group_policy_attachment" "developers_s3_read" {
  group      = aws_iam_group.developers.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

resource "aws_iam_group_policy_attachment" "operators_ec2_full" {
  group      = aws_iam_group.operators.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

resource "aws_iam_group_policy_attachment" "operators_rds_read" {
  group      = aws_iam_group.operators.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonRDSReadOnlyAccess"
}

resource "aws_iam_group_policy_attachment" "viewers_read_only" {
  group      = aws_iam_group.viewers.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

resource "aws_iam_group_policy_attachment" "admins_full_access" {
  group      = aws_iam_group.admins.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
resource "aws_iam_user" "cicd" {
  name = "${var.project_name}-cicd-user"
  tags = local.tags
}
resource "aws_iam_access_key" "cicd" {
  user = aws_iam_user.cicd.name
}

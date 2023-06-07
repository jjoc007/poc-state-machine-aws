resource "aws_iam_role" "example_lambda_role" {
  name               = "example_lambda_role_poc_sf"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role" "step_functions_role" {
  name = "step_functions_role_poc_sf"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "states.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "step_functions_policy_lambda" {
  name   = "step_functions_policy_lambda_policy_all_poc_sf"
  policy = data.aws_iam_policy_document.lambda_access_policy.json
}

data "aws_iam_policy_document" "lambda_access_policy" {
  statement {
    actions = [
      "lambda:*"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_role_policy_attachment" "step_functions_to_lambda" {
  role       = aws_iam_role.step_functions_role.name
  policy_arn = aws_iam_policy.step_functions_policy_lambda.arn
}

resource "aws_iam_role_policy_attachment" "lambda_to_default" {
  role       = aws_iam_role.example_lambda_role.name
  policy_arn = aws_iam_policy.default_policy_web_step.arn
}

resource "aws_iam_policy" "default_policy_web_step" {
  name   = "step_default_policy_all_poc_sf"
  policy = data.aws_iam_policy_document.default_lambda_policy.json
}

data "aws_caller_identity" "this" {}
data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "default_lambda_policy" {
  statement {
    actions = [
      "logs:CreateLogGroup",
    ]
    resources = ["arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:*"]
  }
  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/*:*"]
  }
}

resource "aws_iam_role" "apigateway_stepfunctions_execution_role" {
  name = "apigateway_stepfunctions_execution_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "apigateway.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "apigateway_stepfunctions_execution_policy" {
  name = "apigateway_stepfunctions_execution_policy"
  role = aws_iam_role.apigateway_stepfunctions_execution_role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "states:*"
      ],
      "Resource": "${aws_sfn_state_machine.example_step_function.arn}"
    }
  ]
}
EOF
}

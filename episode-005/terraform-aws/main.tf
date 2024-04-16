### PREPARE FUNCTION NAME AND PYTHON CODE

locals {
  function_name_tf_demo = "${var.prefix}tf_demo"
}

# https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file
data "archive_file" "python_lambda_tf_demo_package" {
  type = "zip"
  source {
    content  = templatefile("files/tf_demo.py", {})
    filename = "tf_demo.py"
  }
  output_path = "files/tf_demo.zip"
}

### LAMBDA

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function
resource "aws_lambda_function" "lambda_tf_demo" {
  filename         = "files/tf_demo.zip"
  function_name    = local.function_name_tf_demo
  role             = aws_iam_role.lambda_tf_demo_role.arn
  source_code_hash = filebase64sha256("files/tf_demo.zip")

  runtime = var.runtime
  handler = "tf_demo.lambda_handler"
  timeout = 10

  environment {
    variables = {
      foo = "bar"
    }
  }

  lifecycle {
    precondition {
      condition     = startswith(var.runtime, "python")
      error_message = "Python runtime is required to deploy Lambda"
    }
  }
}


# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function_url
resource "aws_lambda_function_url" "lambda_tf_demo_endpoint" {
  function_name      = aws_lambda_function.lambda_tf_demo.function_name
  authorization_type = "AWS_IAM" # "NONE"

  cors {
    allow_credentials = true
    allow_origins     = ["*"]
    allow_methods     = ["*"]
    allow_headers     = ["date", "keep-alive"]
    expose_headers    = ["keep-alive", "date"]
    max_age           = 86400
  }
}

### IAM - LAMBDA ASSUME ROLE

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document
data "aws_iam_policy_document" "lambda_assume_role_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role
resource "aws_iam_role" "lambda_tf_demo_role" {
  name               = "${var.prefix}lambda_tf_demo_role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
}

### CLOUDWATCH LOGS

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group
resource "aws_cloudwatch_log_group" "lambda_tf_demo_log_group" {
  name              = "/aws/lambda/${local.function_name_tf_demo}"
  retention_in_days = 1
}

### IAM - CLOUDWATCH LOGS

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy
resource "aws_iam_policy" "lambda_iam_tf_demo_logging" {
  name        = "${var.prefix}lambda_logging_tf_demo"
  path        = "/"
  description = "IAM policy for logging from a lambda tf_demo"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy_attachment
resource "aws_iam_role_policy_attachment" "lambda_tf_demo_logs" {
  role       = aws_iam_role.lambda_tf_demo_role.name
  policy_arn = aws_iam_policy.lambda_iam_tf_demo_logging.arn
}

### IAM - ACCESS LAMBDA FUNCTION URL

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_user
data "aws_iam_user" "iam_user_seba" {
  user_name = "seba"
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission
resource "aws_lambda_permission" "allow_iam_user" {
  statement_id           = "AllowExecutionForIamUser"
  action                 = "lambda:InvokeFunctionUrl"
  function_name          = aws_lambda_function.lambda_tf_demo.function_name
  function_url_auth_type = "AWS_IAM"
  principal              = data.aws_iam_user.iam_user_seba.arn
}

### E2E CHECKS

# example of e2e test using check block, which validates infrastructure after Terraform applies changes
check "lambda_deployed" {
  data "external" "this" {
    program = ["curl", "${aws_lambda_function_url.lambda_tf_demo_endpoint.function_url}"]
  }

  assert {
    # If we execution function using URL without authentication, then it should be received forbidden message, if Lambda is deployed correctly
    condition = data.external.this.result.Message == "Forbidden"
    error_message = format("The Lambda %s is not deployed.",
      aws_lambda_function.lambda_tf_demo.function_name
    )
  }
}

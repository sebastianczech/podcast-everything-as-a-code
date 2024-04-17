mock_provider "aws" {
  override_data {
    target = data.aws_iam_policy_document.lambda_assume_role_policy
    values = {
      json = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      }
    }
  ]
}      
      EOF
    }
  }

  // override_data {
  //   target = data.external.this
  //   values = {
  //     id = "-"
  //     program = [
  //       "curl",
  //       "https://gxeflnzsxymlrioi7dgewcei3a0nlncj.lambda-url.us-east-1.on.aws/",
  //     ]
  //     result = {
  //       "Message" = "Forbidden"
  //     }
  //   }
  // }

  mock_data "external" {
    defaults = {
      id = "-"
      program = [
        "curl",
        "https://gxeflnzsxymlrioi7dgewcei3a0nlncj.lambda-url.us-east-1.on.aws/",
      ]
      result = {
        "Message" = "Forbidden"
      }
    }
  }

  mock_resource "aws_iam_role" {
    defaults = {
      arn = "arn:aws:iam:::role/mock"
    }
  }

  mock_resource "aws_iam_policy" {
    defaults = {
      arn = "arn:aws:iam:::policy/mock"
    }
  }

  mock_resource "aws_lambda_function_url" {
    defaults = {
      function_url = "https://mock.lambda-url.us-east-1.on.aws"
    }
  }
}

variables {
  prefix = "evcode_mock_"
}

run "valid_lambda_function_name" {
  command = apply

  assert {
    condition     = aws_lambda_function.lambda_tf_demo.function_name == local.function_name_tf_demo
    error_message = "Lambda function name did not match expected"
  }
}
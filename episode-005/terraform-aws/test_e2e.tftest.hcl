variables {
  prefix = "evcode_test_"
}

run "invalid_prefix_length" {
  command = plan

  variables {
    prefix = "prefix_with_length_more_than_16_characters"
  }

  expect_failures = [
    var.prefix,
  ]
}

run "valid_lambda_runtime" {
  command = apply

  variables {
    runtime = "python3.10"
  }

  assert {
    condition     = aws_lambda_function.lambda_tf_demo.runtime == var.runtime
    error_message = "Lambda runtime did not match expected"
  }
}

run "valid_lambda_function_name" {
  command = apply

  assert {
    condition     = aws_lambda_function.lambda_tf_demo.function_name == local.function_name_tf_demo
    error_message = "Lambda function name did not match expected"
  }
}
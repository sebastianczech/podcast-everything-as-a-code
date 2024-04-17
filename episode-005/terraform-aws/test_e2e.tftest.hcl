# variable values defined globally for all tests
variables {
  prefix = "evcode_test_"
}

run "invalid_prefix_length" {
  # command can be "plan" or "apply"
  command = plan

  variables {
    prefix = "prefix_with_length_more_than_16_characters"
  }

  # in test we are expecting that validation for provided variable should fail
  expect_failures = [
    var.prefix,
  ]
}

# every run block is responsible for 1 test
run "valid_lambda_runtime" {
  # Terraform creates new infrastructure for tests
  command = apply

  # variable values defined localy only for that test
  variables {
    runtime = "python3.10"
  }

  # check condition and if it fails, return error message
  assert {
    condition     = aws_lambda_function.lambda_tf_demo.runtime == var.runtime
    error_message = "Lambda runtime did not match expected"
  }
}

run "valid_lambda_function_name" {
  # Terraform to not create new infrastructure for this run block, we are reusing infrastructure created in previous test
  command = apply

  assert {
    condition     = aws_lambda_function.lambda_tf_demo.function_name == local.function_name_tf_demo
    error_message = "Lambda function name did not match expected"
  }
}
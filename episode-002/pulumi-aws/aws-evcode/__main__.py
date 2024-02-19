"""An AWS Python Pulumi program"""

import json
from zipfile import ZipFile

import pulumi as pulumi
from pulumi_aws import iam, lambda_


# Prepare ZIP file with generated Python code
zipObj = ZipFile('files/tf_demo.zip', 'w')

# Fix problem with zip - now in zip there is tf_demo.py instead files/tf_demo.py (without files directory)
zipObj.write(filename='files/tf_demo.py', arcname='tf_demo.py')
zipObj.close()

# Create IAM policy: https://www.pulumi.com/registry/packages/aws/api-docs/iam/policy/
pulumi_lambda_iam_tf_demo_logging = iam.Policy("pulumi_lambda_iam_tf_demo_logging",
                                                path="/",
                                                description="IAM policy for Lambda tf_demo & CloudWatch logs",
                                                policy=json.dumps({
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
                                                }))

# Create IAM role: https://www.pulumi.com/registry/packages/aws/api-docs/iam/role/
pulumi_iam_for_lambda_tf_demo = iam.Role("pulumi_lambda_tf_demo_role", assume_role_policy="""{
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
""")

# Create IAM role policy attachment: https://www.pulumi.com/registry/packages/aws/api-docs/iam/rolepolicyattachment/
pulumi_lambda_tf_demo_logs = iam.RolePolicyAttachment("pulumi_lambda_tf_demo_logs",
                                                       role=pulumi_iam_for_lambda_tf_demo.name,
                                                       policy_arn=pulumi_lambda_iam_tf_demo_logging.arn)

# Create Lambda: https://www.pulumi.com/registry/packages/aws/api-docs/lambda/function/
pulumi_lambda_tf_demo = lambda_.Function("pulumi_lambda_tf_demo",
                                          code=pulumi.FileArchive("files/tf_demo.zip"),
                                          role=pulumi_iam_for_lambda_tf_demo.arn,
                                          handler="tf_demo.lambda_handler",
                                          runtime="python3.9",
                                          environment=lambda_.FunctionEnvironmentArgs(
                                              variables={
                                                  "foo": "bar",
                                              },
                                          ))

# Create Lambda function URL: https://www.pulumi.com/registry/packages/aws/api-docs/lambda/functionurl/
pulumi_lambda_tf_demo_endpoint = lambda_.FunctionUrl("pulumi_lambda_tf_demo_endpoint",
                                                      function_name=pulumi_lambda_tf_demo.name,
                                                      authorization_type="AWS_IAM",
                                                      cors=lambda_.FunctionUrlCorsArgs(
                                                          allow_credentials=True,
                                                          allow_origins=["*"],
                                                          allow_methods=["*"],
                                                          allow_headers=[
                                                              "date",
                                                              "keep-alive",
                                                          ],
                                                          expose_headers=[
                                                              "keep-alive",
                                                              "date",
                                                          ],
                                                          max_age=86400,
                                                      ))

# Get user: https://www.pulumi.com/registry/packages/aws/api-docs/iam/getuser/
iam_user_seba = iam.get_user(user_name="seba")

# Create Lambda permission: https://www.pulumi.com/registry/packages/aws/api-docs/lambda/permission/
allow_iam_user = lambda_.Permission("AllowExecutionForIamUser",
                                    action="lambda:InvokeFunctionUrl",
                                    function=pulumi_lambda_tf_demo.name,
                                    principal=iam_user_seba.arn,
                                    function_url_auth_type="AWS_IAM"
                                    )

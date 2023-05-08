resource "aws_sfn_state_machine" "example_step_function" {
  name     = "example_step_function"
  role_arn = aws_iam_role.step_functions_role.arn

  definition = jsonencode(
  {
    "Comment": "A simple AWS Step Functions state machine that automates a call center support session.",
    "StartAt": "ProcessTransaction",
    "States": {
      "ProcessTransaction": {
        "Type" : "Choice",
        "Choices": [
          {
            Variable: "$.step",
            StringEquals: "QUERY_BLACKLIST",
            Next: "QueryBlacklist"
          }
        ]
      },
      "QueryBlacklist": {
        "Type": "Task",
        "Resource": aws_lambda_function.query_blacklist_lambda.arn,
        "End": true
      }
    }
  })
}

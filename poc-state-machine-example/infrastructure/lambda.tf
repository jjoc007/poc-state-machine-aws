resource "aws_lambda_function" "query_blacklist_lambda" {
  filename      =  data.archive_file.query_blacklist.output_path
  source_code_hash = data.archive_file.query_blacklist.output_base64sha256
  function_name = "poc_query_blacklist_lambda"
  role          = aws_iam_role.example_lambda_role.arn
  handler       = "query-blacklist/main.handler"
  runtime = "nodejs18.x"

}
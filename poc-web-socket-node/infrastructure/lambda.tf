resource "aws_lambda_function" "poc_web_socket_connect_lambda" {
  filename      =  data.archive_file.OnConnectZip.output_path
  source_code_hash = data.archive_file.OnConnectZip.output_base64sha256
  function_name = "poc_web_socket_connect_lambda"
  role          = aws_iam_role.websocket_lambda_role.arn
  handler       = "onConnect/main.handler"
  runtime = "nodejs18.x"

  environment {
    variables = {
      TABLE_WEB_SOCKET_NAME = aws_dynamodb_table.poc_web_socket_table.name
      API_GATEWAY_ID = aws_apigatewayv2_api.poc_web_socket_api.id
      TEST = "a"
    }
  }
}

resource "aws_lambda_function" "poc_web_socket_connect_lambda_2" {
  filename      =  data.archive_file.OnConnectZip.output_path
  source_code_hash = data.archive_file.OnConnectZip.output_base64sha256
  function_name = "poc_web_socket_connect_lambda_2"
  role          = aws_iam_role.websocket_lambda_role.arn
  handler       = "onConnect/main.handler"
  runtime = "nodejs18.x"

  environment {
    variables = {
      TABLE_WEB_SOCKET_NAME = aws_dynamodb_table.poc_web_socket_table.name
      API_GATEWAY_ID = aws_apigatewayv2_api.poc_web_socket_api.id
      TEST = "a"
    }
  }
}

resource "aws_lambda_function" "poc_web_socket_disconnect_lambda" {
  filename      =  data.archive_file.OnDisconnectZip.output_path
  source_code_hash = data.archive_file.OnDisconnectZip.output_base64sha256
  function_name = "poc_web_socket_disconnect_lambda"
  role          = aws_iam_role.websocket_lambda_role.arn
  handler       = "onDisconnect/main.handler"
  runtime = "nodejs18.x"

  environment {
    variables = {
      TABLE_WEB_SOCKET_NAME = aws_dynamodb_table.poc_web_socket_table.name
      API_GATEWAY_ID = aws_apigatewayv2_api.poc_web_socket_api.id
      TEST = "a"
    }
  }
}

resource "aws_lambda_function" "poc_web_socket_message_lambda" {
  filename      =  data.archive_file.MessageZip.output_path
  source_code_hash = data.archive_file.MessageZip.output_base64sha256
  function_name = "poc_web_socket_message_lambda"
  role          = aws_iam_role.websocket_lambda_role.arn
  handler       = "sendMessage/main.handler"
  runtime = "nodejs18.x"

  environment {
    variables = {
      TABLE_WEB_SOCKET_NAME = aws_dynamodb_table.poc_web_socket_table.name
      API_GATEWAY_ID = aws_apigatewayv2_api.poc_web_socket_api.id
      ENVIRONMENT = "dev"
      TEST = "a"
    }
  }
}
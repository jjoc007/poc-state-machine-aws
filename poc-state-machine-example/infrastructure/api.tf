resource "aws_api_gateway_rest_api" "api_poc" {
  name        = "my_api"
  description = "My API service"
}

resource "aws_api_gateway_resource" "resource" {
  rest_api_id = aws_api_gateway_rest_api.api_poc.id
  parent_id   = aws_api_gateway_rest_api.api_poc.root_resource_id
  path_part   = "process"
}

resource "aws_api_gateway_method" "method" {
  rest_api_id   = aws_api_gateway_rest_api.api_poc.id
  resource_id   = aws_api_gateway_resource.resource.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "integration" {
  rest_api_id = aws_api_gateway_rest_api.api_poc.id
  resource_id = aws_api_gateway_resource.resource.id
  http_method = aws_api_gateway_method.method.http_method

  type                    = "AWS"
  integration_http_method = "POST"
  uri                     = "arn:aws:apigateway:us-east-1:states:action/StartSyncExecution"
  credentials             = aws_iam_role.apigateway_stepfunctions_execution_role.arn

  request_templates = {
    "application/json" = <<EOF
#set($body= $input.json('$'))
#set($inputRoot='{ "data" :'+$body+',"apiInfo":{"httpMethod" :"'+ $context.httpMethod+'", "apiKey":"'+ $context.identity.apiKey+'"}}')
#set($apiData=$util.escapeJavaScript($inputRoot))
#set($apiData=$apiData.replaceAll("\\'","'"))
{
  "input" :"$apiData",
  "stateMachineArn": "${aws_sfn_state_machine.example_step_function.arn}"
}
EOF
  }

  request_parameters = {
    "integration.request.header.X-Amz-Invocation-Type" = "'RequestResponse'"
  }

}

resource "aws_api_gateway_method_response" "response_200" {
  rest_api_id = aws_api_gateway_rest_api.api_poc.id
  resource_id = aws_api_gateway_resource.resource.id
  http_method = aws_api_gateway_method.method.http_method
  status_code = "200"
}

resource "aws_api_gateway_integration_response" "MyDemoIntegrationResponse" {
  rest_api_id = aws_api_gateway_rest_api.api_poc.id
  resource_id = aws_api_gateway_resource.resource.id
  http_method = aws_api_gateway_method.method.http_method
  status_code = aws_api_gateway_method_response.response_200.status_code

  # Transforms the backend JSON response to XML
  response_templates = {
    "application/json" = <<EOF
#set ($bodyObj = $util.parseJson($input.body))
#set ($outObj = $util.parseJson($bodyObj.output))
#set($context.responseOverride.status = $outObj.statusCode)
$outObj.body
EOF
  }
}
resource "aws_cognito_user_pool" "tc_cognito_user_pool" {
  name = "tc_cognito_user_pool"

  email_verification_subject = "Your Verification Code"
  email_verification_message = "Please use the following code: {####}"
  alias_attributes           = ["email"]
  auto_verified_attributes   = ["email"]

  admin_create_user_config {
    allow_admin_create_user_only = true
  }

  password_policy {
    minimum_length    = 10
    require_lowercase = true
    require_numbers   = true
    require_symbols   = true
    require_uppercase = true
  }

  username_configuration {
    case_sensitive = false
  }

  schema {
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = true
    name                     = "email"
    required                 = true

    string_attribute_constraints {
      min_length = 7
      max_length = 256
    }
  }

  schema {
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = true
    name                     = "name"
    required                 = true

    string_attribute_constraints {
      min_length = 3
      max_length = 256
    }
  }
}

resource "aws_cognito_user_pool_client" "tc_cognito_user_pool_client" {
  name                = "tc_cognito_user_pool_client"

  supported_identity_providers = [ "COGNITO" ]

  callback_urls = [ "https://example.com" ]

  user_pool_id = aws_cognito_user_pool.tc_cognito_user_pool.id
  generate_secret = true
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows = [ "code", "implicit" ]
  allowed_oauth_scopes = [ "email", "openid", "profile" ]
}

resource "aws_apigatewayv2_authorizer" "cognito_authorizer" {
  api_id           = aws_apigatewayv2_api.tc_api_gateway.id
  authorizer_type  = "JWT"
  identity_sources = ["$request.header.Authorization"]
  name             = "cognito-authorizer"

  jwt_configuration {
    audience = [aws_cognito_user_pool_client.tc_cognito_user_pool_client.id]
    issuer   = var.cognitoIssuerUrl
  }
}

resource "aws_cognito_user_pool_domain" "tc_cognito_user_pool_domain" {
  domain       = "postechgrupocincosoat"
  user_pool_id = aws_cognito_user_pool.tc_cognito_user_pool.id
}
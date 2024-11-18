# resource "aws_s3_bucket" "backend_bucket" {
#   bucket = "tc_tf_backend"
# }

terraform {
  backend "s3" {
    bucket = "tc-tf-backend"
    key    = "backend/terraform.tfstate"
    region = "us-east-1"
  }
}
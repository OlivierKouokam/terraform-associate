terraform {
  backend "s3" {
    bucket = "terraform-backend-olivier"
    key = "remotedemo.tfstate"
    region = "us-east-1"
    profile = "default"
    shared_credentials_files = ["../.secrets/credentials"]
    dynamodb_table = "s3-state-lock"
  }
}
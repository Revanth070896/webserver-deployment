 terraform {
   backend "s3" {
     bucket         = "tf-state-backend-assign"
     key            = "prod/terraform.tfstate"
     region         = "eu-west-2"
     dynamodb_table = "terraform_state_lock"
  }
}
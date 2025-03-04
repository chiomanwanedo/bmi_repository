terraform {
  backend "s3" {
    bucket         = "bmi-terraform-state"
    key            = "terraform.tfstate"
    region         = "eu-west-2
    encrypt        = true
    dynamob_table = 
  }
}

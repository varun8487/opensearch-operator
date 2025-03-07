terraform {
  backend "s3" {
    bucket = "test-007891"
    key    = "dev/eks/terraform.tfstate"
    region = "us-east-1"
  }
}


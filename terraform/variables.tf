# variables
variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-central-1"
}

variable "aws_access_key" {
  description = "AWS access key"
  type        = string
  sensitive   = true # terraform will never print this value in logs or terminal output, now knows they are sensitive
}

variable "aws_secret_key" {
  description = "AWS secret key"
  type        = string
  sensitive   = true
}

variable "instance_type" {
  description = "EC2 instance type"
  type = string
  default = "t2.micro"
}

variable "client_public_key" {
  description = "WireGuard public key of the client"
  type = string
}
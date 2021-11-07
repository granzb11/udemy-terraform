variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {
    default = "us-east-1"
}
variable "AMIS" {
    type = map
    default = {
        us-east-1 = "ami-0133407e358cc1af0"
        us-east-2 = "ami-01685d240b8fbbfeb"
        us-west-2 = "ami-079e7a3f57cc8e0d0"
    }
}

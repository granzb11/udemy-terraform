terraform {
    backend "s3" {
        bucket = "terraform-state-5fld0"
        key    = "terraform/demo4"
    }
}
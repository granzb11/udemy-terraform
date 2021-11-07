# udemy-terraform
Udemy Terraform course taught by Edward Viaene.

Course URL: https://usaa.udemy.com/course/learn-devops-infrastructure-automation-with-terraform/learn/lecture/5890850#overview


## Demo 2 - Provisioning Software:
The overall theme for this demo was to show how to kick off an EC2 instance and remotely execute a script which would perform software provisioning on that instance. For this specific script, it was just setting up a web server by installing and kicking off `nginx`.

In this demo, we performed the following:
1. Create a public/private key pair
2. Spin up an EC2 instance and set the appropriate keypairs to allow for SSH
3. Manually updated security group permissions for our VPC to allow external calls from my IP
4. In instance.tf
   1. `resource "aws_key_pair" "mykey"` - This setups the key pair for the public key for the EC2 instance.
   2. `resource "aws_instance" "example"` - This setups the EC2 instance with the addition of assigning the public key.
   3. `provisioner "file"` - This allows us to copy a file into the EC2 instance.
   4. `provisioner "remote-exec"` - This allows us to run remote commands on the specified EC2 instance.
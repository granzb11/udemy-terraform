# udemy-terraform
Udemy Terraform course taught by Edward Viaene.

Course URL: https://usaa.udemy.com/course/learn-devops-infrastructure-automation-with-terraform/learn/lecture/5890850#overview


## Demo 2 - Provisioning Software:
The overall theme for this demo was to show how to kick off an EC2 instance and remotely execute a script which would perform software provisioning on that instance. For this specific script, it was just setting up a web server by installing and kicking off `nginx`.

In this demo, we performed the following:
1. Create a public/private key pair
2. Spin up an EC2 instance and set the appropriate keypairs to allow for SSH
3. Manually updated security group permissions for our VPC to allow external calls from my IP
4. In `instance.tf`:
   1. `resource "aws_key_pair" "mykey"` - This setups the key pair for the public key for the EC2 instance.
   2. `resource "aws_instance" "example"` - This setups the EC2 instance with the addition of assigning the public key.
   3. `provisioner "file"` - This allows us to copy a file into the EC2 instance.
   4. `provisioner "remote-exec"` - This allows us to run remote commands on the specified EC2 instance.

## Demo 3 - Outputting Attributes
The overrall purpose for this demo is to demonstrate how we can output provisioned services attributes back on the LOCAL machine and not on the instance that gets spun up.

In this demo, we performed the following:
1. In `instance.tf`:
   1. `provisioner "local-exec"` - This allows us to run commands on the LOCAL machine but access attributes from the instance. As you see in the example, we're going to write out the **private ip** into a file for the instance that gets spun up. The file gets created on the LOCAL machine.
   2. `output "ip"` - This allows us to directly display to the console specific attributes from the created instance.

## Demo 4 - Remote State
The overrall purpose for this demo is to demonstrate how to store the state of our infrastructure remotely on AWS. Terraform keeps the **remote state** of the infratructure.  Typically terraform creates a few files locally to store it's state:
 * `terraform.tfstate` - This stores the current remote state
 * `terraform.tfstate.backup` - This store the previous remote state

When we execute `terraform apply`, a new terraform.tfstate and backup is written. This is how terraform keeps track of the remote state. These files can be stored in `git`. It gives us a history of our terraform.state file.

The `terraform state` can be saved remotely, using the `backend` functionality in terraform. The default is `local backend` aka the local files that are discussed above. Other backends include: [s3 (with locking), consul (with locking), terraform enterprise (commercial solution)]

Terraform backend benefinits:
  * Working in team: it allows for collaboration, the remote state will always be available for the whole team. Keep in mind if `locking` is enabled, this means that only one person can alter the terraform state. This is good and bad because no conflicts, but only 1 person can push changes.
  * The state file is not stored locally. Possible sensitive information is now only sotred in the remote state

There are 2 steps to configure remote state:
  * Add the backend code to a `.tf` file
  * Run the initialization process


## Demo 5 - Datasources
The overall theme for this demo was to show how to use `datasources` within terraform. Learn more about data sources here - [Terraform Data Sources Documentation](https://www.terraform.io/docs/language/data-sources/index.html)

  * For certain providers (like AWS), terraform provides datasources which provide us with dynamic information:
    * A lot of data is available by AWS in a structured format using thier API.
    * Terraform also exposes this information using data sources
  * Examples:
    * List of AMIs
    * List of availability zones

In this demo, we performed the following:
1. In `securitygroup.tf`:
   1. `data "aws_ip_ranges" "european_ec2"` - This sets up which data source we want. Here we wanted to get certain AWS IP ranges. You can see we have filtered down by using `region` and `services`.
   2. `resource "aws_security_group" "from_europe"` - This is to create a brand new security group within our default VPC. This new security group is going to set it's inbound rules by `cidr_blocks` which uses the `data.aws_ip_ranges.european_ec2` previously set up at the top of the file. This is useful because these IP ranges are DYNAMIC aka they change all the time. This is how we would setup our inbound rules by IP ranges dynamically.

## Demo 6 - Provider Templates and Modules

## Provider Templates
* The provider template can help creating customized configuration files
* You can build templates based on variables from terraform resource attributes (e.g. a public IP address)
* The result is a string that can be used as a variable in terra
  * The string contains a template
  * e.g. a configuration file
* Can be used to create generic tempalte or cloud init configs
* In AWS, you can pass commands that need to be executed when the instance starts for the first time -- this is called "user-data"
* If you want to pass user-data that depends on other information in terraform (e.g. IP address), you can use the provider template.

## Modules
* You can use modules to make your terraform more organized
* Use third party modules
  * from github
  * reuse parts of your code
    * e.g. to set up network in AWS - the VPC
* To use a module from git
  * ```yaml
    module "module-example"{
        source = "github.com/my-repo/terraform-module-example"
    }
    ```
* To use a module from a local folder
  * ```yaml
    module "module-example" {
        source = "./module-example"
    }
    ```
* You can pass arguments to a module
* You can use the output from the module in the main part of your code
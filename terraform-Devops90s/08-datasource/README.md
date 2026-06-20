datasource:
resource blocks ar eused to create services/resources inside provider platform ,we can use data sources to query the existing information in provider

syntax
data "aws_instance" "foo" {
  instance_id = "i-instanceid"

  filter {
    name   = "image-id"
    values = ["ami-xxxxxxxx"]
  }

  filter {
    name   = "tag:Name"
    values = ["instance-name-tag"]
  }
}
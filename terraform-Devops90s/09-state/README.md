terraform creates the seclared infra,it should match actual infra with desired infra always
desired/declared/asked/expected
terraform sores what it has created in statefile,it is like memory to terraform
after terraform apply state file will be created
in collaboration environment ,we must maintain state file remotely to prevent errors and duplicates.it should be locked as well
===
securing the state file
it is owned by terraform 100%,we are not allowd to touch
user should not have state file delete access
we enable versions
we enable data replication as backup 
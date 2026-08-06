project_id  = "project-f69b612e-dd6f-4ddc-a25"
org_id      = "985831748852"
environment = "dev-scaleset"

vpc_name = "umzy-vpc-scaleset"

subnets = {
  us_south1 = {
    name           = "umzy-subnet-us-south1"
    region         = "us-south1"
    subnet_ip_cidr = "10.128.0.0/20"
  }
}

vm_us_south1 = {
  instance_name  = "umzy-app-vm-scaleset"
  zone           = "us-south1-a"
  machine_type   = "e2-micro"
  instance_count = 4
}

vm_europe_west1 = {
  instance_name  = "umzy-app-vm-europe"
  zone           = "europe-west1-b"
  machine_type   = "e2-micro"
  instance_count = 0
}

bucket_name = "umzy-dev-storage-bkt-scaleset"

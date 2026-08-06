project_id  = "project-f69b612e-dd6f-4ddc-a25"
org_id      = "985831748852"
environment = "prod"

vpc_name = "umzy-vpc-prod-regional"

subnets = {
  us_south1 = {
    name           = "umzy-subnet-prod-us-south1"
    region         = "us-south1"
    subnet_ip_cidr = "10.128.0.0/20"
  }
  europe_west1 = {
    name           = "umzy-subnet-prod-europe-west1"
    region         = "europe-west1"
    subnet_ip_cidr = "10.132.0.0/20"
  }
}

vm_us_south1 = {
  instance_name  = "umzy-vm-prod-us-south1"
  zone           = "us-south1-a"
  machine_type   = "e2-standard-2"
  instance_count = 1
}

vm_europe_west1 = {
  instance_name  = "umzy-vm-prod-europe-west1"
  zone           = "europe-west1-b"
  machine_type   = "e2-standard-2"
  instance_count = 1
}

bucket_name = "umzy-prod-storage-bkt-regional"

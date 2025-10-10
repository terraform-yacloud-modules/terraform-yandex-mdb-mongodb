data "yandex_client_config" "client" {}

module "network" {
  source = "git::https://github.com/terraform-yacloud-modules/terraform-yandex-vpc.git?ref=v1.0.0"

  folder_id = data.yandex_client_config.client.folder_id

  blank_name = "mongodb-vpc-nat-gateway"
  labels = {
    repo = "terraform-yacloud-modules/terraform-yandex-vpc"
  }

  azs = ["ru-central1-a", "ru-central1-b"]

  private_subnets = [["10.5.0.0/24"], ["10.6.0.0/24"]]

  create_vpc         = true
  create_nat_gateway = true
}

module "mongodb_cluster" {
  source = "../"

  network_id = module.network.vpc_id
  subnet_id  = module.network.private_subnets_ids[0]

  cluster_name               = "test-cluster"
  environment                = "PRESTABLE"
  mongodb_version            = "7.0"
  labels                     = { test_key = "test_value" }
  database_name              = "testdb"
  user_name                  = "john"
  user_password              = "password"
  resources_mongod_preset    = "s2.small"
  resources_mongod_disk_size = 16
  resources_mongod_disk_type = "network-hdd"

  feature_compatibility_version = "6.0"

  mongod_hosts = [
    {
      zone_id   = "ru-central1-a"
      subnet_id = module.network.private_subnets_ids[0]
    },
    {
      zone_id   = "ru-central1-b"
      subnet_id = module.network.private_subnets_ids[1]
    }
  ]
  deletion_protection = false
  backup_window_start = {
    hours   = 2
    minutes = 0
  }
  performance_diagnostics = {
    enabled = true
  }
  access = {
    data_lens     = true
    data_transfer = true
  }
  #   maintenance_window_type = "ANYTIME"

  depends_on = [module.network]
}

data "yandex_client_config" "client" {}

module "network" {
  source = "git::https://github.com/terraform-yacloud-modules/terraform-yandex-vpc.git?ref=v1.0.0"

  folder_id = data.yandex_client_config.client.folder_id

  blank_name = "mongodb-vpc-nat-gateway"
  labels = {
    repo = "terraform-yacloud-modules/terraform-yandex-vpc"
  }

  azs = ["ru-central1-a"]

  private_subnets = [["10.5.0.0/24"]]

  create_vpc         = true
  create_nat_gateway = true
}

module "mongodb_cluster" {
  source = "../"

  network_id = module.network.vpc_id
  subnet_id  = module.network.private_subnets_ids[0]

  cluster_name               = "test-cluster"
  environment                = "PRESTABLE"
  mongodb_version            = "5.0"
  labels                     = { test_key = "test_value" }
  database_name              = "testdb"
  user_name                  = "john"
  user_password              = "password"
  resources_mongod_preset    = "s2.small"
  resources_mongod_disk_size = 16
  resources_mongod_disk_type = "network-hdd"
  mongod_hosts               = [{ subnet_id = module.network.private_subnets_ids[0] }, { subnet_id = module.network.private_subnets_ids[0] }]
  #   maintenance_window_type = "ANYTIME"

  depends_on = [module.network]
}

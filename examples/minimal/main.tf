data "yandex_client_config" "client" {}

module "network" {
  source = "git::https://github.com/terraform-yacloud-modules/terraform-yandex-vpc.git?ref=v1.0.0"

  blank_name      = "mongodb-vpc"
  folder_id       = data.yandex_client_config.client.folder_id
  azs             = ["ru-central1-a", "ru-central1-b"]
  private_subnets = [["10.5.0.0/24"], ["10.6.0.0/24"]]
}

module "mongodb_cluster" {
  source = "../"

  network_id = module.network.vpc_id
  subnet_id  = module.network.private_subnets_ids[0]

  cluster_name    = "test-cluster"
  environment     = "PRESTABLE"
  mongodb_version = "7.0"
  database_name   = "testdb"
  user_name       = "john"
  user_password   = "password"

  resources_mongod_preset    = "s2.small"
  resources_mongod_disk_size = 16
  resources_mongod_disk_type = "network-hdd"

  resources_mongos = {
    resource_preset_id = "s2.small"
    disk_size          = 16
    disk_type_id       = "network-hdd"
  }

  resources_mongocfg = {
    resource_preset_id = "s2.small"
    disk_size          = 16
    disk_type_id       = "network-hdd"
  }

  mongod_hosts = [
    {
      zone_id   = "ru-central1-a"
      subnet_id = module.network.private_subnets_ids[0]
      type      = "MONGOD"
    },
    {
      zone_id   = "ru-central1-b"
      subnet_id = module.network.private_subnets_ids[1]
      type      = "MONGOD"
    },
    {
      zone_id   = "ru-central1-a"
      subnet_id = module.network.private_subnets_ids[0]
      type      = "MONGOS"
    },
    {
      zone_id   = "ru-central1-b"
      subnet_id = module.network.private_subnets_ids[1]
      type      = "MONGOS"
    },
    {
      zone_id   = "ru-central1-a"
      subnet_id = module.network.private_subnets_ids[0]
      type      = "MONGOCFG"
    },
    {
      zone_id   = "ru-central1-b"
      subnet_id = module.network.private_subnets_ids[1]
      type      = "MONGOCFG"
    },
    {
      zone_id   = "ru-central1-a"
      subnet_id = module.network.private_subnets_ids[0]
      type      = "MONGOCFG"
    }
  ]
  deletion_protection = false
}

module "mongodb_cluster" {
  source = "../"

  network_id = "xxxx"
  subnet_id  = "xxxx"

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
  #   maintenance_window_type = "ANYTIME"
}

resource "yandex_vpc_network" "mongodb_network" {
  name = var.network_name
  folder_id = var.folder_id
}

resource "yandex_vpc_subnet" "mongodb_subnet" {
  name           = var.subnet_name
  zone           = var.subnet_zone
  folder_id      = var.folder_id
  network_id     = yandex_vpc_network.mongodb_network.id
  v4_cidr_blocks = var.subnet_cidr_blocks
}

resource "yandex_mdb_mongodb_cluster" "mongodb_cluster" {
  name        = var.cluster_name
  environment = var.environment
  folder_id   = var.folder_id
  network_id  = yandex_vpc_network.mongodb_network.id

  cluster_config {
    version = var.mongodb_version
  }

  labels = var.labels

  resources_mongod {
    resource_preset_id = var.resources_mongod_preset
    disk_size          = var.resources_mongod_disk_size
    disk_type_id       = var.resources_mongod_disk_type
  }

  host {
    zone_id   = var.subnet_zone
    subnet_id = yandex_vpc_subnet.mongodb_subnet.id
  }

  # Убираем блок maintenance_window, если он не нужен
  # maintenance_window {
  #   type = var.maintenance_window_type
  # }
}

resource "yandex_mdb_mongodb_database" "mongodb_database" {
  cluster_id = yandex_mdb_mongodb_cluster.mongodb_cluster.id
  name       = var.database_name
}

resource "yandex_mdb_mongodb_user" "mongodb_user" {
  cluster_id = yandex_mdb_mongodb_cluster.mongodb_cluster.id
  name       = var.user_name
  password   = var.user_password
  permission {
    database_name = var.database_name
  }
}

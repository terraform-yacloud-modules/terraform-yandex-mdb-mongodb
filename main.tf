data "yandex_client_config" "client" {}

resource "yandex_mdb_mongodb_cluster" "mongodb_cluster" {
  name        = var.cluster_name
  environment = var.environment
  folder_id   = var.folder_id == null ? data.yandex_client_config.client.folder_id : var.folder_id
  network_id  = var.network_id

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
    zone_id   = var.zone_id
    subnet_id = var.subnet_id
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

  # Добавляем зависимость от ресурса базы данных
  depends_on = [yandex_mdb_mongodb_database.mongodb_database]
}

data "yandex_client_config" "client" {}

resource "yandex_mdb_mongodb_cluster" "mongodb_cluster" {
  name        = var.cluster_name
  environment = var.environment
  folder_id   = data.yandex_client_config.client.folder_id
  network_id  = var.network_id

  cluster_config {
    version                       = var.mongodb_version
    feature_compatibility_version = var.feature_compatibility_version

    dynamic "backup_window_start" {
      for_each = var.backup_window_start != null ? [var.backup_window_start] : []
      content {
        hours   = backup_window_start.value.hours
        minutes = backup_window_start.value.minutes
      }
    }

    dynamic "performance_diagnostics" {
      for_each = var.performance_diagnostics != null ? [var.performance_diagnostics] : []
      content {
        enabled = performance_diagnostics.value.enabled
      }
    }

    dynamic "access" {
      for_each = var.access != null ? [var.access] : []
      content {
        data_lens     = access.value.data_lens
        data_transfer = access.value.data_transfer
      }
    }
  }

  labels = var.labels

  resources_mongod {
    resource_preset_id = var.resources_mongod_preset
    disk_size          = var.resources_mongod_disk_size
    disk_type_id       = var.resources_mongod_disk_type
  }

  dynamic "host" {
    for_each = var.mongod_hosts
    content {
      assign_public_ip = try(host.value.assign_public_ip, false)
      zone_id          = try(host.value.zone_id, var.zone_id)
      subnet_id        = try(host.value.subnet_id, var.subnet_id)
    }
  }

  # Убираем блок maintenance_window, если он не нужен
  # maintenance_window {
  #   type = var.maintenance_window_type
  # }

  security_group_ids  = var.security_group_ids
  deletion_protection = var.deletion_protection
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
    roles         = var.user_roles
  }

  # Добавляем зависимость от ресурса базы данных
  depends_on = [yandex_mdb_mongodb_database.mongodb_database]
}

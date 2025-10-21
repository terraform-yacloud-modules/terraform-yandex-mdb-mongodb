data "yandex_client_config" "client" {}

resource "yandex_mdb_mongodb_cluster" "mongodb_cluster" {
  name        = var.cluster_name
  description = var.description
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
        web_sql       = access.value.web_sql
      }
    }

    backup_retain_period_days = var.backup_retain_period_days
  }

  labels = var.labels

  resources_mongod {
    resource_preset_id = var.resources_mongod_preset
    disk_size          = var.resources_mongod_disk_size
    disk_type_id       = var.resources_mongod_disk_type
  }

  dynamic "resources_mongos" {
    for_each = var.resources_mongos != null ? [var.resources_mongos] : []
    content {
      resource_preset_id = resources_mongos.value.resource_preset_id
      disk_size          = resources_mongos.value.disk_size
      disk_type_id       = resources_mongos.value.disk_type_id
    }
  }

  dynamic "resources_mongocfg" {
    for_each = var.resources_mongocfg != null ? [var.resources_mongocfg] : []
    content {
      resource_preset_id = resources_mongocfg.value.resource_preset_id
      disk_size          = resources_mongocfg.value.disk_size
      disk_type_id       = resources_mongocfg.value.disk_type_id
    }
  }

  dynamic "host" {
    for_each = var.mongod_hosts
    content {
      assign_public_ip = try(host.value.assign_public_ip, false)
      zone_id          = try(host.value.zone_id, var.zone_id)
      subnet_id        = try(host.value.subnet_id, var.subnet_id)
      type             = try(host.value.type, "MONGOD")
    }
  }

  dynamic "maintenance_window" {
    for_each = var.maintenance_window != null ? [var.maintenance_window] : []
    content {
      type = maintenance_window.value.type
      day  = try(maintenance_window.value.day, null)
      hour = try(maintenance_window.value.hour, null)
    }
  }

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

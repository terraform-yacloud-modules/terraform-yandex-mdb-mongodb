module "wrapper" {
  source = "../"

  for_each = var.items

  # Required variables
  subnet_id                  = try(each.value.subnet_id, var.defaults.subnet_id, null)
  network_id                 = try(each.value.network_id, var.defaults.network_id, null)
  cluster_name               = try(each.value.cluster_name, var.defaults.cluster_name, null)
  environment                = try(each.value.environment, var.defaults.environment, null)
  mongodb_version            = try(each.value.mongodb_version, var.defaults.mongodb_version, null)
  database_name              = try(each.value.database_name, var.defaults.database_name, null)
  user_name                  = try(each.value.user_name, var.defaults.user_name, null)
  user_password              = try(each.value.user_password, var.defaults.user_password, null)
  resources_mongod_preset    = try(each.value.resources_mongod_preset, var.defaults.resources_mongod_preset, null)
  resources_mongod_disk_size = try(each.value.resources_mongod_disk_size, var.defaults.resources_mongod_disk_size, null)
  resources_mongod_disk_type = try(each.value.resources_mongod_disk_type, var.defaults.resources_mongod_disk_type, null)
  mongod_hosts               = try(each.value.mongod_hosts, var.defaults.mongod_hosts, null)

  # Optional variables
  zone_id                          = try(each.value.zone_id, var.defaults.zone_id, "ru-central1-a")
  description                      = try(each.value.description, var.defaults.description, null)
  feature_compatibility_version    = try(each.value.feature_compatibility_version, var.defaults.feature_compatibility_version, null)
  labels                           = try(each.value.labels, var.defaults.labels, {})
  user_roles                       = try(each.value.user_roles, var.defaults.user_roles, ["readWrite"])
  resources_mongos                 = try(each.value.resources_mongos, var.defaults.resources_mongos, null)
  resources_mongocfg               = try(each.value.resources_mongocfg, var.defaults.resources_mongocfg, null)
  resources_mongoinfra             = try(each.value.resources_mongoinfra, var.defaults.resources_mongoinfra, null)
  maintenance_window               = try(each.value.maintenance_window, var.defaults.maintenance_window, null)
  security_group_ids               = try(each.value.security_group_ids, var.defaults.security_group_ids, [])
  deletion_protection              = try(each.value.deletion_protection, var.defaults.deletion_protection, false)
  backup_window_start              = try(each.value.backup_window_start, var.defaults.backup_window_start, null)
  performance_diagnostics          = try(each.value.performance_diagnostics, var.defaults.performance_diagnostics, null)
  access                           = try(each.value.access, var.defaults.access, null)
  backup_retain_period_days        = try(each.value.backup_retain_period_days, var.defaults.backup_retain_period_days, null)
  disk_encryption_key_id           = try(each.value.disk_encryption_key_id, var.defaults.disk_encryption_key_id, null)
  disk_size_autoscaling_mongod     = try(each.value.disk_size_autoscaling_mongod, var.defaults.disk_size_autoscaling_mongod, null)
  disk_size_autoscaling_mongocfg   = try(each.value.disk_size_autoscaling_mongocfg, var.defaults.disk_size_autoscaling_mongocfg, null)
  disk_size_autoscaling_mongoinfra = try(each.value.disk_size_autoscaling_mongoinfra, var.defaults.disk_size_autoscaling_mongoinfra, null)
  disk_size_autoscaling_mongos     = try(each.value.disk_size_autoscaling_mongos, var.defaults.disk_size_autoscaling_mongos, null)
  restore                          = try(each.value.restore, var.defaults.restore, null)
  timeouts                         = try(each.value.timeouts, var.defaults.timeouts, null)
}

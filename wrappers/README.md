# MongoDB Cluster Wrapper

Wrapper module for creating multiple MongoDB clusters with shared default values.

## Usage

```hcl
module "mongodb_clusters" {
  source = "terraform-yacloud-modules/mdb-mongodb/yandex//wrappers"

  defaults = {
    environment                = "PRODUCTION"
    mongodb_version            = "7.0"
    resources_mongod_preset    = "s2.micro"
    resources_mongod_disk_type = "network-ssd"
    resources_mongod_disk_size = 10
    security_group_ids         = ["sg-123456"]
    deletion_protection        = true
  }

  items = {
    app-cluster = {
      cluster_name  = "mongodb-app"
      network_id    = "enp1234567890"
      subnet_id     = "e9b1234567890"
      database_name = "app_db"
      user_name     = "app_user"
      user_password = "secure_password_1"
      mongod_hosts = [
        { subnet_id = "e9b1234567890", zone_id = "ru-central1-a" }
      ]
    }

    analytics-cluster = {
      cluster_name               = "mongodb-analytics"
      network_id                 = "enp1234567890"
      subnet_id                  = "e9b1234567890"
      database_name              = "analytics_db"
      user_name                  = "analytics_user"
      user_password              = "secure_password_2"
      resources_mongod_disk_size = 50  # Override default
      mongod_hosts = [
        { subnet_id = "e9b1234567890", zone_id = "ru-central1-a" },
        { subnet_id = "e9b0987654321", zone_id = "ru-central1-b" },
        { subnet_id = "e9b1122334455", zone_id = "ru-central1-d" }
      ]
    }
  }
}
```

## Example with All Options

```hcl
module "mongodb_clusters" {
  source = "terraform-yacloud-modules/mdb-mongodb/yandex//wrappers"

  defaults = {
    environment                = "PRODUCTION"
    mongodb_version            = "7.0"
    resources_mongod_preset    = "s2.small"
    resources_mongod_disk_type = "network-ssd"
    resources_mongod_disk_size = 20
    deletion_protection        = true

    backup_window_start = {
      hours   = 3
      minutes = 0
    }

    maintenance_window = {
      type = "WEEKLY"
      day  = "SUN"
      hour = 4
    }

    access = {
      data_lens     = true
      data_transfer = true
      web_sql       = false
    }
  }

  items = {
    production = {
      cluster_name  = "mongodb-prod"
      description   = "Production MongoDB cluster"
      network_id    = "enp1234567890"
      subnet_id     = "e9b1234567890"
      database_name = "production_db"
      user_name     = "admin"
      user_password = "very_secure_password"
      user_roles    = ["readWrite", "dbAdmin"]

      labels = {
        environment = "production"
        team        = "backend"
      }

      disk_size_autoscaling_mongod = {
        disk_size_limit           = 100
        planned_usage_threshold   = 80
        emergency_usage_threshold = 90
      }

      mongod_hosts = [
        { subnet_id = "e9b1234567890", zone_id = "ru-central1-a", assign_public_ip = false },
        { subnet_id = "e9b0987654321", zone_id = "ru-central1-b", assign_public_ip = false },
        { subnet_id = "e9b1122334455", zone_id = "ru-central1-d", assign_public_ip = false }
      ]
    }
  }
}
```

## Accessing Outputs

```hcl
# Get cluster ID
output "app_cluster_id" {
  value = module.mongodb_clusters.wrapper["app-cluster"].id
}

# Get all cluster IDs
output "all_cluster_ids" {
  value = { for k, v in module.mongodb_clusters.wrapper : k => v.id }
}

# Get database IDs
output "database_ids" {
  value = { for k, v in module.mongodb_clusters.wrapper : k => v.database_id }
}
```

## Variables

| Name | Description | Type | Default |
|------|-------------|------|---------|
| `defaults` | Map of default values which will be used for each item | `any` | `{}` |
| `items` | Maps of items to create a wrapper from. Values are passed through to the module | `any` | `{}` |

## Module Variables Reference

Each item in `items` map accepts the following variables:

### Required

| Name | Description |
|------|-------------|
| `subnet_id` | The ID of the subnet for the host |
| `network_id` | ID of the network for the cluster |
| `cluster_name` | Name of the MongoDB cluster |
| `environment` | Deployment environment (`PRODUCTION` or `PRESTABLE`) |
| `mongodb_version` | MongoDB version (`7.0` or `8.0`) |
| `database_name` | Name of the database |
| `user_name` | Name of the user |
| `user_password` | Password of the user |
| `resources_mongod_preset` | Resource preset ID (`s2.micro`, `s2.small`, `s2.medium`) |
| `resources_mongod_disk_size` | Disk size in GB |
| `resources_mongod_disk_type` | Disk type (`network-hdd`, `network-ssd`, `local-ssd`) |
| `mongod_hosts` | List of MongoDB hosts |

### Optional

| Name | Description | Default |
|------|-------------|---------|
| `zone_id` | Zone for allocating address | `ru-central1-a` |
| `description` | Cluster description | `null` |
| `labels` | Key/value labels | `{}` |
| `user_roles` | User roles | `["readWrite"]` |
| `security_group_ids` | Security group IDs | `[]` |
| `deletion_protection` | Inhibit cluster deletion | `false` |
| `backup_window_start` | Backup window settings | `null` |
| `maintenance_window` | Maintenance window settings | `null` |
| `access` | Access policy settings | `null` |
| `performance_diagnostics` | Performance diagnostics settings | `null` |
| `backup_retain_period_days` | Backup retention period | `null` |
| `disk_encryption_key_id` | KMS key ID for encryption | `null` |
| `resources_mongos` | Resources for mongos hosts | `null` |
| `resources_mongocfg` | Resources for mongocfg hosts | `null` |
| `resources_mongoinfra` | Resources for mongoinfra hosts | `null` |
| `disk_size_autoscaling_mongod` | Autoscaling for mongod | `null` |
| `disk_size_autoscaling_mongos` | Autoscaling for mongos | `null` |
| `disk_size_autoscaling_mongocfg` | Autoscaling for mongocfg | `null` |
| `disk_size_autoscaling_mongoinfra` | Autoscaling for mongoinfra | `null` |
| `restore` | Restore from backup settings | `null` |
| `timeouts` | Operation timeouts | `null` |
| `feature_compatibility_version` | Feature compatibility version | `null` |

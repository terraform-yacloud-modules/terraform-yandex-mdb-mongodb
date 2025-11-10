variable "subnet_id" {
  description = "The ID of the subnet, to which the host belongs. The subnet must be a part of the network to which the cluster belongs"
  type        = string
}

variable "network_id" {
  description = "ID of the network, to which the Redis cluster belongs"
  type        = string
}

variable "zone_id" {
  description = "Zone for allocating address"
  type        = string
  default     = "ru-central1-a"
}

variable "cluster_name" {
  description = "Name of the MongoDB cluster"
  type        = string
}

variable "description" {
  description = "Description of the MongoDB cluster"
  type        = string
  default     = null
}

variable "environment" {
  description = "Deployment environment of the MongoDB cluster"
  type        = string
  validation {
    condition     = contains(["PRODUCTION", "PRESTABLE"], var.environment)
    error_message = "The environment must be either PRODUCTION or PRESTABLE."
  }
}

variable "mongodb_version" {
  description = "Version of the MongoDB server"
  type        = string
  validation {
    condition     = contains(["7.0", "8.0"], var.mongodb_version)
    error_message = "The MongoDB server version must be 7.0 or 8.0."
  }
}

variable "feature_compatibility_version" {
  description = "Feature compatibility version of MongoDB"
  type        = string
  default     = null
}

variable "labels" {
  description = "A set of key/value label pairs to assign to the MongoDB cluster"
  type        = map(string)
  default     = {}
}

variable "database_name" {
  description = "Name of the database"
  type        = string
}

variable "user_name" {
  description = "Name of the user"
  type        = string
}

variable "user_password" {
  description = "Password of the user"
  type        = string
}

variable "user_roles" {
  description = "Roles of the user"
  type        = list(any)
  default     = ["readWrite"]
}

variable "resources_mongod_preset" {
  description = "The ID of the preset for computational resources available to a MongoDB host"
  type        = string
  validation {
    condition     = contains(["s2.micro", "s2.small", "s2.medium"], var.resources_mongod_preset) # Add more as per docs
    error_message = "Invalid resource preset ID."
  }
}

variable "resources_mongod_disk_size" {
  description = "Volume of the storage available to a MongoDB host, in gigabytes"
  type        = number
}

variable "resources_mongod_disk_type" {
  description = "Type of the storage of MongoDB hosts"
  type        = string
  validation {
    condition     = contains(["network-hdd", "network-ssd", "local-ssd"], var.resources_mongod_disk_type)
    error_message = "Invalid disk type."
  }
}

variable "resources_mongos" {
  description = "Resources for mongos hosts"
  type = object({
    resource_preset_id = string
    disk_size          = number
    disk_type_id       = string
  })
  default = null
  validation {
    condition = var.resources_mongos == null || (
      contains(["s2.micro", "s2.small", "s2.medium"], var.resources_mongos.resource_preset_id) &&
      contains(["network-hdd", "network-ssd", "local-ssd"], var.resources_mongos.disk_type_id)
    )
    error_message = "Invalid resources for mongos."
  }
}

variable "resources_mongocfg" {
  description = "Resources for mongocfg hosts"
  type = object({
    resource_preset_id = string
    disk_size          = number
    disk_type_id       = string
  })
  default = null
  validation {
    condition = var.resources_mongocfg == null || (
      contains(["s2.micro", "s2.small", "s2.medium"], var.resources_mongocfg.resource_preset_id) &&
      contains(["network-hdd", "network-ssd", "local-ssd"], var.resources_mongocfg.disk_type_id)
    )
    error_message = "Invalid resources for mongocfg."
  }
}

variable "mongod_hosts" {
  description = "List of hosts in MongoDB cluster."
  type = list(object({
    assign_public_ip = optional(bool, false)
    zone_id          = optional(string, "ru-central1-a")
    subnet_id        = string
    type             = optional(string, "MONGOD")
  }))
}

variable "maintenance_window" {
  description = "Maintenance window settings for the MongoDB cluster"
  type = object({
    type = optional(string)
    day  = optional(string)
    hour = optional(number)
  })
  default = null
  validation {
    condition = var.maintenance_window == null || (
      var.maintenance_window.type == "ANYTIME" ||
      (var.maintenance_window.type == "WEEKLY" &&
       contains(["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"], var.maintenance_window.day) &&
       var.maintenance_window.hour >= 1 && var.maintenance_window.hour <= 24)
    )
    error_message = "For WEEKLY maintenance window, day must be MON-SUN and hour 1-24. For ANYTIME, only type should be specified."
  }
}

variable "security_group_ids" {
  description = "A set of ids of security groups assigned to hosts of the cluster"
  type        = list(string)
  default     = []
}

variable "deletion_protection" {
  description = "Inhibits deletion of the cluster"
  type        = bool
  default     = false
}

variable "backup_window_start" {
  description = "Time to start the daily backup, in the UTC timezone"
  type = object({
    hours   = optional(number)
    minutes = optional(number)
  })
  default = null
}

variable "performance_diagnostics" {
  description = "Performance diagnostics to the MongoDB cluster"
  type = object({
    enabled = optional(bool)
  })
  default = null
}

variable "access" {
  description = "Access policy to the MongoDB cluster"
  type = object({
    data_lens     = optional(bool)
    data_transfer = optional(bool)
    web_sql       = optional(bool)
  })
  default = null
}



variable "backup_retain_period_days" {
  description = "Retention period for automatic backups in days"
  type        = number
  default     = null
}

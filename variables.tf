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

variable "environment" {
  description = "Deployment environment of the MongoDB cluster"
  type        = string
  validation {
    condition     = contains(["PRESTABLE", "PRODUCTION"], var.environment)
    error_message = "The environment must be either PRESTABLE or PRODUCTION."
  }
}

variable "mongodb_version" {
  description = "Version of the MongoDB server"
  type        = string
  validation {
    condition     = contains(["7.0", "8.0"], var.mongodb_version)
    error_message = "The MongoDB server version must be 7.0, 8.0"
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
}

variable "resources_mongod_disk_size" {
  description = "Volume of the storage available to a MongoDB host, in gigabytes"
  type        = number
}

variable "resources_mongod_disk_type" {
  description = "Type of the storage of MongoDB hosts"
  type        = string
}

variable "mongod_hosts" {
  description = "List of hosts in MongoDB cluster."
  type = list(object({
    assign_public_ip = optional(bool, false)
    zone_id          = optional(string, "ru-central1-a")
    subnet_id        = string
  }))
}

# Убираем переменную maintenance_window_type, если она не нужна
# variable "maintenance_window_type" {
#   description = "Type of maintenance window"
#   type        = string
#   validation {
#     condition     = contains(["ANYTIME", "WEEKLY"], var.maintenance_window_type)
#     error_message = "The maintenance window type must be either ANYTIME or WEEKLY."
#   }
# }

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
  })
  default = null
}

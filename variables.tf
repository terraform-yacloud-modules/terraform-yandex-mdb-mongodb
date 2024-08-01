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
  description = "Version of the MongoDB server software"
  type        = string
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

variable "maintenance_window_type" {
  description = "Type of maintenance window. Can be either ANYTIME or WEEKLY."
  type        = string
  default     = "WEEKLY"
}

variable "maintenance_window_day" {
  description = "Day of week for maintenance window if window type is weekly. Possible values: MON, TUE, WED, THU, FRI, SAT, SUN."
  type        = string
  default     = "MON"
}

variable "maintenance_window_hour" {
  description = "Hour of day in UTC time zone (1-24) for maintenance window if window type is weekly."
  type        = number
  default     = 3
}

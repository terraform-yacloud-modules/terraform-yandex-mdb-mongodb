variable "folder_id" {
  default = ""
}

variable "network_name" {
  description = "Name of the VPC network"
  type        = string
}

variable "subnet_name" {
  description = "Name of the VPC subnet"
  type        = string
}

variable "subnet_zone" {
  description = "Availability zone for the subnet"
  type        = string
}

variable "subnet_cidr_blocks" {
  description = "CIDR blocks for the subnet"
  type        = list(string)
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
  description = "Type of maintenance window"
  type        = string
  validation {
    condition     = contains(["ANYTIME", "WEEKLY"], var.maintenance_window_type)
    error_message = "The maintenance window type must be either ANYTIME or WEEKLY."
  }
}

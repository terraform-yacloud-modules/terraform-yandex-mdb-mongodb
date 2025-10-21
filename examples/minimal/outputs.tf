output "id" {
  description = "The ID of the MongoDB cluster"
  value       = module.mongodb_cluster.id
}

output "name" {
  description = "The name of the MongoDB cluster"
  value       = module.mongodb_cluster.name
}

output "database_id" {
  description = "The ID of the MongoDB database"
  value       = module.mongodb_cluster.database_id
}

output "user_id" {
  description = "The ID of the MongoDB user"
  value       = module.mongodb_cluster.user_id
}

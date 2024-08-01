output "id" {
  description = "The ID of the MongoDB cluster"
  value       = yandex_mdb_mongodb_cluster.mongodb_cluster.id
}

output "name" {
  description = "The name of the MongoDB cluster"
  value       = yandex_mdb_mongodb_cluster.mongodb_cluster.name
}

output "database_id" {
  description = "The ID of the MongoDB database"
  value       = yandex_mdb_mongodb_database.mongodb_database.id
}

output "user_id" {
  description = "The ID of the MongoDB user"
  value       = yandex_mdb_mongodb_user.mongodb_user.id
}

# Yandex Cloud <RESOURCE> Terraform module

Terraform module which creates Yandex Cloud <RESOURCE> resources.

## Examples

Examples codified under
the [`examples`](https://github.com/terraform-yacloud-modules/terraform-yandex-module-template/tree/main/examples) are intended
to give users references for how to use the module(s) as well as testing/validating changes to the source code of the
module. If contributing to the project, please be sure to make any appropriate updates to the relevant examples to allow
maintainers to test your changes and to keep the examples up to date for users. Thank you!

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_yandex"></a> [yandex](#requirement\_yandex) | >= 0.72.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_yandex"></a> [yandex](#provider\_yandex) | >= 0.72.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [yandex_mdb_mongodb_cluster.mongodb_cluster](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_mongodb_cluster) | resource |
| [yandex_mdb_mongodb_database.mongodb_database](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_mongodb_database) | resource |
| [yandex_mdb_mongodb_user.mongodb_user](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_mongodb_user) | resource |
| [yandex_client_config.client](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the MongoDB cluster | `string` | n/a | yes |
| <a name="input_database_name"></a> [database\_name](#input\_database\_name) | Name of the database | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Deployment environment of the MongoDB cluster | `string` | n/a | yes |
| <a name="input_labels"></a> [labels](#input\_labels) | A set of key/value label pairs to assign to the MongoDB cluster | `map(string)` | `{}` | no |
| <a name="input_maintenance_window_day"></a> [maintenance\_window\_day](#input\_maintenance\_window\_day) | Day of week for maintenance window if window type is weekly. Possible values: MON, TUE, WED, THU, FRI, SAT, SUN. | `string` | `"MON"` | no |
| <a name="input_maintenance_window_hour"></a> [maintenance\_window\_hour](#input\_maintenance\_window\_hour) | Hour of day in UTC time zone (1-24) for maintenance window if window type is weekly. | `number` | `3` | no |
| <a name="input_maintenance_window_type"></a> [maintenance\_window\_type](#input\_maintenance\_window\_type) | Type of maintenance window. Can be either ANYTIME or WEEKLY. | `string` | `"WEEKLY"` | no |
| <a name="input_mongodb_version"></a> [mongodb\_version](#input\_mongodb\_version) | Version of the MongoDB server software | `string` | n/a | yes |
| <a name="input_network_id"></a> [network\_id](#input\_network\_id) | ID of the network, to which the Redis cluster belongs | `string` | n/a | yes |
| <a name="input_resources_mongod_disk_size"></a> [resources\_mongod\_disk\_size](#input\_resources\_mongod\_disk\_size) | Volume of the storage available to a MongoDB host, in gigabytes | `number` | n/a | yes |
| <a name="input_resources_mongod_disk_type"></a> [resources\_mongod\_disk\_type](#input\_resources\_mongod\_disk\_type) | Type of the storage of MongoDB hosts | `string` | n/a | yes |
| <a name="input_resources_mongod_preset"></a> [resources\_mongod\_preset](#input\_resources\_mongod\_preset) | The ID of the preset for computational resources available to a MongoDB host | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | The ID of the subnet, to which the host belongs. The subnet must be a part of the network to which the cluster belongs | `string` | n/a | yes |
| <a name="input_user_name"></a> [user\_name](#input\_user\_name) | Name of the user | `string` | n/a | yes |
| <a name="input_user_password"></a> [user\_password](#input\_user\_password) | Password of the user | `string` | n/a | yes |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | Zone for allocating address | `string` | `"ru-central1-a"` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## License

Apache-2.0 Licensed.
See [LICENSE](https://github.com/terraform-yacloud-modules/terraform-yandex-module-template/blob/main/LICENSE).

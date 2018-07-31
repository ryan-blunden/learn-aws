variable "name" {}

variable "allocated_storage" {
  default = 5
}

variable "storage_encrypted" {
  default = false
}

variable "replicate_source_db" {
  description = "Specifies that this resource is a Replicate database, and to use this value as the source database. This correlates to the identifier of another Amazon RDS Database to replicate."
  default = ""
}

variable "snapshot_identifier" {
  description = "Specifies whether or not to create this database from a snapshot. This correlates to the snapshot ID you'd find in the RDS console, e.g: rds:production-2015-06-26-06-05."
  default = ""
}

variable "iam_database_authentication_enabled" {
  default = false
}

variable "engine" {}
variable "version" {}

variable "instance_class" {
  default = "t2.large"
}

variable "username" {}
variable "password" {}
variable "port" {}

variable "final_snapshot_identifier" {
  description = "The name of your final DB snapshot when this DB instance is deleted."
  default = false
}

variable "vpc_security_group_ids" {
  description = "List of VPC security groups to associate"
  default = []
}

variable "multi_az" {
  default = false
}

variable "iops" {
  description = "The amount of provisioned IOPS. Setting this implies a storage_type of 'io1'"
  default = 0
}

variable "monitoring_interval" {
  description = "The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. To disable collecting Enhanced Monitoring metrics, specify 0. The default is 0. Valid Values: 0, 1, 5, 10, 15, 30, 60."
  default = 0
}

variable "monitoring_role_arn" {
  description = "The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch Logs. Must be specified if monitoring_interval is non-zero."
  default = ""
}

variable "monitoring_role_name" {
  description = "Name of the IAM role which will be created when create_monitoring_role is enabled."
  default = "rds-monitoring-role"
}

variable "create_monitoring_role" {
  description = "Create IAM role with a defined name that permits RDS to send enhanced monitoring metrics to CloudWatch Logs."
  default = false
}

variable "allow_major_version_upgrade" {
  default = false
}

variable "auto_minor_version_upgrade" {
  default = true
}

variable "apply_immediately" {
  description = "Apply database modifications immediately, or during the next maintenance window"
  default = false
}

variable "maintenance_window" {
  description = "Syntax: 'ddd:hh24:mi-ddd:hh24:mi'. Eg: 'Mon:00:00-Mon:03:00'"
}

variable "skip_final_snapshot" {
  default = true
}

variable "copy_tags_to_snapshot" {
  description = "On delete, copy all Instance tags to the final snapshot (if final_snapshot_identifier is specified)"
  default = false
}

variable "backup_retention_period" {
  description = "The days to retain backups for"
  default = 1
}

variable "backup_window" {
  description = "The daily time range (in UTC) during which automated backups are created if they are enabled. Example: '09:46-10:16'. Must not overlap with maintenance_window"
}

variable "tags" {
  description = "A mapping of tags to assign to all resources"
  default = {}
}

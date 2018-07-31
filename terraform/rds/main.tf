resource "aws_iam_role" "enhanced_monitoring" {
  name = "${var.name}-rds-monitoring-role"
  assume_role_policy = "${file("resources/enhanced-monitoring.json")}"
}

resource "aws_iam_role_policy_attachment" "enhanced_monitoring" {
  role = "${var.name}-${aws_iam_role.enhanced_monitoring.name}-policy"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}

resource "aws_db_instance" "this" {
  identifier = "${var.name}"

  engine = "mysql"
  engine_version = "${var.version}"
  instance_class = "db.t2.large"
  allocated_storage = "${var.allocated_storage}"
  storage_type = "gp2"

  username = "${var.username}"
  password = "${var.password}"
  port = "${var.port}"

  replicate_source_db = "${var.replicate_source_db}"

  snapshot_identifier = "${var.snapshot_identifier}"

  vpc_security_group_ids = ["${var.vpc_security_group_ids}"]
  db_subnet_group_name = "${var.name}-db-subnet-group"
  parameter_group_name = "${var.name}-param-group"
  option_group_name = "${var.name}-option-group"

  availability_zone = "${var.name}"
  multi_az = "${var.multi_az}"
  iops = "${var.iops}"
  publicly_accessible = false
  monitoring_interval = "${var.monitoring_interval}"
  monitoring_role_arn = "${coalesce(var.monitoring_role_arn, join("", aws_iam_role.enhanced_monitoring.*.arn))}"

  allow_major_version_upgrade = "${var.allow_major_version_upgrade}"
  auto_minor_version_upgrade = "${var.auto_minor_version_upgrade}"
  apply_immediately = "${var.apply_immediately}"
  maintenance_window = "${var.maintenance_window}"
  skip_final_snapshot = "${var.skip_final_snapshot}"
  copy_tags_to_snapshot = "${var.copy_tags_to_snapshot}"
  final_snapshot_identifier = "${var.final_snapshot_identifier}"

  backup_retention_period = "${var.backup_retention_period}"
  backup_window = "${var.backup_window}"

  tags = "${merge(var.tags, map("Name", format("%s", var.name)))}"
}

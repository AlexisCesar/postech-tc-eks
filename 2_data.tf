data "aws_iam_role" "labrole" {
  name = "LabRole"
}

# data "aws_db_instance" "tc_pg_db" {
#   db_instance_identifier = "tc-pg-db"
# }
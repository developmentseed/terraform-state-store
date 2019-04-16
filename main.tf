module "store" {
  source = "./state-store"

  region = "${var.region}"

  table_name  = "${var.table_name}"
  bucket_name = "${var.bucket_name}"
}

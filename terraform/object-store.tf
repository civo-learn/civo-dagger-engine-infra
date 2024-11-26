resource "random_string" "object_store_prefix" {
  length           = 6
  special          = false
  lower = true
  upper = false
}

resource "civo_object_store_credential" "object-store-credential" {
  name = "${random_string.object_store_prefix.result}-dagger-objectstore-credential"
}

resource "civo_object_store" "object-store" {
  name        = "${random_string.object_store_prefix.result}-dagger-objectstore"
  max_size_gb = var.object_store_size
  access_key_id = civo_object_store_credential.object-store-credential.access_key_id
}

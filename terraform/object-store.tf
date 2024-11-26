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

resource "kubernetes_namespace" "dagger" {
  metadata {
    name = "dagger"
  }
}

resource "kubernetes_secret" "dagger_cache_config" {
  metadata {
    name = "dagger-cache-config"
    namespace = kubernetes_namespace.dagger.metadata.0.name
  }


  data = {
    "_EXPERIMENTAL_DAGGER_CACHE_CONFIG" = "type=s3,mode=max,endpoint_url=https://objectstore.${lower(var.civo_region)}.civo.com,use_path_style=true,prefix=dagger-engine/,access_key_id=${civo_object_store_credential.object-store-credential.access_key_id},secret_access_key=${civo_object_store_credential.object-store-credential.secret_access_key},bucket=${civo_object_store.object-store.name},region=${lower(var.civo_region)}"
  }
  
}


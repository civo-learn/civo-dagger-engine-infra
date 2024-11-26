resource "helm_release" "dagger_engine" {
    name = "dagger"
    namespace = "dagger"
    create_namespace = true

    # repository = "oci://registry.dagger.io"
    # chart = "dagger-helm"
    chart = "./chart"

    set {
        name = "envFromSecretName"
        value = resource.kubernetes_secret.dagger_cache_config.metadata.0.name
    }
}

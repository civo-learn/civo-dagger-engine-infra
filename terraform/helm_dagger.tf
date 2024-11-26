resource "helm_release" "dagger_engine" {
    name = "dagger"
    namespace = "dagger"
    create_namespace = true

    repository = "oci://registry.dagger.io"  
    chart = "dagger-helm"
}

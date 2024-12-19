# Dagger Engine on Civo Cloud Template

[![Civo Kubernetes](https://img.shields.io/badge/Civo%20Kubernetes-05264c?style=flat&logo=kubernetes&logoColor=white)](https://civo.com)
[![Dagger](https://img.shields.io/badge/Dagger-0C344B?style=flat&logo=dagger&logoColor=white)](https://dagger.io)
[![Template](https://img.shields.io/badge/Template-blue?style=flat&logo=github&logoColor=white)](https://github.com/civo-learn/civo-dagger-engine-infra/generate)

A template repository for deploying a Dagger Engine on Civo Cloud, providing distributed build caching and efficient CI/CD pipelines using Civo's managed Kubernetes and Object Storage services.

## Features

- 🚀 Managed Kubernetes cluster on Civo Cloud
- 📦 Object Storage configuration for Dagger's build cache
- 🔒 Secure network and firewall setup
- ⚙️ Automated Helm deployment of the Dagger Engine
- 💾 Persistent cache storage across builds

## Prerequisites

- [Civo Account](https://civo.com) and [API Key](https://dashboard.civo.com/security)
- [Terraform](https://www.terraform.io/downloads.html) 
- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- [Dagger CLI](https://docs.dagger.io/cli/465058/install)

## Getting Started

1. **Use this template**
   - Click the "Use this template" button above or [click here](https://github.com/civo-learn/civo-dagger-engine-infra/generate)
   - Clone your new repository

2. **Configure Civo credentials**

The provider will use the credentials of the Civo CLI (stored in `~/.civo.json`) if no other credentials have been set up. The provider will use credentials in the following order:

1. Environment variable (`CIVO_TOKEN`).
2. Token provided via a credentials file (See `credentials_file` input below).
3. CLI configuration (`~/.civo.json`).

That means that if the `CIVO_TOKEN` variable is set, all other credentials will be ignored, and if the `credentials_file` is set, that will be used over the CLI credentials.

To set the `CIVO_TOKEN` environment variable:
```bash
export CIVO_TOKEN="your-api-token"
```

3. **Deploy the infrastructure**
```bash
cd terraform
terraform init
terraform apply
```

4. **Configure kubectl**

```bash
export KUBECONFIG=$(pwd)/kubeconfig
kubectl get nodes
```

5. **Connect to Dagger Engine**

```bash
# Get the Dagger Engine pod name
DAGGER_ENGINE_POD_NAME="$(kubectl get pod \
    --selector=name=dagger-dagger-helm-engine \
    --namespace=dagger \
    --output=jsonpath='{.items[0].metadata.name}')"

# Configure Dagger runner
export _EXPERIMENTAL_DAGGER_RUNNER_HOST="kube-pod://$DAGGER_ENGINE_POD_NAME?namespace=dagger"
```

6. **Verify the setup**

```bash
dagger query <<EOF
{
    container {
        from(address:"alpine") {
            withExec(args: ["uname", "-a"]) { stdout }
        }
    }
}
EOF
```

## Customization

Modify `terraform.tfvars` or set variables during apply:

```hcl
civo_region        = "LON1"          # Civo region
cluster_node_count = 3               # Number of K8s nodes
cluster_node_size  = "g4s.kube.medium" # Node size
object_store_size  = 500             # Cache storage in GB
```

## Infrastructure Components

- **Kubernetes Cluster**: Runs the Dagger Engine
- **Object Storage**: Persistent cache for build artifacts
- **Firewall**: Secure access control
- **Helm Release**: Dagger Engine deployment
- **Kubernetes Secret**: Cache configuration

## Cache Monitoring

View your cache usage:
1. Civo Console: Object Storage → Buckets
2. Dagger CLI: `dagger core engine local-cache entry-set`

## Cleanup

Remove all resources:

```bash
terraform destroy
```

## Support & Community

- [Civo Community](https://www.civo.com/community)
- [Dagger Discord](https://discord.gg/dagger-io)
- [Open an Issue](https://github.com/civo-learn/civo-dagger-engine-infra/issues)

## License

This template is available under the [MIT License](LICENSE).

## References

- [Dagger Documentation](https://docs.dagger.io)
- [Civo Documentation](https://www.civo.com/docs)
- [Dagger Kubernetes Integration](https://docs.dagger.io/integrations/kubernetes)

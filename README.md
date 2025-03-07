# OpenSearch on Kubernetes using Operator

This project provides Terraform configuration to deploy an Amazon EKS cluster and then install OpenSearch using the OpenSearch Operator on the cluster.

## Project Structure

```
zterraform/
├── backend.tf
├── k8s/
│   ├── cluster.yaml
│   └── operator.yaml
├── main.tf
├── modules/
│   └── eks/
│       ├── main.tf
│       └── variable.tf
├── provider.tf
├── README.md
├── terraform.tfvars
└── variables.tf
```

## Prerequisites

- AWS CLI configured with appropriate credentials
- Terraform (version >= 1.0.0)
- kubectl
- AWS IAM permissions to create EKS clusters

## Deployment Steps

### Step 1: Deploy the EKS Cluster using Terraform

```bash
# Navigate to the terraform directory
cd zterraform

# Initialize Terraform
terraform init

# Review the deployment plan
terraform plan

# Deploy the infrastructure
terraform apply
```

This will create:
- An EKS cluster in your AWS account
- Required IAM roles and policies
- Workload Identity configuration for secure pod authentication

### Step 2: Configure kubectl to Connect to Your EKS Cluster

```bash
# Update your kubeconfig file
aws eks update-kubeconfig --name <cluster-name> --region <region>

# Verify the connection
kubectl get nodes
```

### Step 3: Deploy the OpenSearch Operator

```bash
# Navigate to the k8s directory
cd ../k8s

# Apply the operator configuration
kubectl apply -f operator.yaml

# Wait for the operator to be fully deployed
kubectl get deployments -A
```

### Step 4: Deploy OpenSearch using the Operator

```bash
# Apply the OpenSearch custom resource
kubectl apply -f cluster.yaml

# Check deployment status
kubectl get opensearchclusters
kubectl get pods -A
```

## Validation

To validate that your OpenSearch deployment is working correctly:

1. Check the status of the OpenSearch pods:
```bash
kubectl get pods -l opensearch.cluster=<cluster-name>
```

2. Port-forward to access the OpenSearch dashboard:
```bash
kubectl port-forward svc/<service-name> 9200:9200
```

3. Access OpenSearch in your browser:
```
https://localhost:9200
```

4. Use the following command to get the initial admin credentials:
```bash
kubectl get secret <opensearch-secret-name> -o jsonpath='{.data.admin-password}' | base64 --decode
```

## Security Best Practices

This deployment implements several security best practices:

1. **Workload Identity**: Instead of using static credentials, pods authenticate to AWS services using IAM roles.

2. **Network Policies**: Restricting traffic between pods based on defined policies.

3. **RBAC**: Properly configured role-based access control for the Kubernetes resources.

4. **Secrets Management**: Secure handling of credentials using Kubernetes secrets.

5. **Least Privilege**: IAM roles and Kubernetes service accounts follow the principle of least privilege.

## Cost Optimization

This deployment is optimized for cost by:

1. Using EKS Autopilot where appropriate to optimize cluster management costs.

2. Implementing appropriate instance sizing for OpenSearch nodes.

3. Using node groups with spot instances for non-critical workloads.

4. Setting up autoscaling to adjust resources based on actual usage.

5. Implementing proper resource requests and limits to ensure efficient resource utilization.

## Troubleshooting

If you encounter issues:

1. Check the operator logs:
```bash
kubectl logs -n opensearch-operator-system -l control-plane=controller-manager
```

2. Check the OpenSearch pod logs:
```bash
kubectl logs -l opensearch.cluster=<cluster-name>
```

3. Verify the OpenSearch custom resource status:
```bash
kubectl describe opensearchcluster <cluster-name>
```

## Cleanup

To clean up all resources:

```bash
# Delete the OpenSearch resources
kubectl delete -f file.yaml

# Delete the operator
kubectl delete -f operator.yaml

# Destroy the terraform resources
cd ../
terraform destroy
```

## Additional Notes

- The OpenSearch operator manages the lifecycle of your OpenSearch clusters, including upgrades, scaling, and configuration changes.
- For production use, consider implementing backup solutions and disaster recovery plans.
- Monitor your OpenSearch cluster using AWS CloudWatch or a third-party monitoring solution.
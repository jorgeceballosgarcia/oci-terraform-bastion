# OCI TERRAFORM BASTION

Terraform script for provisioning a Bastion Dynamic Port Forwarding (SOCKS5)

## Requirements

- OCI CLI
- Terraform
- ssh-keygen

## Configuration

1. Follow the instructions to install and add the authentication to your tenant https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/cliinstall.htm

2. Clone this repository

```
git clone --depth 1 --branch main https://github.com/jorgeceballosgarcia/oci-terraform-bastion.git
```

3. Personalize your terraform.tfvars

```
region              = "eu-frankfurt-1"
compartment_ocid    = "ocid1.compartment.oc1........."
subnet_vcn_ocid     = "ocid1.subnet.oc1........"
```

5. Execute the script generate-keys.sh to generate private key to access the instance
```
sh generate-keys.sh
```

## Build
To build simply execute the next commands. 
```
terraform init
terraform plan
terraform apply
```

## Create Local Proxy 

The output of the terraform script will give the ssh full command so you only need to copy and paste

```
ssh -i bastion.key -N -D 127.0.0.1:22022 -p 22
```

This command create a local proxy to access to all private resources on this subnet.

### Use Local Proxy

Example: with your local proxy created, you can connect to instance like this

```
ssh -i ssh-key-instance.key opc@<PRIVATE_IP_INSTANCE> -o ProxyCommand="nc -x 127.0.0.1:22022 %h %p"
```

Also, you can redirect ports:

```
ssh -i ssh-key-instance.key opc@<PRIVATE_IP_INSTANCE> -L 8444:127.0.0.1:443 -o ProxyCommand="nc -x 127.0.0.1:22022 %h %p"
```

## Clean

To delete the instance execute.

```
terraform destroy
```



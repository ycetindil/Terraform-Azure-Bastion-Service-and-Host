---
title: Azure Bastion Host and Service using Terraform
description: Create Azure Bastion Host and Service using Terraform
---

# Step-00: Introduction
We are going to create two important Bastion Resources
1. Azure Bastion Host
2. Azure Bastion Service
We are going to use following Azure Resources for the same.
1. Terraform Input Variables
2. azurerm_public_ip
3. azurerm_network_interface
4. azurerm_linux_virtual_machine
5. Terraform Null Resource `null_resource`
6. Terraform File Provisioner
7. Terraform remote-exec Provisioner
8. azurerm_bastion_host
9. Terraform Output Values

# Pre-requisite Note: Create SSH Keys for Azure Linux VM
```t
# Create Folder
cd terraform-manifests/
mkdir ssh-keys

# Create SSH Key
cd ssh-keys
ssh-keygen \
    -m PEM \
    -t rsa \
    -b 4096 \
    -C "azureuser@myserver" \
    -f terraform-azure.pem
Important Note: Don't provide any passhprase, as the passphrase is not supported on latest provider versions

# List Files
ls -lrt ssh-keys/

# Files Generated after above command
Public Key: terraform-azure.pem.pub -> Rename as terraform-azure.pub
Private Key: terraform-azure.pem

# Permissions for Pem file
chmod 400 terraform-azure.pem
```

# Step 01: Providers
Create `providers.tf` file.

# Step 02: Generic input variables
Create `variables.tf` file.

# Step 03: Locals
Create `locals.tf` file.

# Step 04: Random resource
Create `random.tf` file.

# Step 05: Resource group
Create `resource-groups.tf` file.

# Step 06: VNet, subnets, and NSGs
- VNet variables `vnet-variables.tf`
- VNet `vnets.tf`
- Web subnet and NSG `web-subnet-and-nsg.tf`
- Bastion subnet and NSG `bastion-subnet-and-nsg.tf`

# Step 07: Web Linux VM
- NIC `web-linuxvm-network-interface.tf`
- VM `web-linuxvm.tf`
# Step 08: Bastion host
- Input variables `bastion-host-input-variables.tf`
- Public IP `bastion-host-public-ip.tf`
- NIC `bastion-host-network-interface.tf`
- VM `bastion-host-linuxvm.tf`

# Step 09: Move SSH key to bastion host
## Step 09-01: Make sure Null Provider is added to providers.tf

## Step 09-02: Add Null Resource and Terraform Provisioners
Create `move-ssh-key-to-bastion-host.tf` file and fill it in.

# Step 10: Bastion Service resources
Create `bastion-service.tf` file.

# Step 11: Bastion outputs
Create `bastion-outputs.tf` file to output the bastion host public IP address.

# Step 12: terraform.tfvars

# Step 13: Execute Terraform Commands
```t
# Terraform Initialize
terraform init

# Terraform Validate
terraform validate

# Terraform Plan
terraform plan

# Terraform Apply
terraform apply -auto-approve

# Important Note:
Azure Bastions Service takes 10 to 15 minutes to create.
```

# Step 14: Verify Resources - Bastion Host
Verify Resources - Virtual Network
1. Azure Resource Group
2. Azure Virtual Network
3. Azure Subnets (Web, Bastion)
4. Azure Network Security Groups (Web, Bastion)
5. View the topology
6. Verify Terraform Outputs in Terraform CLI

# Verify Resources - Web Linux VM
1. Verify Network Interface created for Web Linux VM
2. Verify Web Linux VM
3. Verify Network Security Groups associated with VM (web Subnet NSG)
4. View Topology at Web Linux VM -> Networking
5. Verify if only private IP associated with Web Linux VM

# Verify Resources - Bastion Host
1. Verify Bastion Host VM Public IP
2. Verify Bastion Host VM Network Interface
3. Verify Bastion VM
4. Verify Bastion VM -> Networking -> NSG Rules
5. Verify Bastion VM Topology

# Step 15: Test connectivity
```t
# Connect to Bastion Host VM
1. Connect to Bastion Host Linux VM
ssh -i ssh-keys/terraform-azure.pem azureuser@<Bastion-Host-LinuxVM-PublicIP>
sudo su -
cd /tmp
ls
2. terraform-azure.pem file should be present in /tmp directory

# Connect to Web Linux VM using Bastion Host VM
1. Connect to Web Linux VM
ssh -i ssh-keys/terraform-azure.pem azureuser@<Web-LinuxVM-PrivateIP>
sudo su -
cd /var/log
tail -100f cloud-init-output.log
cd /var/www/html
ls -lrt
cd /var/www/html/app1
ls -lrt
exit
exit
```

# Step 16: Verify Resources - Bastion Service
```t
# Verify Azure Bastion Service
1. Go to Azure Management Portal Console -> Bastions
2. Verify Bastion Service -> hr-dev-bastion-service
3. Verify Settings -> Sessions
4. Verify Settings -> Configuration

# Connect to Web Linux VM using Bastion Service
1. Go to Web Linux VM using Azure Portal Console
2. Portal Console -> Virtual machines -> hr-dev-web-linuxvm -> Settings -> Connect
3. Select "Bastion" tab -> Click on "Use Bastion"
	- Open in new window: checked
	- Username: azureuser
	- Authentication Type: SSH Private Key from Local File
	- Local File: Browse from ssh-keys/terraform-azure.pem
	- Click on Connect
4. In new tab, we should be logged in to VM "hr-dev-web-linuxvm"
5. Run additional commands
sudo su -
cd /var/www/html
ls
cd /var/www/html/app1
ls

# Verify Bastion Sessions
1. Go to Azure Management Porta Console -> Bastions
2. Verify Bastion Service -> hr-dev-bastion-service
3. Verify Settings -> Sessions
```

# Step 17: Delete Resources
```t
# Delete Resources
terraform destroy
[or]
terraform apply -destroy -auto-approve

# Clean-Up Files
rm -rf .terraform*
rm -rf terraform.tfstate*
```
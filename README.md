# PlutoFi Infrastructure

This directory contains Terraform infrastructure-as-code for deploying PlutoFi's DigitalOcean infrastructure.

## Overview

The infrastructure is deployed in the **NYC1** region and consists of:

- VPC for secure private networking
- Primary application droplet (4GB VM)
- Static IP address
- PostgreSQL database cluster with multiple databases

## Infrastructure Components

### VPC (Virtual Private Cloud)

- **Name**: `plutofi-vpc`
- **Region**: NYC1
- **IP Range**: `10.20.0.0/24`
- **VPC ID**: `f0bd0acd-df67-4388-b691-73711d5016e2`

### Primary Droplet

- **Name**: `plutofi-primary`
- **ID**: `528471170`
- **Size**: s-2vcpu-4gb (2 vCPUs, 4GB RAM)
- **Image**: Ubuntu 22.04 x64
- **Public IPv4**: `137.184.67.200`
- **Private IPv4**: `10.20.0.2`
- **Static IP**: `134.209.129.33`
- **Features**:
  - Monitoring enabled
  - Automated backups enabled
  - Connected to VPC
- **Tags**: `web`, `api`, `dev`, `staging`, `production`

### Static IP

- **Address**: `134.209.129.33`
- **Assigned to**: Primary droplet
- **Region**: NYC1

### PostgreSQL Database Cluster

- **Name**: `plutofi-db`
- **Cluster ID**: `024db466-32a3-4055-b0d2-e853a2886da6`
- **Engine**: PostgreSQL 16
- **Size**: db-s-1vcpu-1gb (1 vCPU, 1GB RAM)
- **Node Count**: 1
- **Region**: NYC1
- **Public Host**: `plutofi-db-do-user-16259757-0.k.db.ondigitalocean.com`
- **Private Host**: `private-plutofi-db-do-user-16259757-0.k.db.ondigitalocean.com`
- **Port**: `25060`
- **User**: `doadmin`
- **Tags**: `database`, `production`

#### Databases

1. **plutofi_main**
   - ID: `024db466-32a3-4055-b0d2-e853a2886da6/database/plutofi_main`
2. **plutofi_analytics**
   - ID: `024db466-32a3-4055-b0d2-e853a2886da6/database/plutofi_analytics`

#### Maintenance Window

- **Day**: Sunday
- **Time**: 02:00

## Terraform Modules

The infrastructure uses custom Terraform modules located in `tf/modules/do/`:

### 1. VPC Module (`modules/do/vpc`)

Manages DigitalOcean VPC networking.

**Variables:**

- `name` - VPC name
- `region` - Deployment region (default: nyc1)
- `description` - VPC description
- `ip_range` - CIDR notation (default: 10.20.0.0/24)

### 2. Droplet Module (`modules/do/droplet`)

Manages DigitalOcean droplets (VMs).

**Variables:**

- `name` - Droplet name
- `region` - Deployment region (default: nyc1)
- `size` - Droplet size (default: s-1vcpu-1gb)
- `image` - OS image (default: ubuntu-22-04-x64)
- `ssh_keys` - SSH key IDs
- `tags` - Tags to apply
- `monitoring` - Enable monitoring (default: true)
- `ipv6` - Enable IPv6 (default: false)
- `vpc_uuid` - VPC ID
- `user_data` - Cloud-init user data
- `backups` - Enable backups (default: false)

### 3. Static IP Module (`modules/do/static-ip`)

Manages DigitalOcean reserved IPs.

**Variables:**

- `name` - Reserved IP name
- `region` - Deployment region (default: nyc1)
- `droplet_id` - Droplet ID to assign IP to

### 4. Database Module (`modules/do/db`)

Manages DigitalOcean managed database clusters.

**Variables:**

- `name` - Database cluster name
- `engine` - Database engine (default: pg)
- `engine_version` - Engine version (default: 16)
- `size` - Cluster size (default: db-s-1vcpu-1gb)
- `region` - Deployment region (default: nyc1)
- `node_count` - Number of nodes (default: 1)
- `database_names` - List of databases to create
- `tags` - Tags to apply
- `private_network_uuid` - VPC ID
- `maintenance_window` - Maintenance schedule
- `backup_restore` - Backup restore configuration

**Outputs:**

- Connection details (host, port, user, password, URIs)
- Database names and IDs
- Cluster metadata

## Usage

### Prerequisites

- Terraform installed
- DigitalOcean API token
- SSH public key(s) for droplet access

### SSH Key Configuration

SSH keys are configured using a list of objects with `name` and `public_key` fields. Update `envs.auto.tfvars`:

```hcl
ssh_keys = [
  {
    name       = "admin-ssh-key"
    public_key = "ssh-rsa AAAAB3NzaC1yc2E..."
  },
  # Add more SSH keys as needed
  {
    name       = "backup-ssh-key"
    public_key = "ssh-rsa AAAAB3NzaC1yc2E..."
  }
]
```

Terraform will automatically:

1. Upload each SSH key to DigitalOcean
2. Assign all keys to the droplet during creation
3. Manage the key lifecycle (create, update, delete)

### Initialization

```bash
cd infra/tf
terraform init --upgrade
```

### Planning

```bash
terraform plan -var-file="envs.auto.tfvars"
```

### Deployment

```bash
terraform apply -var-file="envs.auto.tfvars"
```

### Viewing Outputs

```bash
# View all outputs
terraform output

# View specific output
terraform output droplet_ipv4_address

# View sensitive outputs
terraform output -json db_connection_details
```

### Destruction

```bash
terraform destroy -var-file="envs.auto.tfvars"
```

## Connection Information

### SSH to Droplet

```bash
ssh root@134.209.129.33
# or using private IP from within VPC
ssh root@10.20.0.2
```

### Database Connection

Use the private host for connections from within the VPC:

```bash
# Connection string format
postgresql://doadmin:<password>@private-plutofi-db-do-user-16259757-0.k.db.ondigitalocean.com:25060/<database_name>?sslmode=require
```

**Available Databases:**

- `plutofi_main` - Main application database
- `plutofi_analytics` - Analytics database

To retrieve the database password:

```bash
terraform output -raw db_password
```

## State Management

Terraform state is stored remotely in DigitalOcean Spaces:

- **Backend**: S3-compatible (DigitalOcean Spaces)
- **Bucket**: `plutofi-storage`
- **Key**: `infra/tfstate`
- **Endpoint**: `https://nyc3.digitaloceanspaces.com`
- **State Locking**: Enabled

## Security Notes

1. **Database Access**: Always use the private host when connecting from within the VPC for better security and performance
2. **SSH Keys**: Configure SSH keys in `envs.auto.tfvars` for droplet access
3. **Firewall**: Consider adding DigitalOcean firewall rules to restrict access
4. **Backups**: Automated backups are enabled for the primary droplet
5. **Monitoring**: DigitalOcean monitoring is enabled for resource tracking

## Cost Estimation

Monthly costs (approximate):

- VPC: Free
- Primary Droplet (s-2vcpu-4gb): ~$24/month (+ backups)
- Static IP: Free (while assigned)
- PostgreSQL (db-s-1vcpu-1gb): ~$15/month
- **Total**: ~$39-45/month

## Support

For infrastructure issues or questions, contact the DevOps team.

locals {
  # NCRATM Corporation
  tenant_id = "6539da08-b835-422b-bc32-76ca20bec464"
  mgt_kv_id = "/subscriptions/e1902623-8e9a-412c-ab5f-edb987a6b009/resourceGroups/rg-key-mgt-eus-prd/providers/Microsoft.KeyVault/vaults/kv-mgt-eus-prd"
  shared_storage_account = {
    "base_url"       = "https://stsharemgteusprd.blob.core.windows.net"
    "name"           = "stsharemgteusprd"
    "resource_group" = "rg-sto-mgt-eus-prd"
  }
  object_ids = {
  #  "grp_kvops"        = "6063ba77-dc83-4c2e-a0a9-820508270479" # "AZ KEY VAULT OPS"
    "grp_azadmin"      = "5fbafc90-c0bc-4155-9e5c-c57a4afb6c2e" # "IED AZURE ADMIN"
    "sp_automation"    = "a4dde843-219d-4e2b-99fe-e36463b0f69e" # "its-cps-plz-sp"
    "sp_backup"        = "4b72b047-e8f7-4533-9bd6-a02f1f56a870" # "Backup Management Service"
    "sp_lz_automation" = "76c95c7d-0a69-43db-9e4d-8df4f11610b9" # "its-cps-alz-sp"
  }
  zscaler_data = jsondecode(file("${path.module}/zscaler_ip.json"))

  # Load and parse fabric_ips.csv
  fabric_csv      = csvdecode(file("${path.module}/fabric_ips.csv"))
  fabric_prefixes = [for r in local.fabric_csv : r.addressPrefix if r.addressPrefix != null]
}

# NCR Atleos Azure Tenant ID
output "tenant_id" {
  value = local.tenant_id
}

# Azure Region Short Names
output "region_short" {
  value = {
    "eastus"        = "eus"
    "eastus2"       = "eus2"
    "centralus"     = "cus"
    "westus"        = "wus"
    "westus2"       = "wus2"
    "westeurope"    = "weu"
    "northeurope"   = "neu"
    "japaneast"     = "jpe"
    "southeastasia" = "sea"
    "centralindia"  = "cin"
    "southindia"    = "sin"
    "brazilsouth"   = "brs"
    "australiaeast" = "aue"
    "australiasoutheast" = "ause"
  }
}

# Environment Short Names
output "environment_short" {
  value = {
    "dev"  = "dev"  # Development
    "drs"  = "drs"  # Disaster Recovery Site
    "poc"  = "poc"  # Proof of Concept
    "pre"  = "pre"  # Pre-Production
    "prep" = "prep" # Pre-Production (non-preferred)
    "prd"  = "prd"  # Production
    "psp"  = "psp"  # Performance
    "qas"  = "qas"  # Quality Assurance
    "stg"  = "stg"  # Staging  
    "tst"  = "tst"  # Testing
    "uat"  = "uat"  # User Acceptance Testing
  }
}

# Regional Log Analytics Workspaces
output "log_analytics_workspace_info" {
  value = {
    "eus" = {
      "name" = "law-mgt-eus-prd"
      "rg"   = "rg-mgt-eus-prd"
      "id"   = "/subscriptions/e1902623-8e9a-412c-ab5f-edb987a6b009/resourceGroups/rg-mgt-eus-prd/providers/Microsoft.OperationalInsights/workspaces/law-mgt-eus-prd"
    },
    "weu" = {
      "name" = "law-mgt-eus-prd"
      "rg"   = "rg-mgt-eus-prd"
      "id"   = "/subscriptions/e1902623-8e9a-412c-ab5f-edb987a6b009/resourceGroups/rg-mgt-eus-prd/providers/Microsoft.OperationalInsights/workspaces/law-mgt-eus-prd"
    },
    "neu" = {
      "name" = "law-mgt-eus-prd"
      "rg"   = "rg-mgt-eus-prd"
      "id"   = "/subscriptions/e1902623-8e9a-412c-ab5f-edb987a6b009/resourceGroups/rg-mgt-eus-prd/providers/Microsoft.OperationalInsights/workspaces/law-mgt-eus-prd"
    },
    "wus" = {
      "name" = "law-mgt-wus-prd"
      "rg"   = "rg-mgt-wus-prd"
      "id"   = "/subscriptions/e1902623-8e9a-412c-ab5f-edb987a6b009/resourceGroups/rg-mgt-wus-prd/providers/Microsoft.OperationalInsights/workspaces/law-mgt-wus-prd"
    },
    "cin" = {
      "name" = "law-mgt-cin-prd"
      "rg"   = "rg-mgt-cin-prd"
      "id"   = "/subscriptions/e1902623-8e9a-412c-ab5f-edb987a6b009/resourceGroups/rg-mgt-cin-prd/providers/Microsoft.OperationalInsights/workspaces/law-mgt-cin-prd"
    },
    "sin" = {
      "name" = "law-mgt-sin-prd"
      "rg"   = "rg-mgt-sin-prd"
      "id"   = "/subscriptions/e1902623-8e9a-412c-ab5f-edb987a6b009/resourceGroups/rg-mgt-sin-prd/providers/Microsoft.OperationalInsights/workspaces/law-mgt-sin-prd"
    },
    "brs" = {
      "name" = "law-mgt-eus-prd"
      "rg"   = "rg-mgt-eus-prd"
      "id"   = "/subscriptions/e1902623-8e9a-412c-ab5f-edb987a6b009/resourceGroups/rg-mgt-eus-prd/providers/Microsoft.OperationalInsights/workspaces/law-mgt-eus-prd"
    },

  }
}

# No longer used - will comment/remove soon
output "av_group" {
  value = {
    "prd"  = "ATMCo-Servers-Standard"
    "drs"  = "ATMCo-Servers-Standard"
    "stg"  = "ATMCo-Servers-Standard"
    "dev"  = "ATMCo-Servers-Standard"
    "qas"  = "ATMCo-Servers-Standard"
    "pre"  = "ATMCo-Servers-Standard"
    "prep" = "ATMCo-Servers-Standard"
    "uat"  = "ATMCo-Servers-Standard"
    "tst"  = "ATMCo-Servers-Standard"
    "poc"  = "ATMCo-Servers-Standard"
  }
}

# No longer used - will comment/remove soon
output "av_installer_win" {
  value = {
    "prd"  = "Corp-Azure-Prod-Standard.exe"
    "drs"  = "Corp-Azure-Prod-Standard.exe"
    "stg"  = "Corp-Azure-PreProd-Standard.exe"
    "dev"  = "Corp-Azure-PreProd-Standard.exe"
    "qas"  = "Corp-Azure-PreProd-Standard.exe"
    "pre"  = "Corp-Azure-PreProd-Standard.exe"
    "prep" = "Corp-Azure-PreProd-Standard.exe"
    "tst"  = "Corp-Azure-PreProd-Standard.exe"
    "uat"  = "Corp-Azure-PreProd-Standard.exe"
    "poc"  = "Corp-Azure-PreProd-Standard.exe"
  }
}

# VM Local Admin account username
output "admin_user_secret" {
  value = "MachineAdminUsername"
}

# VM Local Admin account password
output "admin_pw_secret" {
  value = "MachineAdminPassword"
}

# Domain Admin account username
output "domain_user_secret" {
  value = "DomainAdminUsername"
}

# Domain Admin account username
output "domain_pw_secret" {
  value = "DomainAdminPassword"
}

# Management Keyvault ID
output "mgt_kv_id" {
  value = local.mgt_kv_id
}

# Management Shared Stoage Account
output "shared_storage_account" {
  value = local.shared_storage_account
}

# Shared Azure Compute Images
output "sig_catalog" {
  value = {
    "Windows2022" = {
      "osPublisher" = "MicrosoftWindowsServer"
      "osOffer"     = "WindowsServer"
      "osSKU"       = "2022-Datacenter"
      "osVersion"   = "latest"
    },
    "Windows2019" = {
      "osPublisher" = "MicrosoftWindowsServer"
      "osOffer"     = "WindowsServer"
      "osSKU"       = "2019-Datacenter"
      "osVersion"   = "latest"
    },
    "Windows2016" = {
      "osPublisher" = "MicrosoftWindowsServer"
      "osOffer"     = "WindowsServer"
      "osSKU"       = "2016-Datacenter"
      "osVersion"   = "latest"
    },
    "Windows2012" = {
      "osPublisher" = "MicrosoftWindowsServer"
      "osOffer"     = "WindowsServer"
      "osSKU"       = "2012-R2-Datacenter"
      "osVersion"   = "latest"
    },
    "Windows2008" = {
      "osPublisher" = "MicrosoftWindowsServer"
      "osOffer"     = "WindowsServer"
      "osSKU"       = "2008-R2-SP1"
      "osVersion"   = "latest"
    },
    "OracleLinux8" = {
      "osPublisher" = "Oracle"
      "osOffer"     = "Oracle-Linux"
      "osSKU"       = "81"
      "osVersion"   = "latest"
    },
    "OracleLinux7" = {
      "osPublisher" = "Oracle"
      "osOffer"     = "Oracle-Linux"
      "osSKU"       = "ol79"
      "osVersion"   = "latest"
    },
    "CentOS8" = {
      "osPublisher" : "OpenLogic",
      "osOffer" : "CentOS",
      "osSku" : "8_3",
      "osVersion" : "latest"
    },
    "CentOS7" = {
      "osPublisher" : "OpenLogic",
      "osOffer" : "CentOS",
      "osSKU" : "7_9",
      "osVersion" : "latest"
    }
  }
}

# Shared Azure Compute Images - Duplicate
output "vm_catalog" {
  value = {
    "Windows2022" = {
      "osPublisher" = "MicrosoftWindowsServer"
      "osOffer"     = "WindowsServer"
      "osSKU"       = "2022-Datacenter"
      "osVersion"   = "latest"
    },
    "Windows2019" = {
      "osPublisher" = "MicrosoftWindowsServer"
      "osOffer"     = "WindowsServer"
      "osSKU"       = "2019-Datacenter"
      "osVersion"   = "latest"
    },
    "Windows2016" = {
      "osPublisher" = "MicrosoftWindowsServer"
      "osOffer"     = "WindowsServer"
      "osSKU"       = "2016-Datacenter"
      "osVersion"   = "latest"
    },
    "Windows2012" = {
      "osPublisher" = "MicrosoftWindowsServer"
      "osOffer"     = "WindowsServer"
      "osSKU"       = "2012-R2-Datacenter"
      "osVersion"   = "latest"
    },
    "Windows2008" = {
      "osPublisher" = "MicrosoftWindowsServer"
      "osOffer"     = "WindowsServer"
      "osSKU"       = "2008-R2-SP1"
      "osVersion"   = "latest"
    },
    "OracleLinux8" = {
      "osPublisher" = "Oracle"
      "osOffer"     = "Oracle-Linux"
      "osSKU"       = "81"
      "osVersion"   = "latest"
    },
    "OracleLinux7" = {
      "osPublisher" = "Oracle"
      "osOffer"     = "Oracle-Linux"
      "osSKU"       = "ol79"
      "osVersion"   = "latest"
    },
    "CentOS8" = {
      "osPublisher" : "OpenLogic",
      "osOffer" : "CentOS",
      "osSku" : "8_3",
      "osVersion" : "latest"
    },
    "CentOS7" = {
      "osPublisher" : "OpenLogic",
      "osOffer" : "CentOS",
      "osSKU" : "7_9",
      "osVersion" : "latest"
    }
  }
}

# NCR Atleos Domain Information for VM domain join
output "domain_info" {
  value = {
    "domain_name" = "prod.local"
    "ou_path"     = "OU=ITS Supported Servers,DC=prod,DC=local"
    #   "linux_admin_groups"   = ["'IED\\ AZURE\\ ADMIN'", "'AZ\\ INFRA\\ AUTO'", "'AZ\\ SECURITY\\ SCAN'", "'LinuxAzureAdminGroup'"]
    "linux_admin_groups" = ["'LinuxAzureAdminGroup'"]
    #   "windows_admin_groups" = ["'IED AZURE ADMIN'", "'AZ INFRA AUTO'", "'AZ SECURITY SCAN'", "'Server Core Team GSM'"]
    "windows_admin_groups" = ["'Server Core Team GSM'"]
  }
}

# NTP Servers
output "ntp_servers" {
  value = "153.84.16.36"
}

# DNS Servers - Corp
output "dns_servers" {
  value = [
    "153.84.16.36", # Azure EUS
    "153.84.16.37", # Azure EUS
    "153.84.48.36", # Azure WUS
    "153.84.48.37", # Azure WUS
  ]
}


# DNS Servers - GTM
output "dns_servers_gtm" {
  value = [
    "100.127.16.36", #vm-dcs0-idx-prd
    "100.127.16.37", #vm-dcs1-idx-prd
  ]
}

# This is used to create a new backup policy/schedule of this name for each subscription.
# This is NOT a global policy.
output "default_vm_backup_policy" {
  value = "NCRATMCO-DefaultPolicy"
}

# Standard Zscaler IP Rules for all subscriptions
output "base_ip_rules" {
  value = concat(local.zscaler_data.prefixes, local.fabric_prefixes)
}


# Subnets allowed default access the Key Vaults
# Add gha-injected-runners, but not the others because those are already in the tf template repo
output "base_kv_subnet_ids" {
  value = [
    #"/subscriptions/e1902623-8e9a-412c-ab5f-edb987a6b009/resourceGroups/rg-net-mgt-eus-prd/providers/Microsoft.Network/virtualNetworks/vnet-mgt-eus-prd/subnets/snet-ado-mgt-eus-prd",
    #"/subscriptions/e1902623-8e9a-412c-ab5f-edb987a6b009/resourceGroups/rg-ado-mgt-eus-prd/providers/Microsoft.Network/virtualNetworks/mgt-linux-vmssagentspoolVNET/subnets/mgt-linux-vmssagentspoolSubnet", # 10.0.0.0/24
    "/subscriptions/e1902623-8e9a-412c-ab5f-edb987a6b009/resourceGroups/rg-ado-mgt-eus-prd/providers/Microsoft.Network/virtualNetworks/mgt-linux-vmssagentspoolVNET/subnets/gha-injected-runners", # 10.0.1.0/24
  ]
}

# Add subnet IDs to access storage account 
output "base_storage_subnet_ids" {
  value = [
    "/subscriptions/e1902623-8e9a-412c-ab5f-edb987a6b009/resourceGroups/rg-ado-mgt-eus-prd/providers/Microsoft.Network/virtualNetworks/mgt-linux-vmssagentspoolVNET/subnets/gha-injected-runners",
    "/subscriptions/e1902623-8e9a-412c-ab5f-edb987a6b009/resourceGroups/rg-ado-mgt-eus-prd/providers/Microsoft.Network/virtualNetworks/mgt-linux-vmssagentspoolVNET/subnets/mgt-linux-vmssagentspoolSubnet",
    "/subscriptions/e1902623-8e9a-412c-ab5f-edb987a6b009/resourceGroups/rg-net-mgt-eus-prd/providers/Microsoft.Network/virtualNetworks/vnet-gha-mgt-eus-prd/subnets/snet-gha-mgt-eus-prd"
  ]
}

# Default KV Access Policy
output "base_kv_access_policy" {
  value = [
/*
    {
      # AZ Key Vault OPS Permissions
      application_id = ""
      certificate_permissions = [
        "Get",
        "List",
        "Update",
        "Create",
        "Import",
        "Delete",
        "Recover",
        "Backup",
        "Restore",
        "ManageContacts",
        "ManageIssuers",
        "GetIssuers",
        "ListIssuers",
        "SetIssuers",
        "DeleteIssuers",
      ]
      key_permissions = [
        "Get",
        "List",
        "Update",
        "Create",
        "Import",
        "Delete",
        "Recover",
        "Backup",
        "Restore",
        "GetRotationPolicy",
        "SetRotationPolicy",
      ]
      object_id = local.object_ids.grp_kvops
      secret_permissions = [
        "Get",
        "List",
        "Set",
        "Delete",
        "Recover",
        "Backup",
        "Restore",
      ]
      storage_permissions = []
    },
*/
    {
      # IED AZURE ADMIN Permissions
      application_id          = ""
      certificate_permissions = []
      key_permissions = [
        "Create",
        "List",
        "Get",
        "GetRotationPolicy",
        "Update",            # Temporary
        "SetRotationPolicy", # Temporary
      ]
      object_id = local.object_ids.grp_azadmin
      secret_permissions = [
        "Get",
        "List",
      ]
      storage_permissions = []
    },
    {
      # ITSAutomation Permissions
      application_id = ""
      certificate_permissions = [
        "Get",
        "List",
      ]
      key_permissions = [
        "Get",
        "List",
        "Update",
        "Create",
        "GetRotationPolicy",
        "SetRotationPolicy",
        "WrapKey",
        "UnwrapKey",
        "Recover",
        "Delete"
      ]
      object_id = local.object_ids.sp_automation
      secret_permissions = [
        "Get",
        "List",
        "Set",
        "Delete",
        "Recover",
      ]
      storage_permissions = []
    },
    {
      # ITSAutomation Landing Zone Permissions
      application_id = ""
      certificate_permissions = [
        "Get",
        "List",
      ]
      key_permissions = [
        "Get",
        "List",
        "Update",
        "Create",
        "GetRotationPolicy",
        "SetRotationPolicy",
        "WrapKey",
        "UnwrapKey",
        "Recover",
        "Delete"
      ]
      object_id = local.object_ids.sp_lz_automation
      secret_permissions = [
        "Get",
        "List",
        "Set",
        "Delete",
        "Recover",
      ]
      storage_permissions = []
    },
    {
      # BackupManagementService Permissions
      application_id          = ""
      certificate_permissions = []
      key_permissions = [
        "Get",
        "List",
        "Backup",
      ]
      object_id = local.object_ids.sp_backup
      secret_permissions = [
        "Get",
        "List",
        "Backup",
      ]
      storage_permissions = []
    },
  ]
}

# Base NSGs - GTM
output "gtm_base_nsgs" {
  value = [
    {
      access                     = "Allow"
      description                = "Allow Udp AD Domain Controller access outbound."
      destination_address_prefix = ""
      destination_address_prefixes = [
        "100.127.16.32/29", # snet-dcs-idx-eus-prd - Domain Controller
      ]
      destination_application_security_group_ids = []
      destination_port_range                     = ""
      destination_port_ranges = [
        "53",  # DNS
        "88",  # Kerberos
        "123", # NTP
        "135", # MS RPC 
        "139",
        "389", # LDAP
        "445", # MS DS
        "464",
        "636",
        "3268",
        "3269",
        "49152-65535", # RPC Dynamic Ports
      ]
      direction                             = "Outbound"
      name                                  = "Allow_Udp_DCAD_Access_OB"
      priority                              = 201
      protocol                              = "Udp"
      source_address_prefix                 = "*"
      source_address_prefixes               = []
      source_application_security_group_ids = []
      source_port_range                     = "*"
      source_port_ranges                    = []
    },
    {
      access                     = "Allow"
      description                = "Allow Tcp AD Domain Controller access outbound."
      destination_address_prefix = ""
      destination_address_prefixes = [
        "100.127.16.32/29", # snet-dcs-idx-eus-prd - Domain Controller
      ]
      destination_application_security_group_ids = []
      destination_port_range                     = ""
      destination_port_ranges = [
        "53",  # DNS
        "88",  # Kerberos
        "123", # NTP
        "135", # MS RPC 
        "139",
        "389", # LDAP
        "445", # MS DS
        "464",
        "636",
        "3268",
        "3269",
        "49152-65535", # RPC Dynamic Ports
      ]
      direction                             = "Outbound"
      name                                  = "Allow_Tcp_DCAD_Access_OB"
      priority                              = 202
      protocol                              = "Tcp"
      source_address_prefix                 = "*"
      source_address_prefixes               = []
      source_application_security_group_ids = []
      source_port_range                     = "*"
      source_port_ranges                    = []
    },
    {
      access                                     = "Allow"
      description                                = ""
      destination_address_prefix                 = "*"
      destination_address_prefixes               = []
      destination_application_security_group_ids = []
      destination_port_range                     = "*"
      destination_port_ranges                    = []
      direction                                  = "Inbound"
      name                                       = "Allow_ZPA_GTM_IB"
      priority                                   = 208
      protocol                                   = "*"
      source_address_prefix                      = ""
      source_address_prefixes = [
        "100.127.16.4/32",
        "100.127.16.5/32",
      ]
      source_application_security_group_ids = []
      source_port_range                     = "*"
      source_port_ranges                    = []
    },
    {
      access                     = "Allow"
      description                = "Allow BigFix Client to Relay GTM Outbound."
      destination_address_prefix = ""
      destination_address_prefixes = [
        "100.127.16.100", # vm-bfx0-sxc-prd
      ]
      destination_application_security_group_ids = []
      destination_port_range                     = ""
      destination_port_ranges = [
        "52311",
      ]
      direction                             = "Outbound"
      name                                  = "Allow_BigFix_Client_To_Relay_Gtm_OB"
      priority                              = 217
      protocol                              = "Tcp"
      source_address_prefix                 = "*"
      source_address_prefixes               = []
      source_application_security_group_ids = []
      source_port_range                     = "*"
      source_port_ranges                    = []
    },
  ]
}

# Base NSGs - Corp
output "corp_base_nsgs" {
  value = [
    {
      access                     = "Allow"
      description                = "Allow Udp AD Domain Controller access outbound."
      destination_address_prefix = ""
      destination_address_prefixes = [
        "153.84.16.32/29", # snet-dcs-idm-eus-prd - Domain Controller
      ]
      destination_application_security_group_ids = []
      destination_port_range                     = ""
      destination_port_ranges = [
        "53",  # DNS
        "88",  # Kerberos
        "123", # NTP
        "135", # MS RPC 
        "139",
        "389", # LDAP
        "445", # MS DS
        "464",
        "636",
        "3268",
        "3269",
        "49152-65535", # RPC Dynamic Ports
      ]
      direction                             = "Outbound"
      name                                  = "Allow_Udp_DCAD_Access_OB"
      priority                              = 201
      protocol                              = "Udp"
      source_address_prefix                 = "*"
      source_address_prefixes               = []
      source_application_security_group_ids = []
      source_port_range                     = "*"
      source_port_ranges                    = []
    },
    {
      access                     = "Allow"
      description                = "Allow Tcp AD Domain Controller access outbound."
      destination_address_prefix = ""
      destination_address_prefixes = [
        "153.84.16.32/29", # snet-dcs-idm-eus-prd - Domain Controller
      ]
      destination_application_security_group_ids = []
      destination_port_range                     = ""
      destination_port_ranges = [
        "53",  # DNS
        "88",  # Kerberos
        "123", # NTP
        "135", # MS RPC 
        "139",
        "389", # LDAP
        "445", # MS DS
        "464",
        "636",
        "3268",
        "3269",
        "49152-65535", # RPC Dynamic Ports
      ]
      direction                             = "Outbound"
      name                                  = "Allow_Tcp_DCAD_Access_OB"
      priority                              = 202
      protocol                              = "Tcp"
      source_address_prefix                 = "*"
      source_address_prefixes               = []
      source_application_security_group_ids = []
      source_port_range                     = "*"
      source_port_ranges                    = []
    },
    {
      access                     = "Allow"
      description                = "Allow BigFix Client to Relay Corp Outbound."
      destination_address_prefix = ""
      destination_address_prefixes = [
        "153.84.16.105", # vm-bfx0-sec-prd.prod.local
      ]
      destination_application_security_group_ids = []
      destination_port_range                     = ""
      destination_port_ranges = [
        "52311",
      ]
      direction                             = "Outbound"
      name                                  = "Allow_BigFix_Client_To_Relay_Corp_OB"
      priority                              = 217
      protocol                              = "Tcp"
      source_address_prefix                 = "*"
      source_address_prefixes               = []
      source_application_security_group_ids = []
      source_port_range                     = "*"
      source_port_ranges                    = []
    },
  ]
}

# Base NSGs
output "base_nsgs" {
  value = [
    {
      access                                     = "Deny"
      description                                = "Deny Outbound to specific IP Malicious IP addresses."
      destination_address_prefix                 = "*"
      destination_address_prefixes               = []
      destination_application_security_group_ids = []
      destination_port_range                     = "*"
      destination_port_ranges                    = []
      direction                                  = "Inbound"
      name                                       = "Malicious_IP_addresses_INC1681983_IB"
      priority                                   = 100
      protocol                                   = "Tcp"
      source_address_prefix                      = ""
      source_address_prefixes = [
        "104.200.72.113",
        "192.169.7.120",
        "23.81.246.153",
        "179.60.149.53",
        "81.19.136.251",
        "116.203.186.178",
        "80.66.88.213",
        "177.39.156.177",
        "188.166.25.63",
        "192.64.119.254",
        "91.240.242.26",
        "91.241.19.50",
        "179.60.149.38",
        "170.64.134.89",
        "159.203.44.105",
        "139.59.37.187",
        "146.190.166.168",
        "64.227.146.243",
        "165.227.147.215",
        "167.71.133.68",
        "89.44.9.243",
        "37.120.238.58",
        "142.234.157.246",
        "152.89.247.207",
        "45.134.20.66",
        "198.144.121.93",
        "185.220.102.253",
        "89.163.252.230",
        "45.153.160.140",
        "139.60.161.161",
        "23.106.223.97",
        "146.0.77.15",
        "94.232.41.155",
        "168.100.11.49",
      ]
      source_application_security_group_ids = []
      source_port_range                     = "*"
      source_port_ranges                    = []
    },
    {
      access                                     = "Allow"
      description                                = "Allow Azure Management Inbound."
      destination_address_prefix                 = "*"
      destination_address_prefixes               = []
      destination_application_security_group_ids = []
      destination_port_range                     = ""
      destination_port_ranges = [
        "22",
        "80",
        "443",
        "3389",
        "8443",
      ]
      direction             = "Inbound"
      name                  = "Allow_AZ_MGT_IB"
      priority              = 200
      protocol              = "Tcp"
      source_address_prefix = ""
      source_address_prefixes = [
        #  "153.84.28.128/25", # vnet-gha-mgt-eus-prd NOT REQUIRE AS IT IS SHIFTED TO RULE 211 INBOUND
        "10.100.2.0/24",   # vnet-mgt-eus-prd
        "153.84.17.0/26",  # vnet-mgt-eus-prd
        "153.84.16.64/27", # vnet-mgt-eus-prd
        "10.80.0.0/24",    # vnet-bas-eus-dev - shared bastion
        "10.81.0.0/24",    # vnet-bas-eus-prd - shared bastion
      ]
      source_application_security_group_ids = []
      source_port_range                     = "*"
      source_port_ranges                    = []
    },
    {
      access                                     = "Allow"
      description                                = "Allow Branch VPN inbound."
      destination_address_prefix                 = "*"
      destination_address_prefixes               = []
      destination_application_security_group_ids = []
      destination_port_range                     = ""
      destination_port_ranges = [
        "22",
        "443",
        "3389",
        "4505",
        "4506",
        "8200",
      ]
      direction             = "Inbound"
      name                  = "Allow_Branch_VPN_IB"
      priority              = 201
      protocol              = "Tcp"
      source_address_prefix = ""
      source_address_prefixes = [
        "192.127.224.210", # Dayton VPN Hide Address
      ]
      source_application_security_group_ids = []
      source_port_range                     = "*"
      source_port_ranges                    = []
    },
    {
      access                                     = "Allow"
      description                                = "Allow Rapid7 scan inbound."
      destination_address_prefix                 = "*"
      destination_address_prefixes               = []
      destination_application_security_group_ids = []
      destination_port_range                     = "*"
      destination_port_ranges                    = []
      direction                                  = "Inbound"
      name                                       = "Allow_Rapid7_Scan_IB"
      priority                                   = 202
      protocol                                   = "*"
      source_address_prefix                      = ""
      source_address_prefixes = [
        "192.127.58.5", # Needs to be updated to its-plz-sec-prd VNET
      ]
      source_application_security_group_ids = []
      source_port_range                     = "*"
      source_port_ranges                    = []
    },
    {
      access                                     = "Allow"
      description                                = "Allow Azure load balancer inbound."
      destination_address_prefix                 = "*"
      destination_address_prefixes               = []
      destination_application_security_group_ids = []
      destination_port_range                     = "*"
      destination_port_ranges                    = []
      direction                                  = "Inbound"
      name                                       = "Allow_AzureLoadBalancer_IB"
      priority                                   = 203
      protocol                                   = "*"
      source_address_prefix                      = "AzureLoadBalancer"
      source_address_prefixes                    = []
      source_application_security_group_ids      = []
      source_port_range                          = "*"
      source_port_ranges                         = []
    },
    {
      access                                     = "Allow"
      description                                = "Allow antivirus updates inbound"
      destination_address_prefix                 = "*"
      destination_address_prefixes               = []
      destination_application_security_group_ids = []
      destination_port_range                     = "8081"
      destination_port_ranges                    = []
      direction                                  = "Inbound"
      name                                       = "Allow_AV_Updates_IB"
      priority                                   = 204
      protocol                                   = "Tcp"
      source_address_prefix                      = ""
      source_address_prefixes = [
        "149.25.153.72",   # NCR
        "149.25.153.171",  # NCR
        "192.127.4.38",    # NCR
        "192.127.252.171", # NCR
        "192.127.252.172", # NCR
      ]
      source_application_security_group_ids = []
      source_port_range                     = "*"
      source_port_ranges                    = []
    },
    {
      access                                     = "Allow"
      description                                = "Allow VDI inbound."
      destination_address_prefix                 = "*"
      destination_address_prefixes               = []
      destination_application_security_group_ids = []
      destination_port_range                     = ""
      destination_port_ranges = [
        "22",
        "3389",
      ]
      direction             = "Inbound"
      name                  = "Allow_VDI_IB"
      priority              = 205
      protocol              = "Tcp"
      source_address_prefix = ""
      source_address_prefixes = [
        "153.84.2.0/24",  # snet-app-vdi-eus-dev
        "153.84.18.0/24", # snet-app-vdi-eus-prd

      ]
      source_application_security_group_ids = []
      source_port_range                     = "*"
      source_port_ranges                    = []
    },
    {
      access                                     = "Allow"
      description                                = "Allow TSA inbound."
      destination_address_prefix                 = "153.84.0.0/16"
      destination_address_prefixes               = []
      destination_application_security_group_ids = []
      destination_port_range                     = ""
      destination_port_ranges = [
        "17008",
      ]
      direction             = "Inbound"
      name                  = "Allow_TSA_IB"
      priority              = 206
      protocol              = "Tcp"
      source_address_prefix = ""
      source_address_prefixes = [
        "153.86.8.60",
        "153.86.12.62",
        "153.86.8.53",
      ]
      source_application_security_group_ids = []
      source_port_range                     = "*"
      source_port_ranges                    = []
    },
    {
      access                                     = "Allow"
      description                                = "Allow ZPA inbound."
      destination_address_prefix                 = "*"
      destination_address_prefixes               = []
      destination_application_security_group_ids = []
      destination_port_range                     = "*"
      destination_port_ranges                    = []
      direction                                  = "Inbound"
      name                                       = "Allow_ZPA_IB"
      priority                                   = 207
      protocol                                   = "*"
      source_address_prefix                      = ""
      source_address_prefixes = [
        "153.84.16.4", #Production
        "153.84.16.5", #Production
        "153.84.16.6", #Production
        "153.84.16.7", #Production
        "153.84.0.4",  #Non-Production
        "153.84.0.5",  #Non-Production
        "153.84.0.6",  #Non-Production
        "153.84.48.5", #West
        "153.81.65.7",
        "153.81.65.8",
        "153.81.1.4",
        "153.81.1.5",
      ]
      source_application_security_group_ids = []
      source_port_range                     = "*"
      source_port_ranges                    = []
    },
    # Rule 208 is reserved for gtm base Allow_ZPA_GTM_IB
    {
      access                                     = "Allow"
      description                                = "Allow BigFix Client to Relay Inbound."
      destination_address_prefix                 = "*"
      destination_address_prefixes               = []
      destination_application_security_group_ids = []
      destination_port_range                     = ""
      destination_port_ranges = [
        "52311",
      ]
      direction             = "Inbound"
      name                  = "Allow_BigFix_Relay_To_Client_ICMP_IB"
      priority              = 209
      protocol              = "Icmp"
      source_address_prefix = ""
      source_address_prefixes = [
        "153.84.16.105", # vm-bfx0-sec-prd.prod.local
      ]
      source_application_security_group_ids = []
      source_port_range                     = "*"
      source_port_ranges                    = []
    },
    {
      access                                     = "Allow"
      description                                = "Allow BigFix Client to Relay Inbound."
      destination_address_prefix                 = "*"
      destination_address_prefixes               = []
      destination_application_security_group_ids = []
      destination_port_range                     = ""
      destination_port_ranges = [
        "52311",
      ]
      direction             = "Inbound"
      name                  = "Allow_BigFix_Relay_To_Client_IB"
      priority              = 210
      protocol              = "Udp"
      source_address_prefix = ""
      source_address_prefixes = [
        "153.84.16.105", # vm-bfx0-sec-prd.prod.local
      ]
      source_application_security_group_ids = []
      source_port_range                     = "*"
      source_port_ranges                    = []
    },
    {
      access                                     = "Allow"
      description                                = "Allow Ansible Inbound."
      destination_address_prefix                 = "*"
      destination_address_prefixes               = []
      destination_application_security_group_ids = []
      destination_port_range                     = ""
      destination_port_ranges = [
        "22", "5985", "5986",
      ]
      direction                             = "Inbound"
      name                                  = "Allow_ANSIBLE_IB"
      priority                              = 230
      protocol                              = "Tcp"
      source_address_prefix                 = "153.84.16.89"
      source_address_prefixes               = []
      source_application_security_group_ids = []
      source_port_range                     = "*"
      source_port_ranges                    = []
    },

    # REQ3191426
    {
      access                                     = "Allow"
      description                                = "Allow snet-gha-mgt-eus-prd Inbound"
      destination_address_prefix                 = "*"
      destination_address_prefixes               = []
      destination_application_security_group_ids = []
      destination_port_range                     = ""
      destination_port_ranges = [
        "21",
        "22",
        "80",
        "9090",
        "3389",
        "443",
        "445",  # RITM3250029
        "5050", # TASK3284396
        "5051", # TASK3284396
        "1433"  # TASK3284396
      ]
      direction             = "Inbound"
      name                  = "Allow_Gha_Mgt_Eus_Prd_To_Client_IB"
      priority              = 211
      protocol              = "Tcp"
      source_address_prefix = ""
      source_address_prefixes = [
        "153.84.28.128/25" #snet-gha-mgt-eus-prd
      ]
      source_application_security_group_ids = []
      source_port_range                     = "*"
      source_port_ranges                    = []
    },

    /* Redundant, as Azure already has this rule and breaks the default AllowAzureLoadBalancerInBound rule.
    {
      access                                     = "Deny"
      description                                = "Drop all else inbound."
      destination_address_prefix                 = "*"
      destination_address_prefixes               = []
      destination_application_security_group_ids = []
      destination_port_range                     = "*"
      destination_port_ranges                    = []
      direction                                  = "Inbound"
      name                                       = "Drop_All_Else_IB"
      priority                                   = 4096
      protocol                                   = "*"
      source_address_prefix                      = "*"
      source_address_prefixes                    = []
      source_application_security_group_ids      = []
      source_port_range                          = "*"
      source_port_ranges                         = []
    },
    */

    # Start Outbound
    {
      access                     = "Deny"
      description                = "Deny Outbound to specific IP Malicious IP addresses INC1681983."
      destination_address_prefix = ""
      destination_address_prefixes = [
        "179.60.149.53",
        "81.19.136.251",
        "116.203.186.178",
        "80.66.88.213",
        "177.39.156.177",
        "188.166.25.63",
        "192.64.119.254",
        "91.240.242.26",
        "91.241.19.50",
        "179.60.149.38",
        "170.64.134.89",
        "159.203.44.105",
        "139.59.37.187",
        "146.190.166.168",
        "64.227.146.243",
        "165.227.147.215",
        "167.71.133.68",
        "89.44.9.243",
        "37.120.238.58",
        "142.234.157.246",
        "152.89.247.207",
        "45.134.20.66",
        "198.144.121.93",
        "185.220.102.253",
        "89.163.252.230",
        "45.153.160.140",
        "139.60.161.161",
        "23.106.223.97",
        "146.0.77.15",
        "94.232.41.155",
        "168.100.11.49",
      ]
      destination_application_security_group_ids = []
      destination_port_range                     = "*"
      destination_port_ranges                    = []
      direction                                  = "Outbound"
      name                                       = "Malicious_IP_addresses_INC1681983_OB"
      priority                                   = 100
      protocol                                   = "*"
      source_address_prefix                      = "*"
      source_address_prefixes                    = []
      source_application_security_group_ids      = []
      source_port_range                          = "*"
      source_port_ranges                         = []
    },
    {
      access                     = "Allow"
      description                = "Allow access to Azure Management outbound."
      destination_address_prefix = ""
      destination_address_prefixes = [
        "10.100.2.0/24",   # vnet-mgt-eus-prd
        "153.84.17.0/26",  # vnet-mgt-eus-prd
        "153.84.16.64/27", # vnet-mgt-eus-prd
      ]
      destination_application_security_group_ids = []
      destination_port_range                     = ""
      destination_port_ranges = [
        "25",
        "443",
        "4505",
        "4506",
        "8200",
        "8530",
      ]
      direction                             = "Outbound"
      name                                  = "Allow_AZ_MGT_OB"
      priority                              = 200
      protocol                              = "Tcp"
      source_address_prefix                 = "*"
      source_address_prefixes               = []
      source_application_security_group_ids = []
      source_port_range                     = "*"
      source_port_ranges                    = []
    },

    # Rule 201 and 202 is reserverd in corp_base_nsgs and gtm_base_nsgs

    {
      access                                     = "Allow"
      description                                = "Allow access to Azure backups outbound."
      destination_address_prefix                 = "AzureBackup"
      destination_address_prefixes               = []
      destination_application_security_group_ids = []
      destination_port_range                     = "443"
      destination_port_ranges                    = []
      direction                                  = "Outbound"
      name                                       = "Allow_Azure_Backups_OB"
      priority                                   = 203
      protocol                                   = "Tcp"
      source_address_prefix                      = "*"
      source_address_prefixes                    = []
      source_application_security_group_ids      = []
      source_port_range                          = "*"
      source_port_ranges                         = []
    },
    {
      access                                     = "Allow"
      description                                = "Allow access to Azure monitor outbound."
      destination_address_prefix                 = "AzureMonitor"
      destination_address_prefixes               = []
      destination_application_security_group_ids = []
      destination_port_range                     = "443"
      destination_port_ranges                    = []
      direction                                  = "Outbound"
      name                                       = "Allow_Azure_Monitor_OB"
      priority                                   = 204
      protocol                                   = "Tcp"
      source_address_prefix                      = "*"
      source_address_prefixes                    = []
      source_application_security_group_ids      = []
      source_port_range                          = "*"
      source_port_ranges                         = []
    },
    {
      access                                     = "Allow"
      description                                = "Allow access to Azure storage outbound."
      destination_address_prefix                 = "Storage"
      destination_address_prefixes               = []
      destination_application_security_group_ids = []
      destination_port_range                     = "443"
      destination_port_ranges                    = []
      direction                                  = "Outbound"
      name                                       = "Allow_Azure_Storage_OB"
      priority                                   = 205
      protocol                                   = "Tcp"
      source_address_prefix                      = "*"
      source_address_prefixes                    = []
      source_application_security_group_ids      = []
      source_port_range                          = "*"
      source_port_ranges                         = []
    },
    {
      access                                     = "Allow"
      description                                = "Allow access to Azure key vault outbound."
      destination_address_prefix                 = "AzureKeyVault"
      destination_address_prefixes               = []
      destination_application_security_group_ids = []
      destination_port_range                     = "443"
      destination_port_ranges                    = []
      direction                                  = "Outbound"
      name                                       = "Allow_Azure_KeyVault_OB"
      priority                                   = 206
      protocol                                   = "Tcp"
      source_address_prefix                      = "*"
      source_address_prefixes                    = []
      source_application_security_group_ids      = []
      source_port_range                          = "*"
      source_port_ranges                         = []
    },
    {
      access                                     = "Allow"
      description                                = "Allow access to Azure Guest and Hybrid Management outbound."
      destination_address_prefix                 = "GuestAndHybridManagement"
      destination_address_prefixes               = []
      destination_application_security_group_ids = []
      destination_port_range                     = "443"
      destination_port_ranges                    = []
      direction                                  = "Outbound"
      name                                       = "Allow_GuestAndHybridManagement_OB"
      priority                                   = 207
      protocol                                   = "Tcp"
      source_address_prefix                      = "*"
      source_address_prefixes                    = []
      source_application_security_group_ids      = []
      source_port_range                          = "*"
      source_port_ranges                         = []
    },
    {
      access                     = "Allow"
      description                = "Allow access to antivirus updates outbound."
      destination_address_prefix = ""
      destination_address_prefixes = [
        "149.25.153.72",   # NCR
        "149.25.153.171",  # NCR
        "192.127.4.38",    # NCR
        "192.127.252.171", # NCR
        "192.127.252.172", # NCR
      ]
      destination_application_security_group_ids = []
      destination_port_range                     = ""
      destination_port_ranges = [
        "443",
      ]
      direction                             = "Outbound"
      name                                  = "Allow_Antivirus_Updates_OB"
      priority                              = 208
      protocol                              = "Tcp"
      source_address_prefix                 = "*"
      source_address_prefixes               = []
      source_application_security_group_ids = []
      source_port_range                     = "*"
      source_port_ranges                    = []
    },
    {
      access                                     = "Allow"
      description                                = "Allow 80 and 443 for updates outbound."
      destination_address_prefix                 = "Internet"
      destination_address_prefixes               = []
      destination_application_security_group_ids = []
      destination_port_range                     = ""
      destination_port_ranges = [
        "80",
        "443",
      ]
      direction                             = "Outbound"
      name                                  = "Allow_OS_Updates_OB"
      priority                              = 209
      protocol                              = "Tcp"
      source_address_prefix                 = "*"
      source_address_prefixes               = []
      source_application_security_group_ids = []
      source_port_range                     = "*"
      source_port_ranges                    = []
    },
    {
      access                     = "Allow"
      description                = "Allow access to Carbon Black outbound."
      destination_address_prefix = ""
      destination_address_prefixes = [
        "192.127.202.77",
        "192.127.202.78",
        "192.127.202.79",
        "192.127.202.80",
        "192.127.202.81",
        "192.127.202.82",
      ]
      destination_application_security_group_ids = []
      destination_port_range                     = "443"
      destination_port_ranges                    = []
      direction                                  = "Outbound"
      name                                       = "Allow_CarbonBlack_OB"
      priority                                   = 210
      protocol                                   = "Tcp"
      source_address_prefix                      = "*"
      source_address_prefixes                    = []
      source_application_security_group_ids      = []
      source_port_range                          = "*"
      source_port_ranges                         = []
    },
    /*
    {
      access                     = "Allow"
      description                = "Allow access to Azure SMTP outbound."
      destination_address_prefix = ""
      destination_address_prefixes = [
        "135.137.0.9", # This needs to be updated to an in-Azure IP
      ]
      destination_application_security_group_ids = []
      destination_port_range                     = ""
      destination_port_ranges = [
        "25"
      ]
      direction                             = "Outbound"
      name                                  = "Allow_Azure_SMTP_OB"
      priority                              = 211
      protocol                              = "Tcp"
      source_address_prefix                 = "*"
      source_address_prefixes               = []
      source_application_security_group_ids = []
      source_port_range                     = "*"
      source_port_ranges                    = []
    },
    */
    {
      access                                     = "Allow"
      description                                = "Allow access to PREP Azure SQL Farm outbound."
      destination_address_prefix                 = "153.84.0.128/28"
      destination_address_prefixes               = []
      destination_application_security_group_ids = []
      destination_port_range                     = ""
      destination_port_ranges = [
        "1433", # SQL
        "1434", # SQL
      ]
      direction                             = "Outbound"
      name                                  = "Allow_PREP_AZ_SQL_FARM_OB"
      priority                              = 212
      protocol                              = "Tcp"
      source_address_prefix                 = "153.84.0.0/20" # Azure East US PREP
      source_address_prefixes               = []
      source_application_security_group_ids = []
      source_port_range                     = "*"
      source_port_ranges                    = []
    },
    {
      access                                     = "Allow"
      description                                = "Allow TSA outbound."
      destination_address_prefix                 = ""
      destination_address_prefixes               = ["153.86.8.60", "153.86.12.62", "153.86.8.53", ]
      destination_application_security_group_ids = []
      destination_port_range                     = ""
      destination_port_ranges = [
        "7007",
      ]
      direction                             = "Outbound"
      name                                  = "Allow_TSA_OB"
      priority                              = 213
      protocol                              = "Tcp"
      source_address_prefix                 = "153.84.0.0/20" # Azure East US PREP
      source_address_prefixes               = []
      source_application_security_group_ids = []
      source_port_range                     = "*"
      source_port_ranges                    = []
    },
    {
      access                                     = "Allow"
      description                                = "Allow LINUX Monitor outbound."
      destination_address_prefix                 = ""
      destination_address_prefixes               = ["153.84.16.85", "153.84.16.86", ]
      destination_application_security_group_ids = []
      destination_port_range                     = ""
      destination_port_ranges = [
        "162",
      ]
      direction                             = "Outbound"
      name                                  = "Allow_linux_monitor_OB"
      priority                              = 214
      protocol                              = "*"
      source_address_prefix                 = "153.84.0.0/16" # Azure East US PREP
      source_address_prefixes               = []
      source_application_security_group_ids = []
      source_port_range                     = "*"
      source_port_ranges                    = []
    },
    {
      access                                     = "Allow"
      description                                = "Allow Splunk Outbound."
      destination_address_prefix                 = ""
      destination_address_prefixes               = ["153.84.16.100", "153.84.16.101", "153.84.16.102", "153.84.16.103"]
      destination_application_security_group_ids = []
      destination_port_range                     = ""
      destination_port_ranges = [
        "8089",
        "9997"
      ]
      direction             = "Outbound"
      name                  = "Allow_Splunk_OB"
      priority              = 215
      protocol              = "*"
      source_address_prefix = ""
      source_address_prefixes = [
        "153.84.0.0/18",  # Azure US
        "153.84.128.0/19" # Azure India
      ]
      source_application_security_group_ids = []
      source_port_range                     = "*"
      source_port_ranges                    = []
    },
    {
      access                                     = "Allow"
      description                                = "Allow RPCtools Outbound."
      destination_address_prefix                 = ""
      destination_address_prefixes               = ["153.84.16.85", "153.84.16.86", ]
      destination_application_security_group_ids = []
      destination_port_range                     = ""
      destination_port_ranges                    = ["22", "135", "161", "443", "5985", "5986", ]
      direction                                  = "Outbound"
      name                                       = "Allow_RPCtools_OB"
      priority                                   = 216
      protocol                                   = "*"
      source_address_prefix                      = "*"
      source_address_prefixes                    = []
      source_application_security_group_ids      = []
      source_port_range                          = "*"
      source_port_ranges                         = []
    },

    # Priority 217 is reserverd for BigFIx rule for both gtm and corp base rules 
    {
      access                                     = "Deny"
      description                                = "Drop all else outbound."
      destination_address_prefix                 = "*"
      destination_address_prefixes               = []
      destination_application_security_group_ids = []
      destination_port_range                     = "*"
      destination_port_ranges                    = []
      direction                                  = "Outbound"
      name                                       = "Drop_All_Else_OB"
      priority                                   = 4096
      protocol                                   = "*"
      source_address_prefix                      = "*"
      source_address_prefixes                    = []
      source_application_security_group_ids      = []
      source_port_range                          = "*"
      source_port_ranges                         = []
    }
  ]
}

# log_analytics_workspace_info_v2 for environment specific
output "log_analytics_workspace_info_v2" {
  value = {
    ## dev environment
    "dev" = {
      "eus" = {
        "name" = "law-mgt-eus-prd"
        "rg"   = "rg-mgt-eus-prd"
      },
      "wus" = {
        "name" = "law-mgt-wus-prd"
        "rg"   = "rg-mgt-wus-prd"
      },
      "cin" = {
        "name" = "law-mgt-cin-prd"
        "rg"   = "rg-mgt-cin-prd"
      },
      "sin" = {
        "name" = "law-mgt-sin-prd"
        "rg"   = "rg-mgt-sin-prd"
      },
    }
    ## prod environment
    "prd" = {
      "eus" = {
        "name" = "law-mgt-eus-prd"
        "rg"   = "rg-mgt-eus-prd"
      },
      "wus" = {
        "name" = "law-mgt-wus-prd"
        "rg"   = "rg-mgt-wus-prd"
      },
      "cin" = {
        "name" = "law-mgt-cin-prd"
        "rg"   = "rg-mgt-cin-prd"
      },
      "sin" = {
        "name" = "law-mgt-sin-prd"
        "rg"   = "rg-mgt-sin-prd"
      },
    }
    ## test environment
    "tst" = {
      "eus" = {
        "name" = "law-mgt-eus-prd"
        "rg"   = "rg-mgt-eus-prd"
      },
      "wus" = {
        "name" = "law-mgt-wus-prd"
        "rg"   = "rg-mgt-wus-prd"
      },
      "cin" = {
        "name" = "law-mgt-cin-prd"
        "rg"   = "rg-mgt-cin-prd"
      },
      "sin" = {
        "name" = "law-mgt-sin-prd"
        "rg"   = "rg-mgt-sin-prd"
      },
    }
    ## poc environment
    "poc" = {
      "eus" = {
        "name" = "law-mgt-eus-prd"
        "rg"   = "rg-mgt-eus-prd"
      },
      "wus" = {
        "name" = "law-mgt-wus-prd"
        "rg"   = "rg-mgt-wus-prd"
      },
      "cin" = {
        "name" = "law-mgt-cin-prd"
        "rg"   = "rg-mgt-cin-prd"
      },
      "sin" = {
        "name" = "law-mgt-sin-prd"
        "rg"   = "rg-mgt-sin-prd"
      },
    }
    ## prep environment
    "prep" = {
      "eus" = {
        "name" = "law-mgt-eus-prd"
        "rg"   = "rg-mgt-eus-prd"
      },
      "wus" = {
        "name" = "law-mgt-wus-prd"
        "rg"   = "rg-mgt-wus-prd"
      },
      "cin" = {
        "name" = "law-mgt-cin-prd"
        "rg"   = "rg-mgt-cin-prd"
      },
      "sin" = {
        "name" = "law-mgt-sin-prd"
        "rg"   = "rg-mgt-sin-prd"
      },
    }
    ## uat environment
    "uat" = {
      "eus" = {
        "name" = "law-mgt-eus-prd"
        "rg"   = "rg-mgt-eus-prd"
      },
      "wus" = {
        "name" = "law-mgt-wus-prd"
        "rg"   = "rg-mgt-wus-prd"
      },
      "cin" = {
        "name" = "law-mgt-cin-prd"
        "rg"   = "rg-mgt-cin-prd"
      },
      "sin" = {
        "name" = "law-mgt-sin-prd"
        "rg"   = "rg-mgt-sin-prd"
      },
    }
  }
}

# central private dns zone information
output "private_dns_zone_info" {
  value = {
    "postgresql" = {
      "id" = "/subscriptions/550e6199-24a8-4f76-bdc1-ec40e3d2a70f/resourceGroups/rg-dns-net-eus-prd/providers/Microsoft.Network/privateDnsZones/privatelink.postgres.database.azure.com"
    },
    "sqlServer" = {
      "id" = "/subscriptions/550e6199-24a8-4f76-bdc1-ec40e3d2a70f/resourceGroups/rg-dns-net-eus-prd/providers/Microsoft.Network/privateDnsZones/privatelink.database.windows.net"
    },
    "file" = {
      "id" = "/subscriptions/550e6199-24a8-4f76-bdc1-ec40e3d2a70f/resourceGroups/rg-dns-net-eus-prd/providers/Microsoft.Network/privateDnsZones/privatelink.file.core.windows.net"
    },
    "blob" = {
      "id" = "/subscriptions/550e6199-24a8-4f76-bdc1-ec40e3d2a70f/resourceGroups/rg-dns-net-eus-prd/providers/Microsoft.Network/privateDnsZones/privatelink.blob.core.windows.net"
    },
    "table" = {
      "id" = "/subscriptions/550e6199-24a8-4f76-bdc1-ec40e3d2a70f/resourceGroups/rg-dns-net-eus-prd/providers/Microsoft.Network/privateDnsZones/privatelink.table.core.windows.net"
    },
    "ai_search" = {
      "id" = "/subscriptions/550e6199-24a8-4f76-bdc1-ec40e3d2a70f/resourceGroups/rg-dns-net-eus-prd/providers/Microsoft.Network/privateDnsZones/privatelink.search.windows.net"
    },
    "cognitiveservices" = {
      "id" = "/subscriptions/550e6199-24a8-4f76-bdc1-ec40e3d2a70f/resourceGroups/rg-dns-net-eus-prd/providers/Microsoft.Network/privateDnsZones/privatelink.cognitiveservices.azure.com"
    },
    "openai" = {
      "id" = "/subscriptions/550e6199-24a8-4f76-bdc1-ec40e3d2a70f/resourceGroups/rg-dns-net-eus-prd/providers/Microsoft.Network/privateDnsZones/privatelink.openai.azure.com"
    },
    "datafactory" = {
      "id" = "/subscriptions/550e6199-24a8-4f76-bdc1-ec40e3d2a70f/resourceGroups/rg-dns-net-eus-prd/providers/Microsoft.Network/privateDnsZones/privatelink.datafactory.azure.net"
    },
    "serivebus" = {
      "id" = "/subscriptions/550e6199-24a8-4f76-bdc1-ec40e3d2a70f/resourceGroups/rg-dns-net-eus-prd/providers/Microsoft.Network/privateDnsZones/privatelink.servicebus.windows.net"
    },
    "keyvault" = {
      "id" = "/subscriptions/550e6199-24a8-4f76-bdc1-ec40e3d2a70f/resourceGroups/rg-dns-net-eus-prd/providers/Microsoft.Network/privateDnsZones/privatelink.vaultcore.azure.net"
    },
    "webapp" = {
      "id" = "/subscriptions/550e6199-24a8-4f76-bdc1-ec40e3d2a70f/resourceGroups/rg-dns-net-eus-prd/providers/Microsoft.Network/privateDnsZones/privatelink.azurewebsites.net"
    },
    "documents_cosmos" = {
      "id" = "/subscriptions/550e6199-24a8-4f76-bdc1-ec40e3d2a70f/resourceGroups/rg-dns-net-eus-prd/providers/Microsoft.Network/privateDnsZones/privatelink.documents.azure.com"
    },
    "mongo_cosmos" = {
      "id" = "/subscriptions/550e6199-24a8-4f76-bdc1-ec40e3d2a70f/resourceGroups/rg-dns-net-eus-prd/providers/Microsoft.Network/privateDnsZones/privatelink.mongo.cosmos.azure.com"
    },
    "table_cosmos" = {
      "id" = "/subscriptions/550e6199-24a8-4f76-bdc1-ec40e3d2a70f/resourceGroups/rg-dns-net-eus-prd/providers/Microsoft.Network/privateDnsZones/privatelink.table.cosmos.azure.com"
    },
    "cassandra_cosmos" = {
      "id" = "/subscriptions/550e6199-24a8-4f76-bdc1-ec40e3d2a70f/resourceGroups/rg-dns-net-eus-prd/providers/Microsoft.Network/privateDnsZones/privatelink.cassandra.cosmos.azure.com"
    },
    "analytics_cosmos" = {
      "id" = "/subscriptions/550e6199-24a8-4f76-bdc1-ec40e3d2a70f/resourceGroups/rg-dns-net-eus-prd/providers/Microsoft.Network/privateDnsZones/privatelink.analytics.cosmos.azure.com"
    },
    "postgresql_cosmos" = {
      "id" = "/subscriptions/550e6199-24a8-4f76-bdc1-ec40e3d2a70f/resourceGroups/rg-dns-net-eus-prd/providers/Microsoft.Network/privateDnsZones/privatelink.postgres.database.azure.com"
    },
    "prometheus_monitor" = {
      "id" = "/subscriptions/550e6199-24a8-4f76-bdc1-ec40e3d2a70f/resourceGroups/rg-dns-net-eus-prd/providers/Microsoft.Network/privateDnsZones/privatelink.eastus.prometheus.monitor.azure.com"
    },
    "grafana" = {
      "id" = "/subscriptions/550e6199-24a8-4f76-bdc1-ec40e3d2a70f/resourceGroups/rg-dns-net-eus-prd/providers/Microsoft.Network/privateDnsZones/privatelink.grafana.azure.com"
    },
    "azure-api" = {
      "id" = "/subscriptions/550e6199-24a8-4f76-bdc1-ec40e3d2a70f/resourceGroups/rg-dns-net-eus-prd/providers/Microsoft.Network/privateDnsZones/privatelink.azure-api.net"
    },
    ## Add new subresource name here
  }
}






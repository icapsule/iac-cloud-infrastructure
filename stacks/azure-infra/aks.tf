# Virtual Network for Enterprise Isolation
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.prefix}-vnet"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/8"]

  tags = {
    Environment = var.environment
  }
}

# Subnet dedicated to AKS
resource "azurerm_subnet" "aks_subnet" {
  name                 = "aks-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.240.0.0/16"]
}

# Enterprise-Grade Azure Kubernetes Service (AKS)
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.prefix}-aks"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "${var.prefix}-k8s"

  # 关键点 1：使用 Free Tier。微软白送的高可用 Control Plane
  sku_tier = "Free"

  default_node_pool {
    name = "systempool"
    # 关键点 2：使用极高性价比的 B 系列实例 (2 Core, 4GB RAM)，大概 $30/月 (如果24小时跑的话)
    vm_size = "Standard_B2s"

    # 关键点 3：企业级弹性伸缩 (Auto-scaling)
    enable_auto_scaling = true
    min_count           = 1 # 最少保留 1 台维持集群心跳
    max_count           = 2 # 负载高时最多弹到 2 台

    vnet_subnet_id = azurerm_subnet.aks_subnet.id

    # 将此节点池标记为关键的系统负载池，后期可以再加 spot 节点给业务用
    type            = "VirtualMachineScaleSets"
    os_disk_size_gb = 30 # 最小化磁盘开销
  }

  # 关键点 4：SystemAssigned 身份，符合企业 Zero-Trust 安全规范
  identity {
    type = "SystemAssigned"
  }

  # 关键点 5：使用 Azure CNI (高级网络)，虽然贵一点 IP 资源，但这是企业网标准配置
  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "standard"
  }

  tags = {
    Environment = var.environment
  }
}

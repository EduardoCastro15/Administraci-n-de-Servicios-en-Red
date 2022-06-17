$location = 'eastus' #Localidad del centro de datos
$user = 'admin_Shu' #Nombre de Usuario
$password = convertto-securestring 'Nirvana_4799' -asplaintext -force #Contraseña
$credential = new-object System.Management.Automation.PSCredential ($user, $password); #Datos de Sesíón
$domainname = 'mygns3server-adminredes' #Nombre de Dominio
$sourcegroup = 'GNS3' #Grupo de Recursos Generico


new-azresourcegroup -name $sourcegroup -location $location
New-AzureRmNetworkSecurityGroup -Name $sourcegroup -ResourceGroupName $sourcegroup -Location $location

$nsg=Get-AzureRmNetworkSecurityGroup -Name $sourcegroup -ResourceGroupName $sourcegroup
$nsg | Add-AzureRmNetworkSecurityRuleConfig -Name TotalAccess -Description "Descripcion" -Access Allow -Protocol * -Direction Inbound -Priority 100 -SourceAddressPrefix * -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange * | Set-AzureRmNetworkSecurityGroup

new-azvm -resourcegroup $sourcegroup -location $location -name 'MIPRIMERA-MAQUINA' -image UbuntuLTS -size 'Standard_D4s_v3' -securitygroupname $sourcegroup -credential $credential -DomainNameLabel $domainname
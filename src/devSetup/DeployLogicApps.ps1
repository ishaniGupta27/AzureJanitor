param(
    [Parameter(Mandatory=$true)]
    [string] $subIdToDeployAzureJanitor,

    [Parameter(Mandatory=$true)]
    [string] $resourceGroupToToDeployAzureJanitor)

# order matters
$LogicApps = "CheckResourceGroupsApp","ResourceGroupOwnerApp","DeleteResourceGroupApp","EmailAlertingApp","TeamsBotApp","InsightsTeamsBotApp","InsightsApp","CoreApp"

$logicAppsFolder = "logicApps"
foreach ($logicAppName in $LogicApps)
{
  Write-Host "Deploying Arm Template for $logicAppName in Subscription :$subIdToDeployAzureJanitor , ResourceGroup: $resourceGroupToToDeployAzureJanitor "
  New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupToToDeployAzureJanitor -TemplateFile "../$logicAppsFolder/$logicAppName.json"
} 


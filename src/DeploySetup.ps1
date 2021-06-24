param(
    [Parameter(Mandatory=$true)]
    [string] $subIdToDeployAzureJanitor,

    [Parameter(Mandatory=$true)]
    [string] $resourceGroupToToDeployAzureJanitor)

Write-Host "Deploying Azure Policy and User Assigned Identity"
New-AzSubscriptionDeployment -Location eastus -TemplateFile .\AzurePolicyAndUserAssignedIdentityCreation.json -TemplateParameterFile .\azuredeploy.parameters.json -verbose

Write-Host "Deploying connectons needed for logic apps in ResourceGroup:$resourceGroupToToDeployAzureJanitor"
New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupToToDeployAzureJanitor -TemplateFile .\AllConnections.json -TemplateParameterFile .\azuredeploy.parameters.json -verbose

# order matters
$LogicApps = "CheckResourceGroupsApp","ResourceGroupOwnerApp","DeleteResourceGroupApp","EmailAlertingApp","TeamsBotApp","InsightsTeamsBotApp","InsightsApp","CoreApp"

$logicAppsFolder = "logicApps"
foreach ($logicAppName in $LogicApps)
{
  Write-Host "Deploying Armm Template for $logicAppName in Subscription :$subIdToDeployAzureJanitor , ResourceGroup: $resourceGroupToToDeployAzureJanitor "
  New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupToToDeployAzureJanitor -TemplateFile "../$logicAppsFolder/$logicAppName.json"
}

Write-Host "Configuring subscription $subIdToDeployAzureJanitor to AzurePolicy"
$userIdentityId = "/subscriptions/$subIdToDeployAzureJanitor/resourceGroups/$resourceGroupToToDeployAzureJanitor/providers/Microsoft.ManagedIdentity/userAssignedIdentities/AzureJanitorIdentity"
$principalID = (Get-AzResource -ResourceId $userIdentityId).Properties.PrincipalId

New-AzSubscriptionDeployment -Location eastus -TemplateFile .\OnboardSubscriptionToAzurePolicy.json -TemplateParameterFile .\azuredeploy.parameters.json -PrincipalId $principalID -verbose
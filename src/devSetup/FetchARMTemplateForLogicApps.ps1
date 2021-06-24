param(
    [Parameter(Mandatory=$true)]
    [string] $subIdToFetchLogicAppTemplates,

    [Parameter(Mandatory=$true)]
    [string] $resourceGroupToFetchLogicAppTemplates)

#configure params to fetch arm template corresponding to deployed logic apps
$ARMtemplateFromLogicAppsParams = @{
    Token = (az account get-access-token | ConvertFrom-Json).accessToken
    ResourceGroup = $resourceGroupToFetchLogicAppTemplates
    SubscriptionId = $subIdToFetchLogicAppTemplates
    Verbose = $true
}

$logicAppsFolder = "logicApps"

$LogicApps = "CheckResourceGroupsApp","ResourceGroupOwnerApp","DeleteResourceGroupApp","EmailAlertingApp","TeamsBotApp","InsightsTeamsBotApp","InsightsApp","CoreApp"

foreach ($logicAppName in $LogicApps)
{
  Write-Host "Fetching Armm Template for $logicAppName from Subscription :$subIdToFetchLogicAppTemplates , ResourceGroup: $resourceGroupToFetchLogicAppTemplates "
  Get-LogicAppTemplate @ARMtemplateFromLogicAppsParams -LogicApp $logicAppName -DisableConnectionGeneration | Out-File ../$logicAppsFolder/"$logicAppName.json"
} 


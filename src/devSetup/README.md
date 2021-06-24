# Quick Note

Development of Azure Janiotr is very easy because of the underlying logic apps infrastructure. 
The best way to develop logic apps is via azure portal. Hence, 
 
1 Deploy the latest janiotr version in any of your subscription (Go to DeploySetup Folder)
2 Update the logic apps via portal
3 Fetch the newer logic app code (FetchARMTemplateForLogicApps.ps1)
4 Send the PR to Azure Janiot Repo


# FetchARMTemplateForLogicApps.ps1

Logic app provides powershell commands to fetch corresponding arm templates for the logic app workflows. Once developed, FetchARMTemplateForLogicApps fetches these templates and update them in logicApps folder.
These templates are used by deploy setup.

NOTE : while running FetchARMTemplateForLogicApps, powershell will ask for some "audience" parameters. please put : https://management.azure.com . Known limitation. 

# Quick Note

Deployment of azure Janitor is 2 click process.

Go to : <localpath>\src\deploySetup

---- Configure Parameters -----------

Choose the subscription on which the onboarding will be done
Get-AzSubscription -SubscriptionId <subid> | Select-AzSubscription

Open <localpath>\src\azuredeploy.parameters.json
Parameters Information that should be updated:

Subscription : <subid>
DaysUntilDeletion : Days to retain the resource groups for
AlertDaysBeforeDeletion : Number of days before deletion alert is required
AdminEmail : Admin email via which the notification will be sent to the team

------ Deploy -------

run : .\DeploySetup.ps1 . It will ask for subscription/resource group. 
NOTE : Enter these values same as those entered in parameter files. Known limitation. Voila! that's it. This deploys azure janitor to your sub.

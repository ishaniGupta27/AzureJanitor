# AzureJanitor

This repo contains all ther necesaary components needed to deploy and onboard to AzureJanitor. See the Contribution guide for how to use or contribute to this repo.


# Introduction

AzureJanitor is a Serverless Service which enables subscription owners to configure auto-deletion (along with verbose monitoring/alerting) of _stale_ resources to save usage costs. A resource is said to be a _stale_ resource if it is not used and hence, is a waste cost to the organization. Integrate this app with Azure subscriptions and it will take care of the cleanup. The cleanup is based on the age of the resources defined by the sub admin. The resources owner can override the deletion conditions afterwards though.

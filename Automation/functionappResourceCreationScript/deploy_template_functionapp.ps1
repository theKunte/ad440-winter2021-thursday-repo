#parameters required to run the script.
param(
    [Parameter(Mandatory = $True)]
    [string]
    $subscriptionId,

    [Parameter(Mandatory = $True)]
    [string]
    $tenantId,

    [Parameter(Mandatory = $True)]
    [string]
    $servicePrincipalId,

    [Parameter(Mandatory = $True)]
    [String]
    $servicePrincipalPassword,

    [Parameter(Mandatory = $True)]
    [string]
    $resourceGroupName,

    [Parameter(Mandatory = $True)]
    [string]
    $functionAppName,

    [Parameter(Mandatory = $True)]
    [string]
    $storageAccountName,

    [Parameter(Mandatory = $True)]
    [string]
    $appServicePlanName,

    [Parameter(Mandatory = $True)]
    [string]
    $appInsightName,

    [Parameter(Mandatory = $True)]
    [string]
    $location,

    [Parameter(Mandatory = $True)]
    [string]
    $templateFilePath
)
# Remove all Azure credientials 
Clear-AzContext -Force;
$securePassword = ConvertTo-SecureString -String $servicePrincipalPassword -AsPlainText -Force;
$credentials = New-Object -TypeName System.Management.Automation.PSCredential($servicePrincipalId, $securePassword);

# Connect to Azure with authentication
Connect-AzAccount -Credential $credentials -ServicePrincipal -Tenant $tenantId -SubscriptionId $subscriptionId;

# Creates Azure Resource Group
New-AzResourceGroup -Name $resourceGroupName -Location $location

# Adds Azure deployment to a resource 
New-AzResourceGroupDeployment `
    -ResourceGroupName $resourceGroupName `
    -TemplateFile  $templateFilePath `
    -FunctionAppName $functionAppName `
    -StorageAccountName $storageAccountName `
    -AppServicePlanName $appServicePlanName `
    -AppInsightName $appInsightName `
    -Location $location
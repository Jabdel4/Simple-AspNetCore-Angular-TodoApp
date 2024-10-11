using 'resources.bicep'

@allow([
  'B1',
  'B2',
  'B3',
  'F1' //Free
])
param sku  = 'F1' // The SKU of App Service Plan

@allowed([
  'node|20-lts',
  'node|19-lts',
  'node|18-lts',
  'node|17-lts',
  'node|16-lts',
  'node|15-lts',
  'node|14-lts',
])
param clientLinuxFxVersion  = 'node|18-lts' // The runtime stack of client web app

@allowed([
  'dotnetcore|8.0',
  'dotnetcore|7.0',
  'dotnetcore|6.0',
  'dotnetcore|5.0',
  'dotnetcore|3.1',
])
param apiLinuxFxVersion  = 'dotnetcore|7.0' // The runtime stack of api web app

@description('Specifies the Azure location where the key vault should be created.')
@allowed([
  'southafricanorth',
  'southafricaeast',
  'westus',
  'eastus'
])
param location  = 'southafricanorth'

param clientWebSiteName = toLower('client-wapp-${prefix}')

param apiWebSiteName = toLower('api-wapp-${prefix}')

param appServicePlanName = toLower('ASP-${prefix}')

@description('Name of the workspace where the data will be stored.')
param workspaceName = 'wks-${prefix}'

@description('Names of the application insights resource.')
param clientApplicationInsightsName = toLower('${prefix}-client-appi')

param apiApplicationInsightsName = toLower('${prefix}-api-appi')


var prefix = 'todoApp'


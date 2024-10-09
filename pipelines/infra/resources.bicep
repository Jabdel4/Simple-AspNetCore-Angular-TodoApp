// TODO: INtroduce resources (App Service Plan, 2 App Service, 2 App Insights). Later: ACR, ACI, AKS

param clientWebSiteName string
param apiWebSiteName string
param sku string 
param clientLinuxFxVersion string
param apiLinuxFxVersion string
param location string
param appServicePlanName string

resource appServicePlan 'Microsoft.Web/serverfarms@2020-06-01' = {
  name: appServicePlanName
  location: location
  properties: {
    reserved: true
  }
  sku: {
    name: sku
  }
  kind: 'linux'
}

resource clientAppService 'Microsoft.Web/sites@2020-06-01' = {
  name: clientWebSiteName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      linuxFxVersion: clientLinuxFxVersion
    }
  }
}

resource apiAppService 'Microsoft.Web/sites@2020-06-01' = {
  name: apiWebSiteName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      linuxFxVersion: apiLinuxFxVersion
    }
  }
}

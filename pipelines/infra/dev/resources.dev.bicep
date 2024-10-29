// TODO: INtroduce resources (App Service Plan, 2 App Service, 2 App Insights). Later: ACR, ACI, AKS, Key Vault

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
      appSettings: [
	    {
	        name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
            value: clientApplicationInsights.properties.InstrumentationKey
        }
        {
            name: 'APPLICATIONINSIGHTS_CONNECTION_STRING'
            value: clientApplicationInsights.properties.ConnectionString
        }
        {
            name: 'ApplicationInsightsAgent_EXTENSION_VERSION'
            value: '~3'
        }
      ]
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
      appSettings: [
	    {
	        name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
            value: apiApplicationInsights.properties.InstrumentationKey
        }
        {
            name: 'APPLICATIONINSIGHTS_CONNECTION_STRING'
            value: apiApplicationInsights.properties.ConnectionString
        }
        {
            name: 'ApplicationInsightsAgent_EXTENSION_VERSION'
            value: '~3'
        }
      ]
    }
  }
}


param workspaceName string

param clientApplicationInsightsName string

param apiApplicationInsightsName string




resource workspace 'Microsoft.OperationalInsights/workspaces@2020-10-01' = {
  name: workspaceName
  location: location
  properties: {
    sku: {
      name: 'PerGB2018'
    }
  }
}

resource clientApplicationInsights 'Microsoft.Insights/components@2020-02-02-preview' = {
  name: clientApplicationInsightsName
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
    WorkspaceResourceId: workspace.id
  }
}

resource apiApplicationInsights 'Microsoft.Insights/components@2020-02-02-preview' = {
  name: apiApplicationInsightsName
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
    WorkspaceResourceId: workspace.id
  }
}
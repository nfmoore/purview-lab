param storageAccountName string = 'str${uniqueString(resourceGroup().name)}'
param dataFactoryName string = 'adf${uniqueString(resourceGroup().name)}'
param purviewName string = 'pur${uniqueString(resourceGroup().name)}'

resource storageAccount 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  kind: 'StorageV2'
  location: resourceGroup().location
  name: storageAccountName
  sku: {
    name: 'Standard_LRS'
  }
  properties: {
    isHnsEnabled: true
  }
}

resource dataFactory 'Microsoft.DataFactory/factories@2018-06-01' = {
  name: dataFactoryName
  location: resourceGroup().location
  identity: {
    type: 'SystemAssigned'
  }
}

resource purview 'Microsoft.Purview/accounts@2020-12-01-preview' = {
  name: purviewName
  location: resourceGroup().location
  sku: {
    name: 'Standard'
    capacity: 4
  }
  identity: {
    type: 'SystemAssigned'
  }
}

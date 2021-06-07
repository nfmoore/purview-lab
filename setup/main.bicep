targetScope = 'subscription'

param baseRgName string = 'purviewlab'
param location string = 'australiaeast'
param numberOfDeployments int = 1

resource resourceGroups 'Microsoft.Resources/resourceGroups@2021-04-01' = [for i in range(1, numberOfDeployments): {
  name: '${baseRgName}-${i}'
  location: location
}]

module deployment './deployment.bicep' = [for i in range(1, numberOfDeployments): {
  name: 'purview-lab-deployment-${i}'
  scope: resourceGroup(resourceGroups[i].name)
  params: {
    storageAccountName: 'str${substring(uniqueString(resourceGroups[i].id), 0, 4)}wes${i}'
    dataFactoryName: 'adf${substring(uniqueString(resourceGroups[i].id), 0, 4)}wes${i}'
    purviewName: 'pur${substring(uniqueString(resourceGroups[i].id), 0, 4)}wes${i}'
  }
}]

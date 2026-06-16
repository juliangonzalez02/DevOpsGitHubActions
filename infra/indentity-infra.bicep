param location string = resourceGroup().location

param acrName string
param managedIdentityName string

@description('AcrPull built-in role definition ID')
var acrPullRoleDefinitionId = '7f951dda-4ed3-4680-a7ca-43fe172d538d'

resource acr 'Microsoft.ContainerRegistry/registries@2023-07-01' existing = {
    name: acrName
}

resource identity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' = {
    name: managedIdentityName
    location: location
}

resource acrPullAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
    name: guid(acr.id, identity.id, acrPullRoleDefinitionId)
    scope: acr
    properties: {
        roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', acrPullRoleDefinitionId)
        principalId: identity.properties.principalId
        principalType: 'ServicePrincipal'
    }
}

output managedIdentityName string = identity.name
output managedIdentityId string = identity.id
output managedIdentityPrincipalId string = identity.properties.principalId

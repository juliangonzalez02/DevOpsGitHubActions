param location string = resourceGroup().location

param containerAppName string
param containerAppEnvironmentName string
param acrName string
param imageName string

param containerName string = 'web'
param targetPort int = 80
param minReplicas int = 0
param maxReplicas int = 1

@description('AcrPull built-in role definition ID')
var acrPullRoleDefinitionId = '7f951dda-4ed3-4680-a7ca-43fe172d538d'

resource containerAppEnv 'Microsoft.App/managedEnvironments@2024-03-01' existing = {
    name: containerAppEnvironmentName
}

resource acr 'Microsoft.ContainerRegistry/registries@2023-07-01' existing = {
    name: acrName
}

resource containerApp 'Microsoft.App/containerApps@2024-03-01' = {
    name: containerAppName
    location: location
    identity: {
        type: 'SystemAssigned'
    }
    properties: {
        managedEnvironmentId: containerAppEnv.id
        configuration: {
            activeRevisionsMode: 'Single'
            registries: [
                {
                    server: acr.properties.loginServer
                    identity: 'system'
                }
            ]
            ingress: {
                external: true
                targetPort: targetPort
                transport: 'auto'
                traffic: [
                    {
                        latestRevision: true
                        weight: 100
                    }
                ]
            }
        }
        template: {
            containers: [
                {
                    name: containerName
                    image: imageName
                    resources: {
                        cpu: json('0.25')
                        memory: '0.5Gi'
                    }
                }
            ]
            scale: {
                minReplicas: minReplicas
                maxReplicas: maxReplicas
            }
        }
    }
}

resource acrPullAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
    name: guid(acr.id, containerApp.id, acrPullRoleDefinitionId)
    scope: acr
    properties: {
        roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', acrPullRoleDefinitionId)
        principalId: containerApp.identity.principalId
        principalType: 'ServicePrincipal'
    }
}

output containerAppName string = containerApp.name
output containerAppUrl string = 'https://${containerApp.properties.configuration.ingress.fqdn}'
output principalId string = containerApp.identity.principalId
output acrLoginServer string = acr.properties.loginServer

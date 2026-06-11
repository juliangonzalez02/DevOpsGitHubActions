param location string = resourceGroup().location

param containerAppName string
param containerAppEnvironmentName string
param managedIdentityName string
param acrName string
param imageName string

param containerName string = 'web'
param targetPort int = 80
param minReplicas int = 0
param maxReplicas int = 1

resource containerAppEnv 'Microsoft.App/managedEnvironments@2024-03-01' existing = {
    name: containerAppEnvironmentName
}

resource acr 'Microsoft.ContainerRegistry/registries@2023-07-01' existing = {
    name: acrName
}

resource identity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' existing = {
    name: managedIdentityName
}

resource containerApp 'Microsoft.App/containerApps@2024-03-01' = {
    name: containerAppName
    location: location
    identity: {
        type: 'UserAssigned'
        userAssignedIdentities: {
            '${identity.id}': {}
        }
    }
    properties: {
        managedEnvironmentId: containerAppEnv.id
        configuration: {
            activeRevisionsMode: 'Single'
            registries: [
                {
                    server: acr.properties.loginServer
                    identity: identity.id
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

output containerAppName string = containerApp.name
output containerAppUrl string = 'https://${containerApp.properties.configuration.ingress.fqdn}'
output acrLoginServer string = acr.properties.loginServer

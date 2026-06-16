using './container-app.bicep'

param containerAppName = 'ca-devops-githubactions-prod'
param containerAppEnvironmentName = 'cae-devops-githubactions'
param managedIdentityName = 'id-devops-githubactions-prod'
param acrName = 'REPLACE_WITH_GITHUB_ACTIONS'
param imageName = 'REPLACE_WITH_GITHUB_ACTIONS'
param targetPort = 80
param minReplicas = 0
param maxReplicas = 1

using './container-app.bicep'

param containerAppName = 'ca-devops-githubactions-dev'
param containerAppEnvironmentName = 'cae-devops-githubactions'
param acrName = 'acrdevopsha10498'
param imageName = 'REPLACE_WITH_IMAGE'
param targetPort = 80
param minReplicas = 0
param maxReplicas = 1

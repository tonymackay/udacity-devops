pipeline {
  agent any
  stages {
    stage('Lint JavaScript') {
      steps {
        sh '''
          cd app
          npm install
          npm run lint
           '''
      }
    }
    stage('Build Docker Image') {
      steps {
        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws-secret', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
          sh '''
            cd app
            make release
             '''
        }
      }
    }
  }
}

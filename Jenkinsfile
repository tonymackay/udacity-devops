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
        sh '''
          cd app
          make release
           '''
      }
    }
  }
}
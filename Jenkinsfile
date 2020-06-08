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
          make build
           '''
      }
    }
    stage('Publish Docker Image') {
      steps {
        withDockerRegistry([ credentialsId: "docker-hub", url: "" ]) {
          sh '''
            cd app
            make publish
             '''
        }
      }
    }
    stage('Deploy to Cluster') {
      steps {
        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws-secret', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
          sh '''
             echo "TODO"
             '''
        }
      }
    }
  }
}

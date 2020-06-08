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
        sh "/bin/bash tool.sh build"
      }
    }
    stage('Publish Docker Image') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'docker-hub', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
        // available as an env variable, but will be masked if you try to print it out any which way
        // note: single quotes prevent Groovy interpolation; expansion is by Bourne Shell, which is what you want
        sh '''
          "/bin/bash tool.sh tag"
          "/bin/bash tool.sh publish"
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

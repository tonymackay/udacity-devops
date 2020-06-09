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
          sh "/bin/bash tool.sh tag"
          sh "/bin/bash tool.sh publish"
        }
      }
    }

    stage('Set current kubectl context') {
      steps {
        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws-secret', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
          sh "kubectl config use-context arn:aws:eks:us-east-1:662263256076:cluster/udacity-devops"
        }
      }
    }

    stage('Deploy green container') {
      steps {
        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws-secret', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
          sh "aws eks update-kubeconfig --name udacity-devops"
          sh "kubectl apply -f k8s/green-controller.yml"
        }
      }
    }
  
    stage('Confirm traffic switch to green') {
      steps {
        input "Ready to redirect traffic to green?"
      }
    }

    stage('Redirect traffic to green service') {
      steps {
        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws-secret', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
          sh "kubectl apply -f k8s/green-service.yml"
        }
      }
    }

    stage('Confirm traffic switch back to blue') {
      steps {
        input "Ready to update and redirect back to blue?"
      }
    }

    stage('Deploy blue container') {
      steps {
        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws-secret', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
          sh "kubectl apply -f k8s/blue-controller.yml"
        }
      }
    }

    stage('Redirect traffic back to blue service') {
      steps {
        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws-secret', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
          sh "kubectl apply -f k8s/blue-service.yml"
        }
      }
    }

  }
}

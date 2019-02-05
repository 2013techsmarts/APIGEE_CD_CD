pipeline {
  agent any
  stages {
    /*stage('Static Analysis') {
    
      steps {
          // send build started notifications
       slackSend (color: '#FFFF00', message: "STARTED Static Analysis: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
        sh '''#!/bin/bash
export PATH=/Users/sjana2/Documents/POC/node-v10.15.1/bin/:$PATH
apigeelint -s /Users/sjana2/Documents/POC/Proxy/apiproxy/ -f table.js'''
      }
    }*/
    stage('Build APIProxy Bundle') {
    
      steps {
          // send build started notifications
       slackSend (color: '#FFFF00', message: "STARTED Build to create API PROXY Bundle: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
        sh '''#!/bin/bash
export PATH=/Users/sjana2/Documents/POC/node-v10.15.1/bin/:$PATH
cd /Users/sjana2/.jenkins/workspace/APIGEE_CI_CD_DEMO_master/
zip -r CI_CD_PROXY apiproxy/'''
      }
    }

    stage('Deploy APIProxy Bundle') {
    
      steps {
          // send build started notifications
       slackSend (color: '#FFFF00', message: "STARTED Deploying API PROXY Bundle to TEST environment: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
        sh '''#!/bin/bash
export PATH=/Users/sjana2/Documents/POC/node-v10.15.1/bin/:$PATH
cd /Users/sjana2/.jenkins/workspace/APIGEE_CI_CD_DEMO_master/
chmod 777 deploy.sh
./deploy.sh'''
      }
    }

    stage('Perform Integration Tests') {
    
      steps {
          // send build started notifications
       slackSend (color: '#FFFF00', message: "Performing Integration tests: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
        sh '''#!/bin/bash
export PATH=/Users/sjana2/Documents/POC/node-v10.15.1/bin/:$PATH
cd test
newman run CI_CD.postman_collection.json'''
      }
    }
  }
  post {
    success {
      slackSend (color: '#00FF00', message: "SUCCESSFUL: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
    }

    failure {
      slackSend (color: '#FF0000', message: "FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
    }
  }
}

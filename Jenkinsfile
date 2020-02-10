pipeline {
 agent any
 
 stages {
  stage ("Git checkout") {
   steps {
     git 'https://github.com/manu1rock/blueocean.git'    
    }
  }
  
  stage ("Build") {
   steps {
    script {
     bat 'mvn compile'
    }    
    }
  }
  
  stage ("Test") {
   steps {
    script {
     bat 'mvn test'
    }    
    }
  }
 
   stage ("Deploy") {
   steps {
    script {
     bat "echo ${env.BUILD_DISPLAY_NAME}"
    }    
    }
  }
 }
 
 post {
  success {
      echo "SUCCESS"
    }
  failure {
      echo "FAILURE"
    }
  changed {
      echo "Status Changed: [From: $currentBuild.previousBuild.result, To: $currentBuild.result]"
    }
  always {
      script {
        def result = currentBuild.result
        if (result == null) {
          result = "SUCCESS"
        }
      }   
       junit allowEmptyResults: true, testResults: '**/test-results/*.xml'
    }
 } 
 
}
 
  
  

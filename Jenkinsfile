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
 }
 
 post {
    always {
      junit allowEmptyResults: true, testResults: '**/test-results/*.xml'
    }
 } 
 
}
 
  
  

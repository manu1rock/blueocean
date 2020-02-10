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
     sh 'mvn compile'
    }    
    }
  }
  
  stage ("Test") {
   steps {
    script {
     sh 'mvn test'
    }    
    }
  }
 }
 
}
 
  
  

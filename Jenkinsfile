pipeline {
 agent any
 
 stages {
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
 
  
  

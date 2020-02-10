pipeline {
 agent any
 
 stages {
  stage ("Build") {
   steps {
    script {
     sh 'mvn compile', buildInfo: buildInfo
    }    
    }
  }
  
  stage ("Test") {
   steps {
    script {
     sh 'mvn test', buildInfo: buildInfo
    }    
    }
  }
 }
 
}
 
  
  

pipeline {
 agent any
 
 stages {
  stage ("Build") {
   steps {
    script {
     'mvn compile', buildInfo: buildInfo
    }    
    }
  }
  
  stage ("Test") {
   steps {
    script {
     'mvn test', buildInfo: buildInfo
    }    
    }
  }
 }
 
}
 
  
  

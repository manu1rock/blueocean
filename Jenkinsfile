pipeline {
 agent any
 
 stages {
  stage ("Build") {
   steps {
    script {
     rtMaven.run pom: 'pom.xml', goals: 'compile', buildInfo: buildInfo
    }    
    }
  }
  
  stage ("Test") {
   steps {
    script {
     rtMaven.run pom: 'pom.xml', goals: 'test', buildInfo: buildInfo
    }    
    }
  }
 }
 
}
 
  
  

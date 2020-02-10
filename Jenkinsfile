pipeline {
 agent any
 
 tools{
  maven 'maven 3'
  jdk 'java 8'
  }
 
 parameters {
  booleanParam(name: "RELEASE",
               description: "Build a release from current commit.",
               defaultValue: false)
    }
 
 stages {
  stage ("initialize") {
   steps {
    sh '''
    echo "PATH = ${PATH}"
    echo "M2_HOME = ${M2_HOME}"
    '''
    }
  }
 }
 
 stage ('Build project') {
  steps {
   dir("blueocean"){
    sh 'mvn clean verify'
    }
   }
  }
 
 stage ('Artifactory Deploy'){
  when {
   branch "master"
   }
  steps{
   dir("blueocean"){
    script {
     def server = Artifactory.server('artifactory')
     def rtMaven = Artifactory.newMavenBuild()
     rtMaven.resolver server: server, releaseRepo: 'libs-release', snapshotRepo: 'libs-snapshot'
     rtMaven.deployer server: server, releaseRepo: 'libs-release-local', snapshotRepo: 'libs-snapshot-local'
     rtMaven.tool = 'maven 3'
     def buildInfo = rtMaven.run pom: 'pom.xml', goals: 'install'
     server.publishBuildInfo buildInfo
     }
    }
   }
  }
}
 
  
  

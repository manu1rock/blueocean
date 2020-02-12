pipeline {
 agent any
 
 def server
 def buildInfo
 def rtMaven
 
 stages {
  stage ("Git checkout") {
   steps {
     git 'https://github.com/manu1rock/blueocean.git'  
     bat "echo ${getChangeSet()}"
    }
  }
  
  stage ('Artifactory configuration') {
        // Obtain an Artifactory server instance, defined in Jenkins --> Manage:
        server = Artifactory.server SERVER_ID

        rtMaven = Artifactory.newMavenBuild()
        rtMaven.tool = MAVEN_TOOL // Tool name from Jenkins configuration
        rtMaven.deployer releaseRepo: 'libs-release-local', snapshotRepo: 'libs-snapshot-local', server: server
        rtMaven.resolver releaseRepo: 'libs-release', snapshotRepo: 'libs-snapshot', server: server
        rtMaven.deployer.deployArtifacts = false // Disable artifacts deployment during Maven run

        buildInfo = Artifactory.newBuildInfo()
    }
  
  stage ("Build") {
   steps {
    script {
     bat 'mvn package'
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
     rtMaven.deployer.deployArtifacts buildInfo
    }    
    }
  }
  
  stage ('Publish build info') {
        server.publishBuildInfo buildInfo
    }
 }
 
 post {
  success {
      echo "SUCCESSFUL: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})"
      archiveArtifacts artifacts: 'target/*.jar', onlyIfSuccessful: true
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
 
 @NonCPS

// Fetching change set from Git
def getChangeSet() {
  return currentBuild.changeSets.collect { cs ->
    cs.collect { entry ->
        "* ${entry.author.fullName}: ${entry.msg}"
    }.join("\n")
  }.join("\n")
} 

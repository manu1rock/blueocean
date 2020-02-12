pipeline {
 agent any
 
 stages {
  stage ("Git checkout") {
   steps {
     git 'https://github.com/manu1rock/blueocean.git'  
     bat "echo ${getChangeSet()}"
    }
  }  
  
  stage ("Build") {
   steps {
    script {
     bat 'mvn clean install package'
    }    
    }
  }
  
  stage('Artifactory upload'){
            steps {
                script{
                    // Obtain an Artifactory server instance, defined in Jenkins --> Manage:
                    def server = Artifactory.server 'Artifactory Version 6.17.0'

                    // Read the download and upload specs:
                 def downloadSpec = """{
                 "files": [{
                             "pattern": "libs-snapshot-local/*(Pipeline).zip",
                             "target": "libs-release-local/",
                             "props": "p1=v1;p2=v2"
                           }]
                                        }"""
                    def uploadSpec = """{
                    "files": [{
                       "pattern": "libs-release-local/",
                       "target": "libs-release-local/"
                    }]
                 }"""

                    // Download files from Artifactory:
                    def buildInfo1 = server.download spec: downloadSpec
                    // Upload files to Artifactory:
                    def buildInfo2 = server.upload spec: uploadSpec

                    // Merge the local download and upload build-info instances:
                    buildInfo1.append buildInfo2

                    // Publish the merged build-info to Artifactory
                    server.publishBuildInfo buildInfo1
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

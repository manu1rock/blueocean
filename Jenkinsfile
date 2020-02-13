pipeline {
 agent any
 
 stages {
  stage ("Git checkout") {
   steps {
     git 'https://github.com/manu1rock/blueocean.git'  
     bat "echo ${getChangeSet()}"
    }
  }  
  
  stage ('Artifactory configuration') {
            steps {
                rtServer (
                    id: 'Art_6.17.0',
                    url: 'http://localhost:8040/artifactory/',
                    username: 'tesuser',
                    password: 'Testing@20'
                )

                rtMavenDeployer (
                    id: 'MAVEN_DEPLOYER',
                    serverId: 'http://localhost:8040/artifactory/',
                    releaseRepo: "libs-release-local",
                    snapshotRepo: "libs-snapshot-local"
                )

                rtMavenResolver (
                    id: "MAVEN_RESOLVER",
                    serverId: 'http://localhost:8040/artifactory/',
                    releaseRepo: "libs-release",
                    snapshotRepo: "libs-snapshot"
                )
            }
        }

        stage ('Exec Maven') {
            steps {
                rtMavenRun (
                    tool: 'M3', // Tool name from Jenkins configuration
                    pom: 'pom.xml',
                    goals: 'clean install',
                    deployerId: "MAVEN_DEPLOYER",
                    resolverId: "MAVEN_RESOLVER"
                )
            }
        }

        stage ('Publish build info') {
            steps {
                rtPublishBuildInfo (
                    serverId: 'http://localhost:8040/artifactory/'
                )
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

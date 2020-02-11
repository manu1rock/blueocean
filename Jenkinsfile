pipeline {
 agent any
 
 stages {
  stage ("Git checkout") {
   steps {
     git 'https://github.com/manu1rock/blueocean.git'    
    }
    def changelogString = gitChangelog returnType: 'STRING',
  from: [type: 'REF', value: 'git-changelog-1.50'],
  to: [type: 'REF', value: 'master'],
  template: """
  <h1> Git Changelog changelog </h1>

<p>
Changelog of Git Changelog.
</p>

{{#tags}}
<h2> {{name}} </h2>
 {{#issues}}
  {{#hasIssue}}
   {{#hasLink}}
<h2> {{name}} <a href="{{link}}">{{issue}}</a> {{title}} </h2>
   {{/hasLink}}
   {{^hasLink}}
<h2> {{name}} {{issue}} {{title}} </h2>
   {{/hasLink}}
  {{/hasIssue}}
  {{^hasIssue}}
<h2> {{name}} </h2>
  {{/hasIssue}}


   {{#commits}}
<a href="https://github.com/tomasbjerre/git-changelog-lib/commit/{{hash}}">{{hash}}</a> {{authorName}} <i>{{commitTime}}</i>
<p>
<h3>{{{messageTitle}}}</h3>

{{#messageBodyItems}}
 <li> {{.}}</li> 
{{/messageBodyItems}}
</p>


  {{/commits}}

 {{/issues}}
{{/tags}}
  """
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
 
  
  

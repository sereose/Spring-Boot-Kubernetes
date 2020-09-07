properties([
        parameters(
                [
                        booleanParam(
                                name: 'DEPLOY_BRANCH_TO_TST',
                                defaultValue: false
                        )
                ]
        )
])

def branch
def revision
def registryIp

pipeline {

    agent any 
    options {
        skipDefaultCheckout true
    }

    stages {
        stage ('checkout') {
            steps {
                script {
                    def repo = checkout scm
                    revision = sh(script: 'git log -1 --format=\'%h.%ad\' --date=format:%Y%m%d-%H%M | cat', returnStdout: true).trim()
                    branch = repo.GIT_BRANCH.take(20).replaceAll('/', '_')
                    if (branch != 'master') {
                        revision += "-${branch}"
                    }
                    sh "echo 'Building revision: ${revision}'"
                }
            }
        }
   stage ('compile') {
            steps {
		sh '''#!/bin/bash

                    echo "Hello from bash"
                    echo "Who I'm $SHELL"
                '''
                echo 'Hello, '
            }
        }


}
}

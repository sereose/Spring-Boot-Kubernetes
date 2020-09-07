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
def registryIp="gcr.io/selfid"

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
        stage ('unit test') {
            steps {
                    sh 'echo "unit test"'
                }
            }
        
        stage ('integration test') {
            steps {
                    sh 'echo "integration test"'
                }
            }

        stage ('build artifact') {
            steps {
                    script {
#                        registryIp = sh(script: 'getent hosts registry.kube-system | awk \'{ print $1 ; exit }\'', returnStdout: true).trim()
                        sh "docker build . -t ${registryIp}/demo-app:${revision} --build-arg REVISION=${revision}"
                    }
                }
            }

}
}

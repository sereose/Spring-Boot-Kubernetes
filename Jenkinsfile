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
                        sh "docker build . -t ${registryIp}/demo-app:${revision} --build-arg REVISION=${revision}"
                    }
                }
            }

       stage ('publish artifact') {
            when {
                expression {
                    branch == 'master' || params.DEPLOY_BRANCH_TO_TST
                }
            }
            steps {
		script {
                    sh "docker push ${registryIp}/demo-app:${revision}"
                }
            }
        }
        stage ('deploy to env') {
            when {
                expression {
                    branch == 'master' || params.DEPLOY_BRANCH_TO_TST
                }
            }
            steps {
                build job: './Deploy', parameters: [
                        [$class: 'StringParameterValue', name: 'GIT_REPO', value: 'Spring-Boot-Kubernetes'],
                        [$class: 'StringParameterValue', name: 'VERSION', value: revision],
                        [$class: 'StringParameterValue', name: 'ENV', value: branch == 'master' ? 'staging' : 'test']
                ], wait: false
            }
        }
    }
}

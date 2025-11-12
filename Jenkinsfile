library(
    identifier: 'jenkins-lib-common@1.1.1',
    retriever: modernSCM([
        $class: 'GitSCMSource',
        remote: 'git@github.com:zextras/jenkins-lib-common.git',
        credentialsId: 'jenkins-integration-with-github-account'
    ])
)

pipeline {
    agent {
        node {
            label 'base'
        }
    }

    environment {
        NETWORK_OPTS = '--network ci_agent'
        ARTIFACTORY_ACCESS=credentials('artifactory-jenkins-gradle-properties-splitted')
    }

    options {
        skipDefaultCheckout()
        buildDiscarder(logRotator(numToKeepStr: '5'))
        timeout(time: 3, unit: 'HOURS')
    }



    stages {
        stage('Setup') {
            steps {
                checkout scm
                script {
                    gitMetadata()
                    properties(defaultPipelineProperties())
                }
            }
        }

        stage('Build deb/rpm') {
            steps {
                echo 'Building deb/rpm packages'
                buildStage([
                    buildFlags: ' -s '
                ])
            }
        }

        stage('Upload artifacts')
        {
            tools {
                jfrog 'jfrog-cli'
            }
            steps {
                uploadStage(
                    packages: yapHelper.getPackageNames()
                )
            }
        }
    }
}

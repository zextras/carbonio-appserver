library(
    identifier: 'jenkins-lib-common@1.5.0',
    retriever: modernSCM([
        $class: 'GitSCMSource',
        remote: 'git@github.com:zextras/jenkins-lib-common.git',
        credentialsId: 'jenkins-integration-with-github-account'
    ])
)

properties(defaultPipelineProperties())

pipeline {
    agent {
        node {
            label 'base'
        }
    }

    environment {
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
                }
            }
        }

        stage('Build deb/rpm') {
            steps {
                echo 'Building deb/rpm packages'
                buildStage(
                    buildFlags: ' -ds ',
                )
            }
        }

        stage('Upload artifacts')
        {
            when {
                expression { return uploadStage.shouldUpload() }
            }
            tools {
                jfrog 'jfrog-cli'
            }
            steps {
                uploadStage(
                    packages: yapHelper.getPackageNames()
                )
            }
        }
        stage('Bump version') {
            steps {
                script {
                    dt2_semanticRelease()
                }
            }
        }
    }
}

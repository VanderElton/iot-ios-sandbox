#!groovy

pipeline {
    agent {label 'maven-slave'}
    stages {
        stage('Build'){
            steps {
                script {
                    docker.image("swift").inside(){
                        dir('iot-ios-sandbox'){
                            sh './gradlew build'
                        }
                    }
                }
            }
        }
        stage('Documentation'){
            agent {label 'nodejs-slave'}
            steps {
                dir('.'){
                    sh 'npm i -g markdown-styles'
                    sh 'generate-md --layout github --input README.md --output doc/'
                    sh 'ls -lh doc/*'
                    archiveArtifacts artifacts: 'doc/**',fingerprint: true
                }
            }
        }
    }
}

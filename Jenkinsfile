#!groovy

pipeline {
    agent {label 'maven-slave'}
    stages {
        stage('Lint'){
            steps {
                script {
                    docker.image("norionomura/swiftlint").inside(){
                        dir('.'){
                            sh 'swiftlint'
                        }
                    }
                }
            }
        }
       /* stage('SonarQube'){
            steps {
                script {
                    dir('iot-ios-sandbox'){
                        sh './gradlew sonarqube'
                    }
                }
            }
        }
        stage('Build'){
            steps {
                script {
                    docker.image("swift").inside(){
                        dir('.'){
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
      */  }
    }
}

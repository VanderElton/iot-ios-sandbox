#!groovy

pipeline {
    agent {label 'maven-slave'}
    stages {
        stage('Reports'){
            publishHTML (target: [
                reportDir: 'Reports'
                reportFiles: 'teste.html'
                reportName: "Test Report"
            ])
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

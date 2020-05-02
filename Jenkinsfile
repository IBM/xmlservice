pipeline {
  agent {
    node {
      label 'ibmi'
    }
  }
  stages {
    stage('configure') {
      steps {
        sh 'python3 ./configure --target-release V7R2M0'
      }
    }
    stage('build') {
      steps {
        sh 'make -j4'
      }
    }
    stage('deploy') {
      when { buildingTag() }
      environment {
        GITHUB_API_TOKEN = credentials('gh-token')
      }
      steps {
        sh 'make savf'
        sh 'python3 -u scripts/gh-release.py'
      }
    }
  }
}

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
      environment {
        GITHUB_API_TOKEN = credentials('5bba0f79-a3ad-4f3a-af8e-2d5e561dbebc')
      }
      steps {
        sh 'make savf'
        sh 'python3 scripts/gh-release.py'
      }
    }
  }
}

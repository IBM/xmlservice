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
  }
}

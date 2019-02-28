pipeline {
  agent {
    node {
      label 'ibmi'
    }
  }
  stages {
    stage('configure') {
      steps {
        sh 'python3 ./configure'
      }
    }
    stage('build') {
      steps {
        sh 'make -j4'
      }
    }
  }
}

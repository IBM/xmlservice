pipeline {
  agent {
    node {
      label 'ibmi'
    }
  }
  stages {
    stage('set ccsid workaround') {
      steps {
        sh 'find src/ -name \\*.rpglesql | xargs setccsid 819'
      }
    }
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

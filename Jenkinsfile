pipeline {
  agent any

  options {
    buildDiscarder(logRotator(numToKeepStr: '10', daysToKeepStr: '60'))
    parallelsAlwaysFailFast()
    disableConcurrentBuilds()
  }

    triggers {
      cron(BRANCH_NAME == 'main' ? 'H 8 * * 6' : '')
    }

  environment {
    REGISTRY = 'git.devmem.ru'
    REGISTRY_URL = "https://${REGISTRY}"
    REGISTRY_CREDS_ID = 'gitea-user'
    IMAGE_OWNER = 'projects'
    IMAGE_BASENAME = 'helm'
    IMAGE_FULLNAME = "${REGISTRY}/${IMAGE_OWNER}/${IMAGE_BASENAME}"
    IMAGE_TAG = 'latest'
    DOCKERFILE = '.docker/Dockerfile'
    LABEL_AUTHORS = 'Ilya Pavlov <piv@devmem.ru>'
    LABEL_TITLE = 'Helm'
    LABEL_DESCRIPTION = 'Helm'
    LABEL_URL = 'https://helm.sh'
    LABEL_CREATED = sh(script: "date '+%Y-%m-%dT%H:%M:%S%:z'", returnStdout: true).toString().trim()
    REVISION = GIT_COMMIT.take(7)
  }

  stages {
    stage('Build image (cache)') {
      when {
        branch 'main'
        not {
          anyOf {
            triggeredBy 'TimerTrigger'
            triggeredBy cause: 'UserIdCause'
            changeRequest()
          }
        }
      }
      steps {
        script {
          buildDockerImage(
            dockerFile: "${DOCKERFILE}",
            tag: "${IMAGE_TAG}",
            context: ".docker",
            useCache: true
          )
        }
      }
    }

    stage('Build image (no cache)') {
      when {
        branch 'main'
        anyOf {
          triggeredBy 'TimerTrigger'
          triggeredBy cause: 'UserIdCause'
        }
      }
      steps {
        script {
          buildDockerImage(
            dockerFile: "${DOCKERFILE}",
            tag: "${IMAGE_TAG}",
            context: ".docker"
          )
        }
      }
    }
  }

  post {
    always {
      emailext(
        to: '$DEFAULT_RECIPIENTS',
        subject: '$DEFAULT_SUBJECT',
        body: '$DEFAULT_CONTENT'
      )
    }
  }
}

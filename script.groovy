def loadAppEnv() {
    appenv = readJSON file: "${env.WORKSPACE}/version.json"
    return appenv
}

def installDependencies() {
    sh 'make setup'
}

def codeFormatting() {
    sh 'make format'
}

def codeLinting() {
    sh 'make lint'
}

def unitTest() {
    sh 'make test'
}

def buildApp() {
    sh "docker build . -t ${env.DOCKER_IMAGE_NAME}"
}

def testApp() {
    sh "docker run -p 5000:5000 --name ${env.DOCKER_CONTR_NAME} -d ${env.DOCKER_IMAGE_NAME}"
}

def pushApp() {
    echo 'Pushing App to Docker Hub...'
}

def deployApp() {
    echo 'Deploying App to Prod...'
}

def cleanEnv() {
    sh 'make clean'
}

return this

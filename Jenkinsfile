def gv

pipeline {
    agent { label 'ubuntu-agent' }

    stages {

        stage('Init') { 
            steps { 
                // Load groove script here
                script { 
                    gv = load "script.groovy"
                }
            }
        }

        stage('Load Env Variables') {
            steps {
                // Use the shared script to load version information from version.json
                script {
                    def appEnv = gv.loadAppEnv()

                    // Set environment variables
                    env.DOCKER_IMAGE_NAME = "${appEnv.dockerUser}/${appEnv.name}:${appEnv.version}.${BUILD_NUMBER}"
                    env.DOCKER_CONTR_NAME = "${appEnv.name}_${appEnv.version}.${BUILD_NUMBER}"
                    env.GIT_REPO_URL = appEnv.gitRepoUrl
                    env.GIT_CREDENTIALS_ID = appEnv.gitCredentialsId
                    env.DOCKER_HUB_REGISTRY_URL = appEnv.dockerHubRegistryUrl
                    env.DOCKER_HUB_CREDENTIALS_ID = appEnv.dockerHubCredentialsId
                    env.ANSIBLE_INVENTORY_PATH = appEnv.ansibleInventoryPath
                    env.ANSIBLE_PLAYBOOK_PATH = appEnv.ansiblePlaybookPath
                }
            }
        }

        stage('Install Dependencies') {
            steps {
                // Install Python and required dependencies
                script {
                    gv.installDependencies()
                }
            }
        }
        stage('Black - Code Formatting') {
            steps {
                // Run Black for code formatting
                script {
                    gv.codeFormatting()
                }
            }
        }

        stage('Flake8 - Code Linting') {
            steps {
                // Run Flake8 for code linting
                script {
                    gv.codeLinting()
                }
            }
        }

        stage('Unit Tests') {
            steps {
                // Run your Python unit tests here
                script {
                    gv.unitTest()
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                // Build the Docker image
                script {
                    gv.buildApp()
                }
            }
        }

        stage('Test Docker Image') {
            steps {
                // Implement your Docker image testing here
                script {
                    gv.testApp()
                }
            }
        }

        stage('Push Image to Docker Hub') {
            steps {
                // Push the Docker image to Docker Hub
                script {
                    gv.pushApp()
                }
            }
        }

        stage('Deploy to Production') {
            steps {
                // Deploy the Docker image to the remote production server using Ansible
                script {
                    gv.deployApp()
                }
            }
        }
    }

    post {
        always {
            // Clean up steps if necessary
            script {
                gv.cleanEnv()
            }
        }
    }
}

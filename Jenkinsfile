pipeline {
    agent{
        label 'maven'
    }
    options {
        timestamps()
    }
    parameters { 
        string(name: 'SERVER', defaultValue: 'bamboohr.techinterviewsuk.com', description: 'IP/DNS of server') 
        }
    stages {
        stage('Checkout scm') {
            steps {
                script {
                    checkout([  
                        $class: 'GitSCM', 
                        branches: [[name: '*/main']], 
                        doGenerateSubmoduleConfigurations: false, 
                        submoduleCfg: [], 
                        userRemoteConfigs: [[credentialsId: 'github-interview-token', url: 'https://github.com/Revanth070896/webserver-deployment.git']]
                    ])
                }
            }
        }

        stage("Deploy") {
            steps {
                withCredentials([sshUserPrivateKey(credentialsId: 'bamboohr-ssh-private-key', keyFileVariable: 'DEPLOY_SSH_KEY',usernameVariable: 'DEPLOY_USERNAME')]) {
                script {
                    sh """
                        scp -i ${DEPLOY_SSH_KEY} src/*  ${DEPLOY_USERNAME}@${SERVER}:/var/www/html/
                        ssh -i ${DEPLOY_SSH_KEY} ${DEPLOY_USERNAME}@${SERVER} "sudo service nginx restart"
                    """
                }
                }
            }
        }
        }
    post {
        always {
            script {
                cleanWs()  
            }
        }
        success{
            slackSend message: "Deployed sample   BUILD URL: ${BUILD_URL}", color: "#439FE0", channel: "#dev-notifications", tokenCredentialId: "slack-global-notifier"
        }
        failure{
            slackSend message: "FAILED: Deployed sample  webserver  BUILD URL: ${BUILD_URL}", color: "#FF0000", channel: "#dev-notifications", tokenCredentialId: "slack-global-notifier"
        }
    }
    }
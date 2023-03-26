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
                        userRemoteConfigs: [[credentialsId: 'github-access-key', url: 'git@github.com:santhu3064/addressbook-tomcat8.git']]
                    ])
                }
            }
        }

        stage("Deploy") {
            steps {
                withCredentials([sshUserPrivateKey(credentialsId: 'bamboohr-ssh-private-key', keyFileVariable: 'DEPLOY_SSH_KEY',usernameVariable: 'DEPLOY_USERNAME')]) {
                script {
                    sh """
                        scp -i src/*  ${DEPLOY_USERNAME}@${ADDRESSBOOK_SERVER}:/var/www/html/
                        ssh -i ${DEPLOY_SSH_KEY} ${DEPLOY_USERNAME}@${ADDRESSBOOK_SERVER} "sudo service nginx restart"
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
            slackSend message: "Addressbook dev deploy  DEPLOY_VERSION=${props.DEV_VERSION} BUILD URL: ${BUILD_URL}", color: "#439FE0", channel: "#dev-notifications", tokenCredentialId: "slack-global-notifier"
        }
        failure{
            slackSend message: "Addressbook dev deploy  DEPLOY_VERSION=${props.DEV_VERSION} BUILD URL: ${BUILD_URL}", color: "#FF0000", channel: "#dev-notifications", tokenCredentialId: "slack-global-notifier"
        }
        fixed{
            slackSend message: "Addressbook dev deploy  DEPLOY_VERSION=${props.DEV_VERSION} BUILD URL: ${BUILD_URL}", color: "#FFFF00", channel: "#dev-notifications", tokenCredentialId: "slack-global-notifier"
        }
    }
    }
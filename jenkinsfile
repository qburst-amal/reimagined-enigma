pipeline {
    agent any
    stages {
        stage('init') {
            steps {
                //checkout([$class: 'GitSCM', branches: [[name: '*/wave-1.5-develop']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: 'sujith', url:'https://github.com/qburst-amal/fr-basket-api.git']]])
                script {
                    sh 'echo "Hello "'
                    TAG_KEY = 'Name'
                    TAG_VAL = 'oms-jenkins'
                    SG_ID = sh (script:"aws ec2 describe-security-groups --filter Name='tag:${TAG_KEY}',Values='${TAG_VAL}' |jq .SecurityGroups[].GroupId", returnStdout: true)
                    SUBNET_ID = sh (script:"aws ec2 describe-subnets --filter Name='tag:${TAG_KEY}',Values='${TAG_VAL}' | jq .Subnets[].SubnetId", returnStdout: true)
                }
            }
        }
    }
}
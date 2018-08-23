pipeline {
    agent any
    stages {
        stage('init') {
            steps {
                script {
                    sh 'echo "Hello "'
                    TAG_KEY = 'Name'
                    TAG_VAL = 'oms-jenkins'
                    sh (script:"aws ec2 describe-security-groups --filter Name='tag:${TAG_KEY}',Values='${TAG_VAL}' |jq .SecurityGroups[].GroupId")
                    SG_ID = sh (script:"aws ec2 describe-security-groups --filter Name='tag:${TAG_KEY}',Values='${TAG_VAL}' |jq .SecurityGroups[].GroupId", returnStdout: true)
                    SUBNET_ID = sh (script:"aws ec2 describe-subnets --filter Name='tag:${TAG_KEY}',Values='${TAG_VAL}' | jq .Subnets[].SubnetId", returnStdout: true)
                    if (!SG_ID?.trim () || !SUBNET_ID?.trim()) {
                        error("Cannot find Security or SubnetId with ${TAG_VAL}")

                    }
                    dir('./build-template/terraform/') {
                        sh 'terraform plan'
                    }
                }
            }
        }
    }
}

pipeline {
    agent any
    environment {
        AWS_ACCOUNT_ID="381492145015"
        AWS_DEFAULT_REGION="US-EAST-1"
        IMAGE_REPO_NAME="ethis_interview_ecs"
        IMAGE_TAG="latest"
        REPOSITORY_URI= "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}"
        // def dockerHome = tool 'docker'
        // env.PATH = "${dockerHome}/bin:${env.PATH}"
    }

    stages {
       
        stage('Logging into AWS ECR') {
            steps {
                    
                script { 
                    sh "/usr/local/bin/aws ecr get-login-password --region us-east-1 | /usr/local/bin/docker login --username AWS --password-stdin 381492145015.dkr.ecr.us-east-1.amazonaws.com"
                }
            }
        }
        // stage('Cloning git') {
        //     steps {
        //         script {
        //             checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'git@github.com:cigbe00/ethis-service.git']])
        //         }
        //     }
        // }
        
        stage ('Building and push image') {
            steps {
                //sh 'chmod +x ./build_push.sh'
                sh '/usr/local/bin/docker build -t $IMAGE_REPO_NAME .'
                sh '/usr/local/bin/docker tag ${IMAGE_REPO_NAME} ${REPOSITORY_URI}:$IMAGE_TAG'
                sh '''
                    /usr/local/bin/aws ecr get-login-password --region us-east-1 | /usr/local/bin/docker login --username AWS --password-stdin 381492145015.dkr.ecr.us-east-1.amazonaws.com
                '''
                //    /usr/local/bin/docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}:${IMAGE_TAG}
                
            }
        }
        // stage ('Pushing to ECR') {
        //     steps {
        //         script{
        //             sh "docker tag ${IMAGE_REPO_NAME} ${REPOSITORY_URI}:$IMAGE_TAG"
        //             sh "docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}:${IMAGE_TAG}"
        //             //docker.withRegistry('https://381492145015.dkr.ecr.us-east-1.amazonaws.com', 'ecr:us-east-1:aws-credentials') {                    
        //             // dockerImage.push("${env.BUILD_NUMBER}")
        //             // dockerImage.push("latest")
        //             //}
        //         }
        //     }
        // }
        stage ('Updating the Deployment File') {
            environment {
                GIT_REPO_NAME = "ethis-service"
                GIT_USER_NAME = "cigbe00"
            }
            steps {
                withCredentials([string(credentialsId: 'ethisphere-token', variable: 'GITHUB_TOKEN')]){
                    sh '''
                    
                        git pull git@github.com:cigbe00/ethis-service.git
                        git config  user.email "cigbe00@gmail.com"
                        git config  user.name "cigbe00"
                        BUILD_NUMBER=${BUILD_NUMBER}
                        oldBuild=`cat Argo/deployment.yml |grep -o 'ethis_interview_ecs.*'`
                        sed -i' ' "s/${oldBuild}/ethis_interview_ecs:${BUILD_NUMBER}/g" Argo/deployment.yml
                        git add Argo/deployment.yml
                        git commit -m "updated the image ${BUILD_NUMBER}"
                        git push @github.com/${GIT_USER_NAME}/${GIT_REPO_NAME">@github.com/${GIT_USER_NAME}/${GIT_REPO_NAME">@github.com/${GIT_USER_NAME}/${GIT_REPO_NAME">https://${GITHUB_TOKEN}@github.com/${GIT_USER_NAME}/${GIT_REPO_NAME} HEAD:main
                        
                    '''
                } //git push https://${GIT_USERNAME}:${encodedPassword}@github.com/${GIT_USERNAME}/cigbe00.git
            }
        }
    }

}

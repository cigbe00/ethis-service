pipeline {
    agent any
    environment {
        AWS_ACCOUNT_ID="381492145015"
        AWS_DEFAULT_REGION="US-EAST-1"
        IMAGE_REPO_NAME="ethis_interview_ecs"
        IMAGE_TAG="latest"
        REPOSITORY_URI= "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}"
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
        
        stage ('Building Image') {
            steps {
                script {
                    dockerImage = '/usr/local/bin/docker.build "${IMAGE_REPO_NAME}:${IMAGE_TAG}"'
                }
            }
        }
        // stage ('Pushing to ECR') {
        //     steps {
        //         script{
        //             /usr/local/bin/docker.withRegistry('https://381492145015.dkr.ecr.us-east-1.amazonaws.com', 'ecr:us-east-1:aws-credentials') {                    
        //             dockerImage.push("${env.BUILD_NUMBER}")
        //             dockerImage.push("latest")
        //             }
        //         }
        //     }
        // }
        // stage ('Updating the Deployment File') {
        //     environment {
        //         GIT_REPO_NAME = "ethis-service"
        //         GIT_USER_NAME = "cigbe00"
        //     }
        //     steps {
        //         withCredentials([string(credentialsId: 'github', variable: 'GITHUB_TOKEN')]){
        //             sh '''
                    
        //                 git pull git@github.com:cigbe00/ethis-service.git
        //                 git config  user.email "cigbe00@gmail.com"
        //                 git config  user.name "cigbe00"
        //                 BUILD_NUMBER=${BUILD_NUMBER}
        //                 sed -i "s/replaceImageTag/${BUILD_NUMBER}/g" ArgoCD/deployments.yml
        //                 git add ArgoCD/deployments.yml
        //                 git commit -m "updated the image ${BUILD_NUMBER}"
        //                 git push @github.com/${GIT_USER_NAME}/${GIT_REPO_NAME">@github.com/${GIT_USER_NAME}/${GIT_REPO_NAME">@github.com/${GIT_USER_NAME}/${GIT_REPO_NAME">https://${GITHUB_TOKEN}@github.com/${GIT_USER_NAME}/${GIT_REPO_NAME} HEAD:main
                        
                       
        //             '''
        //         }
        //     }
        // }
    }

}

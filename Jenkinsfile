pipeline {
    agent any
    environment {
        AWS_ACCOUNT_ID="381492145015"
        AWS_DEFAULT_REGION="us-east-1"
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
        stage("Clone Git Repository") {
            steps {
                git(
                    url: "https://github.com/cigbe00/ethis-service.git",
                    branch: "main",
                    changelog: true,
                    poll: true
                )
            }
        }
        
        stage ('Build Image') {
            steps {
                //sh 'chmod +x ./build_push.sh'
            
                sh '''
                    BUILD_NUMBER=${BUILD_NUMBER}
                    /usr/local/bin/docker build -t $IMAGE_REPO_NAME .
                '''
                  
                
            }
        }
        stage ('Run Unit Tests') {
            steps {
                sh '''
                    /usr/local/bin/docker-compose run --rm web 
                '''
                  
                
            }
        }
        stage ('Push image') {
            steps {
                //sh 'chmod +x ./build_push.sh'
            
                sh '''
                    BUILD_NUMBER=${BUILD_NUMBER}
                    /usr/local/bin/docker tag ${IMAGE_REPO_NAME} ${REPOSITORY_URI}:${BUILD_NUMBER}
                    /usr/local/bin/aws ecr get-login-password --region us-east-1 | /usr/local/bin/docker login --username AWS --password-stdin 381492145015.dkr.ecr.us-east-1.amazonaws.com
                    /usr/local/bin/docker push ${REPOSITORY_URI}:${BUILD_NUMBER}
                '''
                  
                
            }
        }
        stage ('Updating the Deployment File') {
            environment {
                GIT_REPO_NAME = "ethis-service"
                GIT_USER_NAME = "cigbe00"
            }
            steps {
                //withCredentials([string(credentialsId: 'ethisphere-token', variable: 'GITHUB_TOKEN')]){
                withCredentials([gitUsernamePassword(credentialsId: 'ethis-github-token', gitToolName: 'Default')]) {
                    sh '''
                    
                        git pull git@github.com:cigbe00/ethis-service.git
                        git config  user.email "cigbe00@gmail.com"
                        git config  user.name "cigbe00"
                        BUILD_NUMBER=${BUILD_NUMBER}
                        oldBuild=`cat manifest/deployment.yml |grep -o 'ethis_interview_ecs.*'`
                        sed -i' ' "s/${oldBuild}/ethis_interview_ecs:${BUILD_NUMBER}/g" manifest/deployment.yml
                        git add manifest/deployment.yml
                        git commit -m "updated the image ${BUILD_NUMBER}"
                        git push -u origin main
                        
                    '''
                } //git push https://${GIT_USERNAME}:${encodedPassword}@github.com/${GIT_USERNAME}/cigbe00.git
                // git push @github.com/${GIT_USER_NAME}/${GIT_REPO_NAME">@github.com/${GIT_USER_NAME}/${GIT_REPO_NAME">@github.com/${GIT_USER_NAME}/${GIT_REPO_NAME">https://${GITHUB_TOKEN}@github.com/${GIT_USER_NAME}/${GIT_REPO_NAME} HEAD:main
            }
        }
    }

}

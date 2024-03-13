pipeline {
    agent any

    stages {

        stage('Build and Push Image') {
            steps {
                // Build and push nginx image
                dir('nginx') {
                    docker.build('whackerS/nginx-custom:latest')
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub_id') {
                    docker.image('whackerS/nginx-custom:latest').push()
                    }
                }

                // Build and push dvwa image
                dir('dvwa') {
                    docker.build('your-docker-hub-username/dvwa-image:latest')
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub_id') {
                    docker.image('whackerS/dvwa-custom:latest').push()
                    }
                }

            }
        }

        stage('Deploy Services') {
            steps {
                script {
                    // Khởi tạo kết nối SSH
                    sshagent(credentials: ['masterNode']) {
                        // Triển khai dịch vụ nginx
                        sh 'ssh -o StrictHostKeyChecking=no sonngo@10.1.38.190 "docker service create --name nginx --publish published=80,target=80 nginx"'
                        
                        // Triển khai dịch vụ DVWA
                        sh 'ssh -o StrictHostKeyChecking=no sonngo@10.1.38.190 "docker service create --name dvwa --publish published=8080,target=80 vulnerables/web-dvwa"'
                    }
                }
            }
        }
    }
}

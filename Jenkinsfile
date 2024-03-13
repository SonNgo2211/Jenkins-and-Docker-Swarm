pipeline {
    agent any

    stages {

        stage('Build and Push Image') {
            steps {
                script {

                    // Build and push dvwa_db image
                    dir('dvwa_db') {
                        docker.build('whackers/dvwa_db:latest')
                        docker.withRegistry('https://registry.hub.docker.com', 'dockerhub_id') {
                        docker.image('whackers/dvwa_db:latest').push()
                        }
                    }

                    // Build and push dvwa_web image
                    dir('dvwa_web') {
                        docker.build('whackers/dvwa_web:latest')
                        docker.withRegistry('https://registry.hub.docker.com', 'dockerhub_id') {
                        docker.image('whackers/dvwa_web:latest').push()
                        }
                    }

                    // Build and push nginx image
                    dir('nginx') {
                        docker.build('whackers/nginx-custom:latest')
                        docker.withRegistry('https://registry.hub.docker.com', 'dockerhub_id') {
                        docker.image('whackers/nginx-custom:latest').push()
                        }
                    }
                }

            }
        }

        stage('Deploy Services') {
            steps {
                script {
                    // Khởi tạo kết nối SSH
                    sshagent(credentials: ['masterNode']) {
                        
                        sh 'ssh -o StrictHostKeyChecking=no whackers@192.168.1.217 "docker network create --driver overlay web-net"'

                        // Triển khai dịch vụ MariaDB cho DVWA
                        sh 'ssh -o StrictHostKeyChecking=no whackers@192.168.1.217 "docker service create --name dvwa_db --replicas 1 --network web-net --publish published=3306,target=3306 whackers/dvwa_db:latest"'
                        
                        // Triển khai dịch vụ DVWA web
                        sh 'ssh -o StrictHostKeyChecking=no whackers@192.168.1.217 "docker service create --name dvwa_web  --replicas 1 --network web-net --publish published=80,target=80 whackers/dvwa_web:latest"'

                        // Triển khai dịch vụ nginx
                        sh 'ssh -o StrictHostKeyChecking=no whackers@192.168.1.217 "docker service create --name nginx_proxy --replicas 1 --network web-net --publish published=80,target=4321 whackers/nginx-custom:latest"'
                    }
                }
            }
        }
    }
}

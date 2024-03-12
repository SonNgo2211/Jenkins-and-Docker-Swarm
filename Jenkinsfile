pipeline {
    agent any

    stages {
        stage('Deploy Services') {
            steps {
                script {
                    // Khởi tạo kết nối SSH
                    sshagent(credentials: ['masterNode']) {
                        // Triển khai dịch vụ nginx
                        sh 'ssh -o StrictHostKeyChecking=no sonngo@10.1.38.190 "echo Hello world"'
                        
                        // Triển khai dịch vụ DVWA
                        sh 'ssh -o StrictHostKeyChecking=no sonngo@10.1.38.190 "docker service create --name dvwa --publish published=8080,target=80 vulnerables/web-dvwa"'
                    }
                }
            }
        }
    }
}

pipeline {
    agent any

    stages {
        stage('Deploy Services') {
            steps {
                script {
                    // Khởi tạo kết nối SSH
                        // Triển khai dịch vụ nginx
                        sh 'ssh sonngo@10.1.38.190 "docker service create --name nginx --publish published=80,target=80 nginx"'
                        
                        // Triển khai dịch vụ DVWA
                        sh 'ssh sonngo@10.1.38.190 "docker service create --name dvwa --publish published=8080,target=80 vulnerables/web-dvwa"'
                }
            }
        }
    }
}

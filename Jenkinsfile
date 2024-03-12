pipeline {
    agent any

    stages {
        stage('Deploy Services') {
            steps {
             script {
                    // Triển khai dịch vụ nginx
                    docker.image('nginx').run('-d -p 80:80 --name nginx')

                    // Triển khai dịch vụ DVWA
                    docker.image('vulnerables/web-dvwa').run('-d -p 8080:80 --name dvwa')
                }
            }
        }
    }
}

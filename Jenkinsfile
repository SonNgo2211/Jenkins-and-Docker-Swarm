pipeline {
    agent any
    
    stages {
        stage('Deploy Services') {
            steps {
                script {
                    // Triển khai dịch vụ Nginx trên cụm Swarm
                    sh "docker service create --name nginx --replicas 3 --publish published=80,target=80 nginx"
                    
                    // Triển khai dịch vụ DVWA trên cụm Swarm
                    sh "docker service create --name dvwa --replicas 3 --publish published=8080,target=80 vulnerables/web-dvwa"
                }
            }
        }
    }
}
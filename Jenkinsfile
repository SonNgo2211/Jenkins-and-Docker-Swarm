pipeline {
    agent any

    stages {
        stage('Deploy Swarm Master') {
            steps {
                script {
                    // Thực hiện lệnh Docker Swarm Init để khởi tạo node master
                    sh "docker swarm init"
                }
            }
        }

        stage('Get Worker Token') {
            steps {
                script {
                    // Lấy thông tin token cho worker từ node master
                    def workerToken = sh(script: "docker swarm join-token -q worker", returnStdout: true).trim()
                    
                    // Lưu thông tin token vào file để sử dụng sau này
                    writeFile file: 'worker-token.txt', text: "${workerToken}"
                }
            }
        }

        stage('Deploy Swarm Workers') {
            steps {
                script {
                    // Thực hiện lệnh Docker Swarm Join trên mỗi node trong cluster
                    sh "docker swarm join --token $(cat worker-token.txt) $(docker info --format '{{.Swarm.NodeAddr}}'):2377"
                }
            }
        }
    }
}
pipeline {
    agent any

    stages {
        stage('Deploy Swarm Master') {
            steps {
                script {
                    // Địa chỉ IP của node master
                    def masterAddress = '10.1.38.190'
                    
                    // Thực hiện lệnh Docker Swarm Init để khởi tạo node master
                    sh "docker swarm init --advertise-addr ${masterAddress} --listen-addr 0.0.0.0"
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
                    // Thực hiện lệnh Docker Swarm Join trên mỗi node worker
                    sh "docker swarm join --token \$(cat worker-token.txt) ${masterAddress}:2377"
                }
            }
        }
    }
}

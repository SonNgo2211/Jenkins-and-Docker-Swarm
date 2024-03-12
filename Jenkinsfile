pipeline {
    agent any

    stages {
        stage('Deploy Swarm Master') {
            steps {
                script {
                    // Địa chỉ IP của node master
                    def masterAddress = '10.1.38.190'
                    
                    // Thực hiện lệnh Docker Swarm Init để khởi tạo node master
                    sh "docker swarm init --advertise-addr ${masterAddress}"
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
                    // Địa chỉ IP của node worker 1 và node worker 2
                    def worker1Address = '10.1.38.0'
                    def worker2Address = '10.1.36.161'

                    // Đọc token từ file
                    def workerToken = readFile 'worker-token.txt'

                    // Tham gia node worker 1 vào cluster Docker Swarm
                    sh "docker swarm join --token ${workerToken} ${masterAddress}:2377 --advertise-addr ${worker1Address}"

                    // Tham gia node worker 2 vào cluster Docker Swarm
                    sh "docker swarm join --token ${workerToken} ${masterAddress}:2377 --advertise-addr ${worker2Address}"
                }
            }
        }
    }
}

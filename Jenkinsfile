pipeline {
    agent any

    stages {
        stage('Deploy Swarm Workers') {
            steps {
                script {
    
                    // Thực hiện lệnh SSH để lấy địa chỉ IP của máy "dvwa"
                    def ipAddress = sh(script: "ping -c 1 dvwa | grep 'PING' | awk '{print \$3}' | tr -d '()'", returnStdout: true).trim()

                    // Kiểm tra xem có địa chỉ IP nào được trả về không
                    if (ipAddress) {
                        // In ra địa chỉ IP của máy "dvwa"
                        echo "IP Address of DVWA: ${ipAddress}"

                        // Thực hiện lệnh SSH sử dụng địa chỉ IP để deploy dịch vụ
                        sh "ssh ${ipAddress} docker service create --name nginx --publish published=80,target=80 nginx"
                        sh "ssh ${ipAddress} docker service create --name dvwa --publish published=8080,target=80 vulnerables/web-dvwa"
                    } else {
                        // In ra thông báo lỗi nếu không có địa chỉ IP nào được tìm thấy
                        error "Could not retrieve IP address of DVWA"
                    }
                }
            }
        }

        stage('Deploy Services') {
            steps {
                script {
                    // Deploy nginx service
                    sh "docker service create --name nginx --publish published=80,target=80 nginx"

                    // Deploy DVWA service
                    sh "docker service create --name dvwa --publish published=8080,target=80 vulnerables/web-dvwa"
                }
            }
        }
    }
}

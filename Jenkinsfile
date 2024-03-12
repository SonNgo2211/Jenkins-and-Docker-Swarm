pipeline {
    agent any

    stages {
        stage('Deploy Swarm Workers') {
            steps {
                script {
    
                    for (node in Jenkins.instance.nodes) {
                        if (node.computer.isOnline() && node.computer.name != 'master') {
                             // Sử dụng lệnh hostname để lấy danh sách các địa chỉ IP của node
                            def ipAddressList = sh(script: "ssh ${node.getDisplayName()} hostname -I", returnStdout: true).trim()

                            // Chọn một địa chỉ IP cụ thể từ danh sách bằng lệnh awk
                            def ipAddress = sh(script: "echo ${ipAddressList} | awk '{print $1}'", returnStdout: true).trim()


                            // Sử dụng địa chỉ IP để tham gia node vào cluster Swarm
                            sh "ssh ${ipAddress} docker swarm join --token SWMTKN-1-67w6ac8xgln6h6wjvgicpd0bctph9w89dsvjjppz3nipyu5xdn-darph4y5xqdjwyo9q21l2suen 10.1.38.190:2377"
                        }
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

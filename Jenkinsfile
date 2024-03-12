pipeline {
    agent any

    stages {
        stage('Deploy Swarm Workers') {
            steps {
                script {
                    // Lấy danh sách các host slaves của Jenkins
                    def slaves = [:]
                    for (node in Jenkins.instance.nodes) {
                        if (node.computer.isOnline() && node.slaves) {
                            slaves[node.slaves] = {
                                // Thực hiện lệnh Docker Swarm Join trên mỗi host slave
                                sh "ssh ${node.slaves.remoteFS} docker swarm join --token SWMTKN-1-67w6ac8xgln6h6wjvgicpd0bctph9w89dsvjjppz3nipyu5xdn-darph4y5xqdjwyo9q21l2suen 10.1.38.190:2377"
                            }
                        }
                    }
                    parallel slaves
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

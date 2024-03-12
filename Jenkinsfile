pipeline {
    agent any

    stages {
        stage('Deploy Swarm Workers') {
            steps {
                script {
                    // Lấy danh sách các host slaves của Jenkins
                    def slaves = [:]
                    for (node in Jenkins.instance.nodes) {
                        if (node.computer.isOnline() && node.computer.name != 'master') {
                            slaves[node.computer.name] = {
                                // Thực hiện lệnh Docker Swarm Join trên mỗi host slave
                                sh "ssh ${node.computer.name} docker swarm join --token ${workerToken} <master-node-ip>:2377"
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

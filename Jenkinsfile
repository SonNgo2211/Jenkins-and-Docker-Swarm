pipeline {
    agent any

    stages {
        stage('Deploy Swarm Workers') {
            steps {
                script {
    
                    def joinSwarm = { node ->
                        if (node.computer.isOnline() && node.computer.name != 'master') {
                            sh "ssh ${node.computer.host.address} docker swarm join --token SWMTKN-1-67w6ac8xgln6h6wjvgicpd0bctph9w89dsvjjppz3nipyu5xdn-darph4y5xqdjwyo9q21l2suen 10.1.38.190:2377"
                        }
                    }

                    Jenkins.instance.nodes.each { node ->
                        parallel joinSwarm(node)
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

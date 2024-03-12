pipeline {
    agent any

    stages {
        stage('Deploy Swarm Workers') {
            steps {
                script {
    
                    for (node in Jenkins.instance.nodes) {
                        if (node.computer.isOnline()) {
                     // Thực hiện lệnh SSH để lấy địa chỉ IP của node
                            def ipAddress = sh(script: "ssh ${node.getDisplayName()} hostname -I", returnStdout: true).trim()

                            // In ra địa chỉ IP của node
                            echo "IP Address of ${node.getDisplayName()}: ${ipAddress}"
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

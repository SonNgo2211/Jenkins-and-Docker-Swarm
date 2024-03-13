pipeline {
    agent any

    stages {

        stage('Build and Push Image') {
            steps {
                script {

                    // Build and push dvwa_db image
                    dir('dvwa_db') {
                        docker.build('whackers/dvwa_db:latest')
                        docker.withRegistry('https://registry.hub.docker.com', 'dockerhub_id') {
                        docker.image('whackers/dvwa_db:latest').push()
                        }
                    }

                    // Build and push dvwa_web image
                    dir('dvwa_web') {
                        docker.build('whackers/dvwa_web:latest')
                        docker.withRegistry('https://registry.hub.docker.com', 'dockerhub_id') {
                        docker.image('whackers/dvwa_web:latest').push()
                        }
                    }

                    // Build and push nginx image
                    dir('nginx') {
                        docker.build('whackers/nginx-custom:latest')
                        docker.withRegistry('https://registry.hub.docker.com', 'dockerhub_id') {
                        docker.image('whackers/nginx-custom:latest').push()
                        }
                    }
                }

            }
        }

        stage('Deploy Services') {
            steps {
                script {
                    // Khởi tạo kết nối SSH
                    sshagent(credentials: ['masterNode']) {

                        sshExecuteService('dvwa_db', 'whackers/dvwa_db:latest', '3306', '3306', '2')
                        sshExecuteService('dvwa_web', 'whackers/dvwa_web:latest', '8080', '80', '2')
                        sshExecuteService('nginx', 'whackers/nginx-custom:latest', '80', '80', '2')

                    }
                }
            }
        }
    }
}

def sshExecuteService(serviceName, image, sport, dport, replicas) {
    if (isServiceExists(serviceName)) {
        updateService(serviceName, image, sport, dport, replicas)
    } else {
        createService(serviceName, image, sport, dport, replicas)
    }
}

def isServiceExists(serviceName) {
    return sshExecute("docker service ls --format '{{.Name}}' | grep '^${serviceName}\$'", returnStatus: true) == 0
}

def updateService(serviceName, image, sport, dport) {
    sshExecute("docker service update --image ${image} --publish ${sport}:${dport} --replicas ${replicas} ${serviceName}")
}

def createService(serviceName, image, sport, dport) {
    sshExecute("docker service create --name ${serviceName} --publish ${sport}:${dport} --replicas ${replicas} ${image}")
}

def sshExecute(command) {
    return sh(script: "ssh -o StrictHostKeyChecking=no whackers@192.168.1.217 '${command}'", returnStatus: true)
}
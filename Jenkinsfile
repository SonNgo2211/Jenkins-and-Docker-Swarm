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

                    def sshExecute = {command ->
                        return sh(script: "ssh -o StrictHostKeyChecking=no whackers@192.168.1.217 '${command}'", returnStatus: true)
                    }
                    
                    def isServiceExists = {serviceName ->
                        return sshExecute("docker service ls --format '{{.Name}}' | grep '^${serviceName}\$'") == 0
                    }

                    def updateService = {serviceName, image, replicas ->
                        sshExecute("docker service update --image ${image} --replicas ${replicas} ${serviceName}")
                    }

                    def createService = {serviceName, image, sport, dport, replicas, network ->
                        sshExecute("docker service create --name ${serviceName} --network ${network} --publish ${sport}:${dport} --replicas ${replicas} ${image}")
                    }

                    def sshExecuteService = {serviceName, image, sport, dport, replicas, network ->
                        if (isServiceExists(serviceName)) {
                            updateService(serviceName, image, replicas)
                        } else {
                            createService(serviceName, image, sport, dport, replicas, network)
                        }
                    }

                    sshagent(credentials: ['masterNode']) {

                        sshExecuteService('dvwa_db', 'whackers/dvwa_db:latest', '3306', '3306', '1', 'web-net')
                        sshExecuteService('dvwa_web', 'whackers/dvwa_web:latest', '8080', '80', '1', 'web-net')
                        sshExecuteService('nginx', 'whackers/nginx-custom:latest', '80', '4321', '1', 'web-net')

                    }

                }
            }
        }
    }
}

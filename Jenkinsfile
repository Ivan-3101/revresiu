pipeline{
    agent any
          
    environment{
        registryName="drona/springboot"
        registryUrl="drona.azurecr.io"
        registryCredential="ACR"
        dockerImage=""
        
    }
    
    stages{
        stage("Checkout"){
            steps{
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'creds1', url: 'https://gitlab.com/d3649/product-engineering/dronaui/uiserver.git']]])
            }
        }
        stage("package"){
            steps{
                sh 'mvn clean install'
            }
        }
        
        stage("build"){
            steps{
                script{
                   dockerImage=docker.build registryName
                   //sh 'docker build -t ppdronaui .'
                }
            }
        }
        
        stage('Upload Image to ACR') {
            steps{   
                script {
                    docker.withRegistry( "http://${registryUrl}", registryCredential ) {
                    dockerImage.push()
                    }
                }
            }
        }
        stage("K8S Deploy"){
            steps{
                script{
                    kubernetesDeploy(
                        configs:'kubernetes/*.yml',
                        kubeconfigId:'K8S',
                        enableConfigSubstitution:true
                    )
                }
            }
        }
        
    }
}

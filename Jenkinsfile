pipeline {
    agent { label 'Node' }
    triggers {
       pollSCM('* * * * *')
    }
    stages {
        stage('vcs') {
            steps {
                git url: 'https://github.com/March2023Sujata/spc-terraform-acr.git',
                    branch: 'main'
            }
        }
        stage('build') {
            steps {
                sh 'mvn clean install'
            }
        }
        stage('aks') {
            steps {
                 sh 'terraform init'
                 sh 'terraform fmt'
                 sh 'terraform validate'
                 sh 'terraform apply -auto-approve'
                 sh 'mv kubeconfig ~/.kube/config'
            }
        }
        stage('post build')
			{
				steps
				{
					archiveArtifacts artifacts: '**/target/spring-petclinic-3.0.0-SNAPSHOT.jar',
									 onlyIfSuccessful: true
					junit testResults: '**/surefire-reports/TEST-*.xml'                 
				}
			}
        stage('docker') {
            steps {
                sh 'docker image build -t sujatajoshi/spc:latest .'
                sh 'docker image push sujatajoshi/spc:latest'
            }
        }
        stage('deploy') {
            steps {
                sh 'kubectl apply -f .'
                sh 'sleep 10s'
                sh 'kubectl get svc'
            }
        }
    }    
}

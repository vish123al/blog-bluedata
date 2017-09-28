def gitCommit() {
    sh "git rev-parse HEAD > GIT_COMMIT"
    def gitCommit = readFile('GIT_COMMIT').trim()
    sh "rm -f GIT_COMMIT"
    return gitCommit
}

node {
    // Checkout source code from Git
    stage 'Checking out scm for repository'
    checkout scm
    stage '(TEST) unit/integration testing'
    sh 'make test'
    stage '(BUILD) building image'
    sh "docker build -t 10.0.1.86:6555/docker-cicd/nginx:${gitCommit()} ."
    sh "docker login -u admin -p 'password' 10.0.1.86:6555"
    stage '(PUBLISH) Pushing the image '
    sh "docker push 10.0.1.86:6555/docker-cicd/nginx:${gitCommit()}"
     stage '(DEPLOY) Deploying the container'
    marathon(
        url: 'http://10.0.1.85:8080',
        forceUpdate: true,
        filename: 'marathon.json',
        appId: 'blog',
        docker: "10.0.1.86:6555/docker-cicd/nginx:${gitCommit()}".toString()
    )
   
        //stage 'Collect test reports'
      //  step([$class: 'JUnitResultArchiver', testResults: '.xml'])
        stage 'Clean up'
       
                         
   

}

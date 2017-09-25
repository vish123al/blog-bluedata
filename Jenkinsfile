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
    stage 'performing unit/integration test on docker images(push/pull/login/build/integrity)'
    sh 'make test'
    stage 'Building the image with tag'
    sh "docker build -t 10.0.1.86:6555/docker-cicd/nginx:${gitCommit()} ."
    stage 'login to the docker private repository(artifactory)'
    sh "docker login -u admin -p 'password' 10.0.1.86:6555"
    stage 'Publishing the images on private docker repo(artifactory)'
    sh "docker push 10.0.1.86:6555/docker-cicd/nginx:${gitCommit()}"
     stage 'Deploying the container image to the marathon'
    marathon(
        url: 'http://10.0.1.85:8080',
        forceUpdate: true,
        filename: 'marathon.json',
        appId: 'blog',
        docker: "10.0.1.86:6555/docker-cicd/nginx:${gitCommit()}".toString()
    )
}

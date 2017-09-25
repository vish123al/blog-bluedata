def gitCommit() {
    sh "git rev-parse HEAD > GIT_COMMIT"
    def gitCommit = readFile('GIT_COMMIT').trim()
    sh "rm -f GIT_COMMIT"
    return gitCommit
}

node {
    // Checkout source code from Git
    stage 'Checkout'
    checkout scm

    // Build Docker image
    stage 'Build'
    {
    sh "docker login -u admin -p 'password' 10.0.1.86:6555 "
    sh "docker build -t 10.0.1.86:6555/docker-cicd/nginx:${gitCommit()} ."
    }
    // Log in and push image to GitLab
    stage 'Publish'
     {
        sh "docker login -u admin -p 'password' 10.0.1.86:6555 "
        sh "docker push 10.0.1.86:6555/docker-cicd/nginx:${gitCommit()}"
    }

    stage 'Deploy'

    marathon(
        url: 'http://10.0.1.85:8080',
        forceUpdate: true,
        filename: 'marathon.json',
        appId: 'blog',
        docker: "10.0.1.86:6555/docker-cicd/nginx:${gitCommit()}".toString()
    )
}

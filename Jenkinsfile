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
    sh "export DOCKER_OPTS=" --insecure-registry 10.0.1.81:6555" "
    sh "DOCKER_OPTS=" --insecure-registry 10.0.1.81:6555" "
    sh "docker build -t 10.0.1.81:6555/docker-cicd/nginx:${gitCommit()} ."

    // Log in and push image to GitLab
    stage 'Publish'
    withCredentials(
        [[
            $class: 'UsernamePasswordMultiBinding',
            passwordVariable: 'PASSWORD',
            usernameVariable: 'USERNAME'
        ]]
    ) {
        sh "docker login -u 'admin' -p 'password' "
        sh "docker push 10.0.1.81:6555/docker-cicd/nginx:${gitCommit()}"
    }

    stage 'Deploy'

    marathon(
        url: 'http://10.0.1.85:8080',
        forceUpdate: true,
        filename: 'marathon.json',
        appId: 'blog',
        docker: "10.0.1.81:6555/docker-cicd/nginx:${gitCommit()}".toString()
    )
}

test:
        $ "Running tests...kkk"
        @ docker pull 10.0.1.86:6555/docker-cicd/nginx
        $ "Running tests..."
        @ docker build -t 10.0.1.86:6555/docker-cicd/nginx .
        $ "Running tests..."
        @ docker build -t 10.0.1.86:6555/docker-cicd/nginx up test
        $ "progress"
        @ docker cp 10.0.1.86:6555/docker-cicd/nginx ps -q test:/reports/. reports
        $ " check 10.0.1.86:6555/docker-cicd/nginx test

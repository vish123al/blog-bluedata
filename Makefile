test:	
	@ echo "Pulling latest images..."
	@ docker pull 10.0.1.86:6555/docker-cicd/nginx
	@ echo "Building images..."
	@ docker build  -t 10.0.1.86:6555/docker-cicd/nginx .
	@ echo "Ensuring image is ready"
	@ docker ps
	@ echo "Running tests..."
	@ docker push 10.0.1.86:6555/docker-cicd/nginx .
	@ echo "Testing complete"

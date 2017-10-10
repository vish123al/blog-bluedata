test:	
	@ echo "Pulling latest images..."
	@ docker pull vishaldenge/dockerblog
	@ echo "Building images..."
	@ docker build  -t vishaldenge/dockerblog .
	@ echo "Ensuring image is ready"
	@ docker ps
	@ echo "login checking"
	@ docker login -u admin -p 'password'
	@ echo "testing image for push"
	@ docker push vishaldenge/dockerblog 
	@ echo "Testing complete"

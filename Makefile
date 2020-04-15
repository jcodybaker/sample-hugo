
build-image:
	docker build -t hugo-image-build:latest .

push-image: build-image
	docker push hugo-image-build:latest


build-service: build-image
	docker build -t hugo-service --file Dockerfile.run .

run: build-service
	docker run --rm -p 8080:80 hugo-service


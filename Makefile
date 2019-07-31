NAME=mv-go-web
TAG=devshred/$(NAME)
VER=0.1

all: clean build run

build:
	go get github.com/gorilla/mux
	CGO_ENABLED=0 GOOS=linux go build -ldflags "-s" -a -installsuffix cgo -o mv-go-web
	docker build -t $(TAG) -t $(TAG):$(VER) .

run:
	docker run -d -p 8080:8080 --name=$(NAME) $(TAG)

clean:
	-docker stop $(NAME)
	-docker rm $(NAME)

push:
	docker push $(TAG)
	docker push $(TAG):$(VER)
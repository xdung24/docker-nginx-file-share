.PHONY: help
PWD_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

help: ## Show this help message.
	@egrep -h '\s##\s' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

build: ## Build and push to docker hub
	@docker buildx build --platform linux/arm/v6,linux/arm64,linux/amd64 --push --tag xdung24/docker-nginx-file-share:latest .

dev: ## Run in dev 
	@docker build -t xdung24/docker-nginx-file-share:dev -f Dockerfile .
	@docker run --rm -it -v $(PWD_DIR)/data/:/usr/share/nginx/ -p 8084:80 xdung24/docker-nginx-file-share:dev


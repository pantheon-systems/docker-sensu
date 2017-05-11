build: ## build docker containers
	@bash build-images.sh build
	@docker images | grep sensu

push: ## push docker container to registry
	@bash build-images.sh push

help: ## print list of tasks and descriptions
	@grep --no-filename -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?##"}; { printf "\033[36m%-30s\033[0m %s \n", $$1, $$2}'
.DEFAULT_GOAL := help

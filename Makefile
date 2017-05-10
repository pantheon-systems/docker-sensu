# # NOTE: this must match the version of a debian package available from:
# #  http://sensu.global.ssl.fastly.net/apt/pool/jessie/main/s/sensu/
SENSU_VERSION := 0.25.5-1

IMAGE := quay.io/getpantheon/sensu:$(SENSU_VERSION)

build: ## build docker container
	@docker build -t $(IMAGE) --build-arg SENSU_VERSION=$(SENSU_VERSION) .

push: ## push docker container to registry
	@docker push $(IMAGE)

help: ## print list of tasks and descriptions
	@grep --no-filename -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?##"}; { printf "\033[36m%-30s\033[0m %s \n", $$1, $$2}'
.DEFAULT_GOAL := help

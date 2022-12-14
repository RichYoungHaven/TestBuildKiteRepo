SHELL := /bin/bash
#.SILENT:

ifeq "$(BUILDKITE)" "true"
$(info Running with BuildKite)
    BUILD = $(BUILD_NUMBER)
    BRANCH = $(GIT_BRANCH)
else
$(info Running locally - no BuildKite)
    BUILD ="0.0.0"
    BRANCH = "local"
endif

info "Build Number: $(BUILD_NUMBER)"
info "Git Branch: $(BRANCH)"

# build vars, default if not set
IO_COMPOSE = -f docker-compose-io.yml

# terraform configuration
TF_ARTIFACT = $(ENV).$(AWS_DEFAULT_REGION).plan
TF_VARS := -var 'region=$(AWS_DEFAULT_REGION)' \
           -var 'environment=$(ENV)' \
		   -var 'account_id=$(AWS_ACCOUNT_ID)' \
		   -var 'buildnumber=$(BUILD_NUMBER)' \
           -var 'build=$(BUILD)' \
		 -var 'branch=$(BRANCH)' \
		 -var-file=config/$(ENV).$(AWS_DEFAULT_REGION).tfvars \

#export TF_LOG = TRACE

# docker-compose calls
RUN_ALPINE = @docker-compose $(IO_COMPOSE) run --rm alpine
RUN_TF = docker-compose run --rm terraform
CHECKOV = docker-compose run --rm checkov --download-external-modules true


.PHONY: auth
auth: .env
	@echo "Authenticating with Okta..."
	$(RUN_OKTA) awscli sts get-caller-identity

.PHONY: static_analysis
static_analysis: .env init_test
	$(CHECKOV) -d /app


.PHONY: test
test: .env
	$(RUN_TF) init -input=false -backend=false
	$(RUN_TF) validate 

.PHONY: build
build: .env _init
	$(RUN_TF) refresh $(TF_VARS)
	$(RUN_TF) plan $(TF_VARS) -out $(TF_ARTIFACT)

.PHONY: clean
clean:
	echo -e Removing .terraform directory and purging orphaned Docker networks ...
	docker-compose run --entrypoint="rm -rf .terraform" terraform
	docker-compose down --remove-orphans 2>/dev/null

.PHONY: deploy
deploy: .env _init
	$(RUN_TF) apply $(TF_ARTIFACT)

.PHONY: delete
delete: .env _init 	
	$(RUN_TF) destroy -auto-approve $(TF_VARS) 

# Internal Targets
.env: 
	@echo "No .env file found. Create new .env using .env.template"
	$(RUN_ALPINE) cp .env.template .env

.PHONY: shellTF
shellTF: .env
	docker-compose run --entrypoint bash terraform

.PHONY: _init
_init:
	echo -e config/$(ENV).$(AWS_DEFAULT_REGION).backend
	$(RUN_TF) init -backend-config=config/$(ENV).$(AWS_DEFAULT_REGION).backend

.PHONY: init_test
init_test: clean
	echo -e Initialising Terraform with no backend...
	$(RUN_TF) init -input=false -backend=false

# https://www.client9.com/self-documenting-makefiles/
.PHONY: help
help: ## get self documented help for your makefile
	@awk -F ':|##' '/^[^\t].+?:.*?##/ {\
	printf "\033[36m%-30s\033[0m %s\n", $$1, $$NF \
	}' $(MAKEFILE_LIST)
.DEFAULT_GOAL=help
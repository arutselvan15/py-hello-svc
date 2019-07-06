APPNAME=py-hello-svc
PYTHON36=/usr/bin/python3
VENVPATH=/home/arselvan/venvs/py36
PORT=5000

DOCKER_REPO=arutselvan15/${APPNAME}

BUILD=$(or ${BUILD_NUMBER},0)
VERSION=v0.1.${BUILD}
DATE=$(shell date)
HOST=$(shell hostname)

## display this help message
help:
	@echo ''
	@echo 'make targets for the project:'
	@echo
	@echo 'Usage:'
	@echo '  ## Develop / Test Commands ##'
	@echo '  all             Run all the commands.'
	@echo '  clean           Run clean up.'
	@echo '  deps            Run all dependencies that are needed.'
	@echo '  fmt             Run code formatter.'
	@echo '  check           Run static code analysis (lint).'
	@echo '  test            Run tests on project.'
	@echo '  build           Run build to build the project.'
	@echo '  run             Run run on run the binary.'
	@echo '  ### git hub ###'
	@echo '  push            Run push to push changes to git.'
	@echo '  ### docker hub ###'
	@echo '  docker-build    Run docker-build to build the docker image.'
	@echo '  docker-run      Run docker-run on run the app in docker container.'
	@echo '  docker-push     Run docker-push on push the app in docker hug.'
	@echo '  ### setup (one time) ###'
	@echo '  setup          Run setup to do the local setup (one time).'
	@echo '  mk-venv        Run mk-venv to create virtual environment.'
	@echo '  venv           Run venv activate virtualenv.'

all: clean deps fmt check test

clean:
	@echo "==> Cleaning..."
	rm -rf xunit.xml coverage.xml nosetests.xml dist *.egg-info

deps:
	@echo "==> Getting Dependencies..."
	pip install -r requirements.txt
	pip install .

fmt:
	@echo "==> Code Formatting..."

check: fmt
	@echo "==> Code Check..."
	pylint --rcfile=.pylintrc **/*.py

test: clean
	@echo "==> Testing..."
	export PYTHONPATH=$PYTHONPATH:.:./tests
	nose2 --verbose --with-cov --coverage-report term --coverage-report xml

build:
	@echo "==> Build local..."
	echo "Version=${VERSION} Date=${DATE} BuildNode=${HOST}" > version.txt

run:
	@echo "==> Run local..."
	python main.py

push:
	@echo "==> Git Push..."
	git push

docker-build:
	@echo "==> Build Docker Image..."
	docker build -t ${DOCKER_REPO}:${VERSION} .

docker-run:
	@echo "==> Docker Run..."
	docker run -p ${PORT}:${PORT} ${DOCKER_REPO}:${VERSION}

docker-push:
	@echo "==> Docker Push..."
	docker push ${DOCKER_REPO}:${VERSION}

### one time setup ###
setup: mk-venv venv
	pip install -f requirements.txt
	pip install -f test-requirements.txt

mk-venv:
	pip3 install -U pip
	pip3 install virtualenv==15.1.0
	virtualenv --system-site-packages -p ${PYTHON36} ${VENVPATH}

venv:
	source ${VENVPATH}/bin/activate

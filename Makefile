VERSION ?= 0.5.1
OS ?= linux
ARCH ?= amd64
OUTPUT_DIR = dist
IMAGE_NAME ?= quantumghost/alertmanager
SHELL = bash
IMAGE_TAG ?= latest
DOWNLOAD_URL ?= "https://github.com/prometheus/alertmanager/releases/download/v$(VERSION)/alertmanager-$(VERSION).$(OS)-$(ARCH).tar.gz"

.PHONY: help clean _check_env build push

help:
	@echo -e '\nUsage help:\n'
	@echo -e '    make build\n'
	@echo -e 'Variables:'
	@echo -e ' - VERSION: specify the version of alertmanager'
	@echo -e ' - OS: specify which operation system to build for, the default is linux'
	@echo -e ' - ARCH: specify which architecture to build for, the default is amd64'

clean:
	@rm -rf '$(OUTPUT_DIR)'
	@find $(CURDIR) -name 'alertmanager-*.tar.gz' -delete

_check_env:
ifndef VERSION
	$(error VERSION is not set. (the leading 'v' is not needed.))
endif

$(OUTPUT_DIR):
	mkdir '$(OUTPUT_DIR)'

alertmanager-$(VERSION).$(OS)-$(ARCH).tar.gz:
	wget -q $(DOWNLOAD_URL)

build: _check_env alertmanager-$(VERSION).$(OS)-$(ARCH).tar.gz
	rm -rf '$(OUTPUT_DIR)'
	mkdir '$(OUTPUT_DIR)'
	tar --strip-components=1 -xzvf alertmanager-$(VERSION).$(OS)-$(ARCH).tar.gz -C '$(OUTPUT_DIR)'
	docker build -t "$(IMAGE_NAME):$(IMAGE_TAG)" --build-arg ALERTMANAGER_VERSION=$(VERSION) .

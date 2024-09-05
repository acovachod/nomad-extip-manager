DOCKERNAME	:= pruiz/nomad-extip-manager
DOCKERTAG	:= $$(git log -1 --pretty=%h)
DOCKERIMG	:= ${DOCKERNAME}:${DOCKERTAG}
DOCKERARGS	:=
PLATFORM	:= linux/amd64

build:
	@docker build --platform $(PLATFORM) $(DOCKERARGS) -t ${DOCKERIMG} .
	@docker tag ${DOCKERIMG} ${DOCKERNAME}:latest

run:
	@docker run --platform $(PLATFORM) --rm -it -v $(pwd):/workdir -w /workdir ${DOCKERNAME}:latest

push:
	@docker push ${DOCKERNAME}

.PHONY: Makefile ../Makefile.inc

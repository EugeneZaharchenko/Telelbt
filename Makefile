APP := useless_bot
REGISTRY := ghcr.io/eugenezaharchenko
VERSION=$(shell git rev-parse --short HEAD)
targetos=windows
linux: targetos = linux
mac: targetos = darwin
win: targetos = windows
TARGETARCH=arm64

format:
	gofmt -s -w ./

lint:
	golint

test:
	go test -v

get:
	go get

build: format get
	CGO_ENABLED=0 GOOS=${targetos} GOARCH=${TARGETARCH} go build -v -o kbot -ldflags "-X="github.com/EugeneZaharchenko/Telelbt/cmd.appVersion=${VERSION}

linux: build

mac: build

win: build

image:
	docker build . -t ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}  --build-arg TARGETARCH=${TARGETARCH}

push:
	docker push ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}

print:
	echo $(VERSION)

clean:
	rm -rf kbot
	docker rmi ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}

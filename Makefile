VERSION=1.0.1
TARGETOS=Linux

format:
	gofmt -s -w ./

lint:
	golint

test:
	go test -v

build: format

clean:
	rm -rf kbot
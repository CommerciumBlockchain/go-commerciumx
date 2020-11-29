# This Makefile is meant to be used by people that do not usually work
# with Go source code. If you know what GOPATH is then you probably
# don't need to bother with make.

.PHONY: cmmx android ios cmmx-cross swarm evm all test clean
.PHONY: cmmx-linux cmmx-linux-386 cmmx-linux-amd64 cmmx-linux-mips64 cmmx-linux-mips64le
.PHONY: cmmx-linux-arm cmmx-linux-arm-5 cmmx-linux-arm-6 cmmx-linux-arm-7 cmmx-linux-arm64
.PHONY: cmmx-darwin cmmx-darwin-386 cmmx-darwin-amd64
.PHONY: cmmx-windows cmmx-windows-386 cmmx-windows-amd64

GOBIN = $(shell pwd)/build/bin
GO ?= latest

cmmx:
	build/env.sh go run build/ci.go install ./cmd/cmmx
	@echo "Done building."
	@echo "Run \"$(GOBIN)/cmmx\" to launch cmmx."

swarm:
	build/env.sh go run build/ci.go install ./cmd/swarm
	@echo "Done building."
	@echo "Run \"$(GOBIN)/swarm\" to launch swarm."

all:
	build/env.sh go run build/ci.go install

android:
	build/env.sh go run build/ci.go aar --local
	@echo "Done building."
	@echo "Import \"$(GOBIN)/cmmx.aar\" to use the library."

ios:
	build/env.sh go run build/ci.go xcode --local
	@echo "Done building."
	@echo "Import \"$(GOBIN)/CommerciumX.framework\" to use the library."

test: all
	build/env.sh go run build/ci.go test

clean:
	rm -fr build/_workspace/pkg/ $(GOBIN)/*

# The devtools target installs tools required for 'go generate'.
# You need to put $GOBIN (or $GOPATH/bin) in your PATH to use 'go generate'.

devtools:
	env GOBIN= go get -u golang.org/x/tools/cmd/stringer
	env GOBIN= go get -u github.com/jteeuwen/go-bindata/go-bindata
	env GOBIN= go get -u github.com/fjl/gencodec
	env GOBIN= go install ./cmd/abigen

# Cross Compilation Targets (xgo)

cmmx-cross: cmmx-linux cmmx-darwin cmmx-windows cmmx-android cmmx-ios
	@echo "Full cross compilation done:"
	@ls -ld $(GOBIN)/cmmx-*

cmmx-linux: cmmx-linux-386 cmmx-linux-amd64 cmmx-linux-arm cmmx-linux-mips64 cmmx-linux-mips64le
	@echo "Linux cross compilation done:"
	@ls -ld $(GOBIN)/cmmx-linux-*

cmmx-linux-386:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/386 -v ./cmd/cmmx
	@echo "Linux 386 cross compilation done:"
	@ls -ld $(GOBIN)/cmmx-linux-* | grep 386

cmmx-linux-amd64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/amd64 -v ./cmd/cmmx
	@echo "Linux amd64 cross compilation done:"
	@ls -ld $(GOBIN)/cmmx-linux-* | grep amd64

cmmx-linux-arm: cmmx-linux-arm-5 cmmx-linux-arm-6 cmmx-linux-arm-7 cmmx-linux-arm64
	@echo "Linux ARM cross compilation done:"
	@ls -ld $(GOBIN)/cmmx-linux-* | grep arm

cmmx-linux-arm-5:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/arm-5 -v ./cmd/cmmx
	@echo "Linux ARMv5 cross compilation done:"
	@ls -ld $(GOBIN)/cmmx-linux-* | grep arm-5

cmmx-linux-arm-6:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/arm-6 -v ./cmd/cmmx
	@echo "Linux ARMv6 cross compilation done:"
	@ls -ld $(GOBIN)/cmmx-linux-* | grep arm-6

cmmx-linux-arm-7:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/arm-7 -v ./cmd/cmmx
	@echo "Linux ARMv7 cross compilation done:"
	@ls -ld $(GOBIN)/cmmx-linux-* | grep arm-7

cmmx-linux-arm64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/arm64 -v ./cmd/cmmx
	@echo "Linux ARM64 cross compilation done:"
	@ls -ld $(GOBIN)/cmmx-linux-* | grep arm64

cmmx-linux-mips:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/mips --ldflags '-extldflags "-static"' -v ./cmd/cmmx
	@echo "Linux MIPS cross compilation done:"
	@ls -ld $(GOBIN)/cmmx-linux-* | grep mips

cmmx-linux-mipsle:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/mipsle --ldflags '-extldflags "-static"' -v ./cmd/cmmx
	@echo "Linux MIPSle cross compilation done:"
	@ls -ld $(GOBIN)/cmmx-linux-* | grep mipsle

cmmx-linux-mips64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/mips64 --ldflags '-extldflags "-static"' -v ./cmd/cmmx
	@echo "Linux MIPS64 cross compilation done:"
	@ls -ld $(GOBIN)/cmmx-linux-* | grep mips64

cmmx-linux-mips64le:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/mips64le --ldflags '-extldflags "-static"' -v ./cmd/cmmx
	@echo "Linux MIPS64le cross compilation done:"
	@ls -ld $(GOBIN)/cmmx-linux-* | grep mips64le

cmmx-darwin: cmmx-darwin-386 cmmx-darwin-amd64
	@echo "Darwin cross compilation done:"
	@ls -ld $(GOBIN)/cmmx-darwin-*

cmmx-darwin-386:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=darwin/386 -v ./cmd/cmmx
	@echo "Darwin 386 cross compilation done:"
	@ls -ld $(GOBIN)/cmmx-darwin-* | grep 386

cmmx-darwin-amd64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=darwin/amd64 -v ./cmd/cmmx
	@echo "Darwin amd64 cross compilation done:"
	@ls -ld $(GOBIN)/cmmx-darwin-* | grep amd64

cmmx-windows: cmmx-windows-386 cmmx-windows-amd64
	@echo "Windows cross compilation done:"
	@ls -ld $(GOBIN)/cmmx-windows-*

cmmx-windows-386:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=windows/386 -v ./cmd/cmmx
	@echo "Windows 386 cross compilation done:"
	@ls -ld $(GOBIN)/cmmx-windows-* | grep 386

cmmx-windows-amd64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=windows/amd64 -v ./cmd/cmmx
	@echo "Windows amd64 cross compilation done:"
	@ls -ld $(GOBIN)/cmmx-windows-* | grep amd64

.PHONY: build cluster test

default: build

build:
	go build -o bin/swarm    github.com/CommerciumBlockchain/go-CommerciumX/cmd/swarm
	go build -o bin/cmmx-masternode github.com/CommerciumBlockchain/go-CommerciumX/cmd/masternode
	go build -o bin/cmmx-node     github.com/CommerciumBlockchain/go-CommerciumX/cmd/cmmx
	go build -o bin/cmmx-bootnode github.com/CommerciumBlockchain/go-CommerciumX/cmd/bootnode

cluster: build
	scripts/boot-cluster.sh

test:
	go test -v github.com/CommerciumBlockchain/go-CommerciumX/swarm/...

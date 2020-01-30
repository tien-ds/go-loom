PKG = github.com/loomnetwork/go-loom
PROTOC = protoc --plugin=./protoc-gen-gogo -I./vendor -I/usr/local/include

.PHONY: all evm examples get_lint update_lint example-cli evmexample-cli example-plugins example-plugins-external plugins proto test lint clean test-evm lint

all: examples

evm: all example-evm-plugins evmexample-cli

examples: example-plugins example-plugins-external example-cli

example-cli: proto
	go build -o $@ $(PKG)/examples/cli

evmexample-cli: proto
	go build -tags "evm" -o $@ $(PKG)/examples/plugins/evmexample/cli

example-plugins: contracts/helloworld.so.1.0.0 contracts/lottery.so.1.0.0

example-plugins-external: contracts/helloworld.1.0.0

example-evm-plugins: contracts/evmexample.1.0.0 contracts/evmproxy.1.0.0

contracts/helloworld.1.0.0: proto
	go build -o $@ $(PKG)/examples/plugins/helloworld

contracts/helloworld.so.1.0.0: proto
	go build -buildmode=plugin -o $@ $(PKG)/examples/plugins/helloworld

contracts/lottery.so.1.0.0: examples/plugins/lottery/lottery.pb.go
	go build -o $@ $(PKG)/examples/plugins/lottery

contracts/evmexample.1.0.0: proto
	go build -tags "evm" -o $@ $(PKG)/examples/plugins/evmexample/contract

contracts/evmproxy.1.0.0: proto
	go build -tags "evm" -o $@ $(PKG)/examples/plugins/evmproxy/contract

get_lint:
	@echo "--> Installing lint"
	chmod +x get_lint.sh
	./get_lint.sh

update_lint:
	@echo "--> Updating lint"
	./get_lint.sh

lint:
	cd $(GOPATH)/bin && chmod +x golangci-lint
	cd $(GOPATH)/src/github.com/loomnetwork/go-loom
	@golangci-lint run | tee goloomreport

linterrors:
	chmod +x parselintreport.sh
	./parselintreport.sh

protoc-gen-gogo:
	# This is a hack to ensure that github.com/gogo/protobuf/gogoproto/gogo.proto ends up in the
	# vendor dir so that protoc can find it.
	go mod vendor
	go build github.com/gogo/protobuf/protoc-gen-gogo

%.pb.go: %.proto protoc-gen-gogo
	$(PROTOC) --gogo_out=plugins=grpc:./vendor $(PKG)/$<

proto: \
	types/types.pb.go \
	auth/auth.pb.go \
	vm/vm.pb.go \
	plugin/types/types.pb.go \
	builtin/types/address_mapper/address_mapper.pb.go \
	builtin/types/coin/coin.pb.go \
	builtin/types/ethcoin/ethcoin.pb.go \
	builtin/types/dpos/dpos.pb.go \
	builtin/types/dposv2/dposv2.pb.go \
	builtin/types/dposv3/dposv3.pb.go \
	builtin/types/plasma_cash/plasma_cash.pb.go \
	builtin/types/karma/karma.pb.go \
	builtin/types/chainconfig/chainconfig.pb.go \
	builtin/types/deployer_whitelist/deployer_whitelist.pb.go \
	builtin/types/transfer_gateway/transfer_gateway.pb.go \
	builtin/types/transfer_gateway/v1/transfer_gateway.pb.go \
	builtin/types/user_deployer_whitelist/user_deployer_whitelist.pb.go \
	builtin/types/sample_go_contract/sample_go_contract.pb.go \
	testdata/test.pb.go \
	examples/types/types.pb.go \
	examples/plugins/lottery/lottery.pb.go \
	examples/plugins/evmexample/types/types.pb.go \
	examples/plugins/evmproxy/types/types.pb.go

test: proto
	go test -v $(PKG)/...

test-evm: proto
	go test -tags "evm" -v $(PKG)/...

clean:
	go clean
	rm -f \
		vendor \
		protoc-gen-gogo \
		types/types.pb.go \
		auth/auth.pb.go \
		vm/vm.pb.go \
		builtin/types/coin/coin.pb.go \
		builtin/types/ethcoin/ethcoin.pb.go \
		builtin/types/plasma_cash/plasma_cash.pb.go \
		builtin/types/karma/karma.pb.go \
		builtin/types/chainconfig/chainconfig.pb.go \
		builtin/types/deployer_whitelist/deployer_whitelist.pb.go \
		builtin/types/user_deployer_whitelist/user_deployer_whitelist.pb.go \
		builtin/types/sample_go_contract/sample_go_contract.pb.go \
		testdata/test.pb.go \
		examples/types/types.pb.go \
		examples/plugins/evmexample/types/types.pb.go \
		example-cli \
		evmexample-cli \
		builtin/plugins/lottery/lottery.pb.go \
		contracts/helloworld.1.0.0 \
		contracts/helloworld.so.1.0.0 \
		out/cmds/cli \
		contracts/evmexample.1.0.0 \
		contracts/lottery.so.1.0.0 \
		contracts/evmproxy.so.1.0.0 \
		out/cmds/cli

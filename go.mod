module github.com/loomnetwork/go-loom

go 1.14

require (
	github.com/aristanetworks/goarista v0.0.0-20201218012658-e901e4a75e4f // indirect
	github.com/btcsuite/btcd v0.20.1-beta
	github.com/certusone/yubihsm-go v0.1.1-0.20190814054144-892fb9b370f3
	github.com/deckarep/golang-set v1.7.1 // indirect
	github.com/ethereum/go-ethereum v1.8.20
	github.com/go-kit/kit v0.10.0
	github.com/gogo/protobuf v1.3.1
	github.com/gorilla/websocket v1.4.2
	github.com/grpc-ecosystem/go-grpc-prometheus v1.2.0
	github.com/hashicorp/go-plugin v1.3.0
	github.com/hashicorp/yamux v0.0.0-20180604194846-3520598351bb // indirect
	github.com/inconshreveable/mousetrap v1.0.0 // indirect
	github.com/miguelmota/go-solidity-sha3 v0.1.0
	github.com/niemeyer/pretty v0.0.0-20200227124842-a10e7caefd8e // indirect
	github.com/oklog/run v1.0.0 // indirect
	github.com/phonkee/go-pubsub v0.0.0
	github.com/pkg/errors v0.9.1
	github.com/pmezard/go-difflib v1.0.0 // indirect
	github.com/prometheus/client_golang v1.4.1
	github.com/spf13/cobra v1.0.0
	github.com/spf13/pflag v1.0.5
	github.com/stretchr/testify v1.4.0
	github.com/syndtr/goleveldb v1.0.0 // indirect
	golang.org/x/crypto v0.0.0-20200707235045-ab33eee955e0
	golang.org/x/net v0.0.0-20200707034311-ab3426394381
	golang.org/x/sync v0.0.0-20200625203802-6e8e738ad208 // indirect
	google.golang.org/grpc v1.30.0
	gopkg.in/check.v1 v1.0.0-20200227125254-8fa46927fb4f
)

replace github.com/ethereum/go-ethereum v1.8.20 => github.com/loomnetwork/go-ethereum v1.8.17-0.20191122084538-6128fa1a8c76

replace github.com/phonkee/go-pubsub v0.0.0 => github.com/loomnetwork/go-pubsub v0.0.0-20180626134536-2d1454660ed1

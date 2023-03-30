#!/bin/sh

readonly proto_file=$1
readonly go_gen_path=$2

go install google.golang.org/protobuf/cmd/protoc-gen-go@v1.28
go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.2

PB_REL="https://github.com/protocolbuffers/protobuf/releases"
curl -LO $PB_REL/download/v3.15.8/protoc-3.15.8-linux-x86_64.zip
unzip protoc-3.15.8-linux-x86_64.zip -d $HOME/.local
export PATH="$PATH:$HOME/.local/bin"

PATH="$PATH:$(go env GOPATH)/bin"
export PATH

protoc --go_out="$go_gen_path" --go_opt=paths=source_relative \
    --go-grpc_out="$go_gen_path" --go-grpc_opt=paths=source_relative \
    "${proto_file}".proto


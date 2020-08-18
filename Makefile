SOURCES := $(shell find routeguide -name *.proto)
GO_PACKAGE := github.com/toyozaki-a/routeguide-api-go
GO_DIR := $(shell go env GOPATH)/src
GO_OUT := $(patsubst routeguide/%.proto,$(GO_DIR)/$(GO_PACKAGE)/%.pb.go,$(SOURCES))

all: go

go: $(GO_DIR) $(GO_OUT)

$(GO_DIR):
	mkdir -p $@

$(GO_DIR)/$(GO_PACKAGE)/%.pb.go: routeguide/%.proto
	protoc -I . $< --go_out=plugins=grpc:$(GO_DIR)

.PHONY: all go
#!/usr/bin/env bash
cp $1 $1.go # go vet only checks '.go' files
go tool vet $1.go 2>&1 | sed -E "s/vet: .*: (.*):([0-9]+):([0-9]+): (.*)/\1:\2:\3: error: \4/"

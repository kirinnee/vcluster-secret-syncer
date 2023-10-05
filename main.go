package main

import (
	"github.com/kirinnee/vcluster-secret-syncer/syncers"
	"github.com/loft-sh/vcluster-sdk/plugin"
)

func main() {
	ctx := plugin.MustInit()
	plugin.MustRegister(syncers.NewSecretSyncer(ctx))
	plugin.MustStart()
}

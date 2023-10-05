## Secret Syncer VCluster Plugin

This plugin is used to sync desired `secrets` from `host cluster` to `vcluster`. The `secrets` are synced from the namespace when `vcluster` is installed into.

## How to Install Plugin

To use the `plugin`, create or update `vluster` using `plugin.yaml` file. The `plugin.yaml` file is used to configure `vlcuster` to use `Secret Syncer plugin`.

```yaml
plugin:
  secret-syncer:
    image: ghcr.io/kirinnee/vcluster-secret-syncer/secret-syncer-amd:latest # or secret-syncer-arm:latest for arm arch
    imagePullPolicy: IfNotPresent
```

This command will create a `vcluster` named `my-vcluster` in namespace `ssyncer` and will use `Secret Syncer plugin` to sync desired `secrets` from `host cluster` to `vcluster`.

## How to Use Plugin

To sync **any secrets** from `vcluster host namespace` to **any namespace** in `vcluster`, we are using following `annotations` which both are **required**.

```yaml
"secret-upsync.kirinnee.dev/enabled": "true"
"secret-upsync.kirinnee.dev/namespace": "sulfoxide"
```

| Annotation                             | Description                                                   |
| -------------------------------------- | ------------------------------------------------------------- |
| `secret-upsync.kirinnee.dev/enabled`   | Enable sync for this secret                                   |
| `secret-upsync.kirinnee.dev/namespace` | Namespace in `vcluster` that the `secret` should be synced to |

### Example: Syncing Secret to `sulfoxide` Namespace in `vcluster`

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: super-secret
  namespace: sample
  annotations:
    # Enable sync for this secret
    "secret-upsync.kirinnee.dev/enabled": "true"
    # Target the namespace to 'sulfoxide'
    "secret-upsync.kirinnee.dev/namespace": "sulfoxide"
type: Opaque
data:
  username: sample
  password: sample
```

package acmecorp.kubernetes

import data.kubernetes.storageclasses as storage_classes

input = data.examples.pvc.bad

violation["resource is missing required 'app' label"] {
    not input.metadata.labels["app"]
}

violation["pvc not whitelisted to use 'retain' reclaim policy"] {
    input.kind == "PersistentVolumeClaim"
    name := input.spec.storageClassName
    storage_classes[name].spec.reclaimPolicy == "Retain"
    not app_whitelisted_to_retain
}

app_whitelisted_to_retain {
    app := input.metadata.labels["app"]
    reclaim_exceptions[app]
}

reclaim_exceptions = {
    "payments",
    "clickstream",
}

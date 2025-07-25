resource "kubectl_manifest" "jaeger_cutom" {
  yaml_body  = yamlencode(yamldecode(local.value-optl-cert))
  depends_on = [helm_release.jaeger]
}

locals {
  value-optl-cert = <<EOL
---
apiVersion: foo.io/v1

EOL
}

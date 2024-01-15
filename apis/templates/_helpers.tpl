{{- define "common-labels" -}}
haarchri.io/account-name: {{ index .observed.composite.resource.metadata.labels "haarchri.io/account-name" }}
haarchri.io/controlplane-name: {{ index .observed.composite.resource.metadata.labels "haarchri.io/controlplane-name" }}
{{- end }}
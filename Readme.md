
# working inline:

```
crossplane beta render examples/xr.yaml apis/inline_composition.yaml examples/functions.yaml

---
apiVersion: haarchri.io/v1alpha1
kind: XTest
metadata:
  name: test
---
apiVersion: kubernetes.crossplane.io/v1alpha1
kind: Object
metadata:
  annotations:
    crossplane.io/composition-resource-name: test
  generateName: test-
  labels:
    crossplane.io/composite: test
    haarchri.io/account-name: test
    haarchri.io/controlplane-name: test
  ownerReferences:
  - apiVersion: haarchri.io/v1alpha1
    blockOwnerDeletion: true
    controller: true
    kind: XTest
    name: test
    uid: ""
spec:
  forProvider:
    manifest:
      apiVersion: v1
      data:
        test: |
          spec:
            resources: []
      kind: ConfigMap
      metadata:
        labels:
          haarchri.io/account-name: test
          haarchri.io/controlplane-name: test
        name: test-001
        namespace: upbound-system
  providerConfigRef:
    name: default

```

# not working with filesystem source

```
kubectl describe xtest

Events:
  Type     Reason                   Age               From                                                             Message
  ----     ------                   ----              ----                                                             -------
  Normal   CompositionUpdatePolicy  57s               defined/compositeresourcedefinition.apiextensions.crossplane.io  Default composition update policy has been selected
  Normal   SelectComposition        57s               defined/compositeresourcedefinition.apiextensions.crossplane.io  Successfully selected composition: test
  Normal   SelectComposition        57s               defined/compositeresourcedefinition.apiextensions.crossplane.io  Selected composition revision: test-ed16775
  Warning  ComposeResources         0s (x7 over 57s)  defined/compositeresourcedefinition.apiextensions.crossplane.io  cannot compose resources: pipeline step "render-templates" returned a fatal result: invalid function input: cannot parse the provided templates: template: manifests:33: template: multiple definition of template "common-labels"

```
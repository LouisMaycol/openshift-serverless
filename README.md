## Serverless in OpenShift

This is just a test repo. Just playing around with Openshift Serverless

## Steps 

1. Install Openshift Serverless Operator
2. Create Knative Instance (kn-serving.yaml)
3. Check if status is ready 

```
oc get knativeserving.operator.knative.dev/knative-serving -n knative-serving --template='{{range .status.conditions}}{{printf "%s=%s\n" .type .status}}{{end}}'
```

```
oc get pods -n knative-serving
```

4. Check if the networking components are installed

```
oc get pods -n knative-serving-ingress
```
## Serverless in OpenShift

This is just a test repo. Just playing around with Openshift Serverless

## Prerequisite

1. Install Openshift Serverless Operator
2. Create Knative Instance (kn-serving.yaml)
3. Install [knative client](https://knative.dev/docs/install/)
4. Check if status is ready

```
oc get knativeserving.operator.knative.dev/knative-serving -n knative-serving --template='{{range .status.conditions}}{{printf "%s=%s\n" .type .status}}{{end}}'

# Result
DependenciesInstalled=True
DeploymentsAvailable=True
InstallSucceeded=True
Ready=True
VersionMigrationEligible=True
```

```
oc get pods -n knative-serving

NAME                                     READY   STATUS    RESTARTS   AGE
activator-7fd8ff854-8jg5k                2/2     Running   0          42h
activator-7fd8ff854-xxtrx                2/2     Running   0          42h
autoscaler-7ffcc4cbd9-df6dq              2/2     Running   0          42h
autoscaler-7ffcc4cbd9-sgdjd              2/2     Running   0          42h
autoscaler-hpa-78448c6b88-9kk2j          2/2     Running   0          42h
autoscaler-hpa-78448c6b88-srwfh          2/2     Running   0          42h
controller-584dbc598f-787p6              2/2     Running   0          42h
controller-584dbc598f-cmhwp              2/2     Running   0          42h
domain-mapping-676fcdb987-6thf6          2/2     Running   0          42h
domain-mapping-676fcdb987-bdc65          2/2     Running   0          42h
domainmapping-webhook-85db978598-8smgk   2/2     Running   0          42h
domainmapping-webhook-85db978598-c2vc2   2/2     Running   0          42h
webhook-74d85f6dfb-spvpn                 2/2     Running   0          42h
webhook-74d85f6dfb-tnmv6                 2/2     Running   0          42h
```

5. Check if the networking components are installed

```
oc get pods -n knative-serving-ingress

NAME                                      READY   STATUS    RESTARTS   AGE
3scale-kourier-gateway-7dcc8c8d88-48pd6   1/1     Running   0          42h
3scale-kourier-gateway-7dcc8c8d88-dgj64   1/1     Running   0          42h
net-kourier-controller-6bdb7d5fb4-lc2mj   1/1     Running   0          42h
net-kourier-controller-6bdb7d5fb4-lhllt   1/1     Running   0          42h
```

## Steps

1. Build the project

```
docker build -t <username>/<project_name>:<tag> Dockerfile
```

2. Push the image to a registry

```
docker login

docker push image <username>/<project_name>:<tag>
```

3. Update the manifest file **kn-serverless.yaml**, change the image name to `<username>/<project_name>:<tag>`

4. Apply the manifest file

```
oc apply -f kn-serverless.yaml
```

5. Check if the service is running

```
kn service list

NAME              URL                                                                                  LATEST                  AGE   CONDITIONS   READY   REASON
test-serverless   https://test-serverless-test-louis-playground.apps.osdnp.l6a4.p1.openshiftapps.com   test-serverless-00001   14m   3 OK / 3     True
```

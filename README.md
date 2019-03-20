# kubernetes-monitoring

# Install and Configure HELM 
#### Apply the tiller RBAC policy 
$ kubectl apply -f tiller/tiller-rbac.yaml`
#### Initilize tiller on the Kubernetes cluster
$ helm init --service-account tiller`

# Setup Environment
$ export NAMESPACE=monitoring

prometheus

# Deploy Prometheus 
#### Create a namespace 
$ kubectl create ${NAMESPACE}  monitoring`
#### Switch position to namespace monitoring
$ kubectl config set-context $(kubectl config current-context) --namespace=${NAMESPACE} `
#### Apply the prometheus RBAC policy spec
$ kubectl apply -f prometheus/prometheus-rbac.yaml`
#### Apply the prometheus config-map spec
$ kubectl apply -f prometheus/prometheus-config-map.yaml`

#### Deploy the Prometheus application 
$ kubectl apply  -f prometheus/prometheus-deployment.yaml`\
$ kubectl get pods`

## Deploy Grafana
#### Install the grafana Helm chart
$ helm install -n grafana -f grafana/values.yaml stable/grafana

#### Collect and record the secret
$ kubectl get secret --namespace monitoring grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo`

#### Check the status of the service
$ kubectl get svc --namespace=${NAMESPACE}

#### Extract the POD name and forward the Port
$ export POD_NAME=$(kubectl get pods --namespace monitoring -l "app=grafana,release=grafana" -o jsonpath="{.items[0].metadata.name}")
$ kubectl --namespace monitoring port-forward $POD_NAME 3000

#### Open a web browser, navigate to the grafana web UI, and login
$ http://127.0.0.1:3000
=> User Name:* admin
=> Pasword:* <Output from Above>

#### Configure the prometheus plug-in 
Select > *Add data source*
 => Name: *Prometheus*
 => Type: *Prometheus*
 => URL: hhttp://prometheus.monitoring.svc.cluster.local:9090
 => Select > *Save and Test*

#### Import the Kubernetes Dashboard

Select > *"+"* in left pane then *"Import"*

If the app has Internet Access, enter ID **1621** then click outside of the field; otherwise, import the .json file located in the repo.

If no Internet Access, you can upload the .json file. 

In the Options table, select the Prometheus drop-down and select Prometheus 
Select > *Import* 

You will redirect to the new dashboard. 

# Session 02 - EKS Ingress (AWS Load Balancer Controller)

## Objectivo

Desplegar un clúster de Amazon EKS y configurar un Application Load Balancer (ALB) utilizando el AWS Load Balancer Controller con IRSA (IAM Roles for Service Accounts).
Exponer dos aplicaciones backend (nginx y echo/httpd) a través de un único Ingress de Kubernetes con enrutamiento basado en rutas (path-based routing).

## Key Commands Executed

### Creacion de cluster
```bash
eksctl create cluster \
  --name bootcamp-dnunez \
  --region us-east-1 \
  --node-type t3.small \
  --nodes 2 \
  --managed \
  --profile bootcamp
```
### Asociacion de OIDC
```bash

eksctl utils associate-iam-oidc-provider \
  --cluster bootcamp-dnunez \
  --region us-east-1 \
  --approve \
  --profile bootcamp
```

### Creacion de la politica IAM

```bash

aws iam create-policy \
  --policy-name AWSLoadBalancerControllerIAMPolicy-dnunez \
  --policy-document file://iam_policy.json \
  --profile bootcamp
```

### IRSA

```bash

eksctl create iamserviceaccount \
  --cluster bootcamp-dnunez \
  --namespace kube-system \
  --name aws-load-balancer-controller \
  --role-name AmazonEKSLoadBalancerControllerRole-dnunez \
  --attach-policy-arn arn:aws:iam::<ACCOUNT_ID>:policy/AWSLoadBalancerControllerIAMPolicy-dnunez \
  --approve \
  --region us-east-1 \
  --profile bootcamp
```

### Instalacion de Helm

```bash

helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
  --namespace kube-system \
  --set clusterName=bootcamp-dnunez \
  --set serviceAccount.create=false \
  --set serviceAccount.name=aws-load-balancer-controller \
  --set region=us-east-1
```

### Despliegue de aplicaciones

```bash

kubectl create deployment nginx --image=nginx
kubectl expose deployment nginx --port=80

kubectl create deployment echo --image=httpd
kubectl expose deployment echo --port=80
Ingress creation
kubectl apply -f ingress.yaml
```

### Validacion

```bash

ALB=$(kubectl get ingress bootcamp-dnunez -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')

curl -sI http://$ALB/
curl -sI http://$ALB/echo
curl -s http://$ALB/ | head -3
curl -s http://$ALB/echo | head -3
```

### Checkpoints
```md

- [x] Cluster creado correctamente (kubectl get nodes)
- [x] OIDC habilitado (aws eks describe-cluster)
- [x] ServiceAccount con IRSA configurado (kubectl get sa -n kube-system)
- [x] AWS Load Balancer Controller en ejecución (kubectl -n kube-system get pods)
- [x] Ingress creado con ALB (kubectl get ingress)
- [x] Balanceo funcionando:
- [x] / devuelve nginx (HTTP 200)
- [x] /echo devuelve httpd (HTTP 200)

```
Screenshots almacenadas en:

```Text

screenshots/
├── cluster-ready.png
├── oidc-enabled.png
├── ingress-alb.png
├── nginx-response.png
├── echo-response.png

```

### Cleanup Ejecutado
```Text

Eliminado Ingress (se destruye el ALB)
Eliminados Services y Deployments
Desinstalado Helm chart del controller
Eliminado ServiceAccount IRSA
Eliminada policy de IAM
Eliminado cluster EKS
```
#### Comandos de verificación:

```bash 

kubectl get ingress
kubectl get svc
eksctl get cluster --profile bootcamp
```
Resultado esperado: sin recursos

### Reflexión personal

La parte más difícil fue entender cómo se conecta toda la infraestructura entre Kubernetes, IAM, OIDC e IRSA en AWS.
Me costó especialmente entender cómo los permisos viajan desde el ServiceAccount hasta IAM.
Lo más fácil fue desplegar los recursos una vez que los scripts estaban listos.
También fue sencillo ejecutar los comandos de verificación y pruebas con curl.
En general, la dificultad estuvo en la arquitectura, no en la ejecución.

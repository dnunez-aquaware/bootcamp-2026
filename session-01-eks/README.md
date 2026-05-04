# Sesión 01 - Bootcamp EKS

## Objetivo alcanzado
Provisionar un clúster administrado de AWS EKS usando eksctl, desplegar una aplicación nginx, exponerla mediante un servicio LoadBalancer, validar el acceso público y realizar la limpieza completa de todos los recursos en AWS.

## Arquitectura
- Región AWS: us-east-1
- Clúster: bootcamp-dnunez-v2
- Node Group: 2 × t3.small (gestionado)
- Aplicación: nginx (1 réplica)
- Exposición: Servicio Kubernetes tipo LoadBalancer

## Comandos ejecutados

aws sts get-caller-identity --profile bootcamp

eksctl create cluster --name bootcamp-dnunez-v2 --region us-east-1 --managed --node-type t3.small --nodes 2 --profile bootcamp

eksctl get cluster --region us-east-1 --profile bootcamp

kubectl get nodes

kubectl get pods -A

kubectl create deployment nginx --image=nginx

kubectl get deployments

kubectl expose deployment nginx --port=80 --type=LoadBalancer

kubectl get svc nginx

curl http://<external-loadbalancer-dns>

kubectl delete svc nginx

kubectl delete deployment nginx

eksctl delete cluster --name bootcamp-dnunez --region us-east-1 --profile bootcamp

## Evidencia de ejecución
Las capturas de pantalla se encuentran en la carpeta screenshots/ e incluyen:
- Creación del clúster
- Nodos en estado Ready
- Pods ejecutándose
- Servicio LoadBalancer con IP/DNS externo
- Acceso exitoso a nginx desde navegador o curl
- Consola de AWS mostrando creación y eliminación de recursos

## Limpieza realizada
Todos los recursos fueron eliminados correctamente:
- Servicio Kubernetes (nginx)
- Deployment (nginx)
- Clúster EKS
- Node groups
- Load Balancer
- Stacks de CloudFormation

## Reflexión personal
En esta sesión entendí cómo AWS EKS facilita la creación de clústeres de Kubernetes usando eksctl, levantando automáticamente el control plane y los worker nodes donde corren los pods. Pude entender mejor la estructura general del sistema y cómo todo se organiza entre clúster, nodos, pods y contenedores. También comprendí el flujo interno de Kubernetes: el API Server recibe el YAML, guarda el estado, los controllers y scheduler deciden qué se debe crear, y el kubelet junto con containerd ejecutan los pods en los nodos. Aprendí cómo kube-proxy permite la comunicación entre servicios y pods, y la diferencia entre ClusterIP (interno) y LoadBalancer (acceso desde internet en AWS), además del uso de Ingress para dirigir tráfico HTTP. También entendí cómo IAM, OIDC e IRSA controlan la identidad y permisos dentro del clúster. Algo que me pasó es que a veces el clúster parecía quedarse “pegado” y luego noté que podía ser por no tener bien instalado o configurado kubectl. Lo más complicado fue la espera y validar el acceso externo, y entendí la importancia de borrar los recursos cuando ya no se usan para evitar costos.

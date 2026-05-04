# Sesión 01 - Bootcamp EKS

## Objetivo alcanzado
Provisionar un clúster administrado de AWS EKS usando eksctl, desplegar una aplicación nginx, exponerla mediante un servicio LoadBalancer, validar el acceso público y realizar la limpieza completa de todos los recursos en AWS.

## Arquitectura
- Región AWS: us-east-1  
- Clúster: bootcamp-dnunez-v2  
- Node Group: 2 × t3.small   
- Aplicación: nginx   
- Exposición: Servicio Kubernetes tipo LoadBalancer  

## AQUI SE USO IA

```text
Cluster
 ├── Control Plane
 └── Worker Nodes
      └── Pods
           └── Containers

-------WORKER NODE---------
Worker Node
├── Pod A
│   ├── Sandbox A
│   ├── Network namespace A
│   ├── nginx
│   └── logger
│
└── Pod B
    ├── Sandbox B
    ├── Network namespace B
    └── redis
```

## Comandos ejecutados

```bash
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
eksctl delete cluster --name bootcamp-dnunez-v2 --region us-east-1 --profile bootcamp

```

## Evidencia de ejecución

Las capturas de pantalla se encuentran en la carpeta screenshots/ e incluyen:

Creación del clúster EKS
Nodos en estado Ready
Pods ejecutándose correctamente
Servicio LoadBalancer con DNS externo
Acceso exitoso a nginx desde navegador o curl
Consola de AWS mostrando creación y eliminación de recursos
Limpieza ejecutada

Todos los recursos fueron eliminados correctamente:

Servicio Kubernetes (nginx)
Deployment (nginx)
Clúster EKS
Node groups
Load Balancer
Stacks de CloudFormation

## ERRORES

### Error: failed to get shared config profile, bootcamp

Causa: sudo ejecuta el comando como root, el cual no tiene configuración AWS SSO.

Solución: eliminar sudo y ejecutar los scripts como usuario normal.


### Error: failed to get shared config profile, bootcamp

Causa: perfil AWS SSO no configurado o sesión no iniciada.

Solución:

aws configure sso --profile bootcamp
aws sso login --profile bootcamp

###Error: ResourceInUseException / CloudFormation stack in ROLLBACK_COMPLETE state / cluster already exists

Causa:
Se intentó crear el cluster, pero el proceso anterior falló debido a la falta de herramientas instaladas. Esto dejó recursos parcialmente creados en AWS (CloudFormation stacks, VPC, IAM roles). Al reintentar la creación con el mismo nombre, AWS detectó recursos residuales en conflicto.

Solución:
Se identificaron y eliminaron los recursos residuales en AWS antes de volver a ejecutar el cluster

## Checklist de limpieza (EKS)

✔ EKS cluster eliminado
✔ Managed node group eliminado
✔ EC2 instances terminadas
✔ LoadBalancer eliminado
✔ Security Groups eliminados
✔ CloudFormation stacks (eksctl-*) eliminados
✔ EBS volumes eliminados
✔ VPC y subnets eliminadas

Reflexión personal

En esta sesión aprendí cómo AWS EKS automatiza la creación de clústeres de Kubernetes con eksctl. Entendí cómo se organizan los componentes como pods, nodos y servicios. También comprendí el flujo básico del API Server y cómo Kubernetes decide qué ejecutar en el clúster.
Lo más difícil fue esperar la provisión del clúster y validar el acceso externo al LoadBalancer.
También entendí la importancia de limpiar los recursos para evitar costos innecesarios en AWS.




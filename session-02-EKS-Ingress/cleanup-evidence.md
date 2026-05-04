# Evidencia de limpieza - Sesión 02 EKS Ingress

## Acciones realizadas

Durante esta parte final del laboratorio eliminé todos los recursos creados en AWS y Kubernetes para evitar costos y dejar el entorno completamente limpio.

Ejecuté los siguientes comandos en el orden correcto de limpieza:

```bash
kubectl delete ingress bootcamp-dnunez

kubectl delete svc nginx echo
kubectl delete deployment nginx echo

helm uninstall aws-load-balancer-controller -n kube-system

eksctl delete iamserviceaccount \
  --cluster bootcamp-dnunez \
  --namespace kube-system \
  --name aws-load-balancer-controller \
  --region us-east-1 \
  --profile bootcamp

aws iam delete-policy \
  --policy-arn arn:aws:iam::<ACCOUNT_ID>:policy/AWSLoadBalancerControllerIAMPolicy-dnunez \
  --profile bootcamp

eksctl delete cluster \
  --name bootcamp-dnunez \
  --region us-east-1 \
  --profile bootcamp
```
## Verificación de limpieza

Después de la eliminación, validé que todos los recursos hayan sido borrados correctamente con:
```bash

kubectl get ingress
kubectl get svc
kubectl get deploy
kubectl get pods -n kube-system
eksctl get cluster --region us-east-1 --profile bootcamp
aws elbv2 describe-load-balancers --region us-east-1 --profile bootcamp
```
## Resultados
```Text
El Ingress fue eliminado correctamente
Los servicios nginx y echo fueron eliminados
Los deployments fueron eliminados
El AWS Load Balancer Controller fue desinstalado
El IAM ServiceAccount fue eliminado
La política IAM fue eliminada
El clúster EKS ya no existe o no aparece en la lista
```
### Validación en AWS
```Text
También revisé en la consola de AWS y pude confirmar:

No hay clústeres EKS activos
No existen node groups
No hay Load Balancers creados por este laboratorio
No hay políticas IAM del laboratorio activas
No hay ServiceAccounts asociados vía IRSA
```
### Estado final
```md
✔ Todos los recursos fueron eliminados correctamente
✔ No quedaron recursos activos en AWS
✔ El entorno quedó completamente limpio y sin costos adicionales
```

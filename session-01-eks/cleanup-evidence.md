# Evidencia de limpieza - Sesión 01 EKS Bootcamp

## Acciones realizadas
Durante esta parte final del laboratorio eliminé todos los recursos creados en AWS para evitar costos y dejar el entorno limpio.

Ejecuté los siguientes comandos:

kubectl delete svc nginx  
kubectl delete deployment nginx  
eksctl delete cluster --name bootcamp-dnunez-v2 --region us-east-1 --profile bootcamp  

## Verificación de limpieza
Después de la eliminación, validé que todo se haya borrado correctamente con:

eksctl get cluster --region us-east-1 --profile bootcamp  
kubectl get svc  
kubectl get nodes  

## Resultados
- El servicio de nginx ya no existe  
- El deployment fue eliminado correctamente  
- El clúster EKS ya no aparece o está completamente eliminado  
- kubectl ya no tiene un clúster activo al cual conectarse (esto es esperado)

## Validación en AWS
También revisé en la consola de AWS y confirmé que:

- No hay clústeres EKS activos  
- No existen node groups  
- No hay Load Balancers creados por este laboratorio  
- No hay stacks de CloudFormation asociados  

## Estado final
✔ Todo fue eliminado correctamente  
✔ No quedaron recursos activos en AWS  
✔ El entorno quedó completamente limpio y sin costos adicionales

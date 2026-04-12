

# switch to minikube docker environment so that images you build can be available in minikube
eval $(minikube docker-env)

# Install and uninstall ds-chart , run these in aks-ping directory.
helm install ds ./ds-chart
helm uninstall ds ./ds-chart 

# check logs and pods
kubectl get pod  
kubectl logs ds-0

# Detete service and pvc when you unstall ds and want to clean the data and everything.
kubectl delete svc ds
kubectl delete pvc -l app=ds   # optional but recommended

# Bash into the ds pod
kubectl exec -it ds-0  -- /bin/bash 
# check ds init container logs
kubectl logs ds-0 -c ds-init    




keytool -list -v -keystore keystore -storepass "changeit"


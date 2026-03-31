
kubectl create secret generic ds-secrets \
  --from-file=keystore=/path/to/your/folder/keystore \
  --from-file=keystore.pin=/path/to/your/folder/keystore.pin \
  --from-file=admin.pwd=/path/to/your/folder/admin.pwd \
  --from-file=monitor.pwd=/path/to/your/folder/monitor.pwd

  spec:
  template:
    spec:
      containers:
        - name: ds
          # ... other config ...
          volumeMounts:
            - name: secrets-volume
              mountPath: /opt/opendj/secrets
              readOnly: true
      volumes:
        - name: secrets-volume
          secret:
            secretName: ds-secrets # This must match the name in Step 1



helm install ds ./ds-chart
helm uninstall ds ./ds-chart 

kubectl delete svc ds
kubectl delete pvc -l app=ds   # optional but recommended

kubectl exec -it ds-0  -- /bin/bash 
kubectl logs ds-0 -c ds-init    : check init container log


kubectl get pod  
 kubectl logs ds-0


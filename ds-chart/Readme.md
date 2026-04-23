
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


## About the Helm chart

Files directory contains the keystore, keystore.pin, admin.pwd and monitor.pwd.
This files are required for DS.
We map these as secrets to be used by DS.

# Note
keystore should contain ssl certs with dns of kubernetes service so that when you import the ds certficate in AM truststore and DNS matches the DS service.
I created this keystore by running below command on my local ds with hostname=service-name  and copied the keystore and keystore.pin from there.

 ----To generate DS keystore----

  ./setup --serverId                docker \
        --hostname                ds \
        --deploymentId            AZdh16liAw6vpZqcfqQrKl78DSVRjg5CBVN1bkVDMRnYURmIwCA_0_1g \
        --deploymentIdPassword    password \
        --rootUserPassword        password \
        --adminConnectorPort      4444 \
        --ldapPort                1389 \
        --enableStartTls \
        --ldapsPort               1636 \
        --httpPort                8080 \
        --httpsPort               8443 \
        --replicationPort         8989 \
        --rootUserDn              uid=admin \
        --monitorUserDn           uid=monitor \
        --monitorUserPassword     password \
        --acceptLicense   



keytool -list -v -keystore keystore -storepass "changeit"


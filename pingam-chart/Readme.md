# Test

kubectl create secret generic am-secrets \
  --from-file=.storepass \
  --from-file=.keypass \
  --from-file=keystore.jceks


helm install am ./pingam-chart 

helm uninstall am ./pingam-chart 

kubectl logs am-869f7fd658-64b6h -c init-truststore

kubectl exec -it am-5d9c4dbcfd-shrjl -- /bin/bash


Java Home 
/opt/java/openjdk 
/opt/java/openjdk/lib/security/cacerts 
Tomcat
/usr/local/tomcat/
AM config
/home/forgerock/openam
AM truststore
/home/forgerock/openam/security/keystores/truststore


printf "" | openssl s_client -connect {{ .Values.dsCfgConnection }} | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > /home/forgerock/ds-cfg-cert.pem

keytool -importcert -file /home/forgerock/ds-cfg-cert.pem -alias ds-cfg -keystore /home/forgerock/security/truststore -storepass changeit -noprompt 

openssl s_client -connect ds:1636 | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > /home/forgerock/ds-cfg-cert.pem

openssl s_client -connect ds:1636 -showcerts </dev/null | openssl x509 -outform PEM > ds-cert.pem

keytool -importcert -file ds-cert.pem -alias ds-eval -keystore /opt/java/openjdk/lib/security/cacerts -storepass changeit -noprompt 

keytool -list -v -keystore /home/forgerock/openam/security/keystores/truststore

/home/forgerock/openam/security/keystores/truststore

keytool -importcert -file ds-cert.pem -alias ds-eval -keystore /home/forgerock/openam/security/keystores/truststore -storepass changeit -noprompt 


#!/bin/bash 

set -e
export EMAIL="edvillan15@gmail.com"
export OPENAI_API_KEY="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"
export APPNAME="d8-chatai"
export OPENAI_KEY=`echo -n "${OPENAI_API_KEY}" | base64`
kubectl create ns $APPNAME
kubectl create secret generic "${APPNAME}-openai-key" --from-literal=OPENAI_API_KEY=$OPENAI_KEY -n $APPNAME

kubectl apply -f - <<EOF
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: letsencrypt-cluster-issuer
  namespace: cert-manager
spec:
  acme:
    email: edvillan15@gmail.com
    server: https://acme-v02.api.letsencrypt.org/directory
    privateKeySecretRef:
      name: letsencrypt-account-key
    solvers:
    - http01:
        ingress:
          class: nginx
EOF

kubectl get ClusterIssuer letsencrypt-cluster-issuer -o yaml
kubectl describe ClusterIssuer letsencrypt-cluster-issuer

kubectl apply -f - <<EOF
apiVersion: cert-manager.io/v1
kind: Issuer
metadata:
  name: letsencrypt-issuer
  namespace: $APPNAME
spec:
  acme:
    email: edvillan15@gmail.com
    server: https://acme-v02.api.letsencrypt.org/directory
    privateKeySecretRef:
      name: letsencrypt-account-key
    solvers:
      - http01:
          ingress:
            class: nginx
EOF

kubectl get Issuer letsencrypt-issuer -n $APPNAME -o yaml
kubectl describe Issuer letsencrypt-issuer -n $APPNAME

kubectl apply -f - <<EOF
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: $APPNAME-certificate
  namespace: $APPNAME
spec:
  secretName: $APPNAME-tls-secret
  issuerRef:
    name: letsencrypt-issuer
    kind: Issuer
  dnsNames:
    - $APPNAME.7erver.com
EOF

kubectl describe Certificate $APPNAME-certificate -n $APPNAME
kubectl delete Certificate $APPNAME-certificate -n $APPNAME


kubectl apply -f - <<EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  namespace: $APPNAME
  name: $APPNAME
  labels:
    app: $APPNAME
spec:
  replicas: 1
  selector:
    matchLabels:
      app: $APPNAME
  template:
    metadata:
      labels:
        app: $APPNAME
    spec:
      containers:
        - name: $APPNAME
          image: meetlily/$APPNAME:latest
          resources: {}
          ports:
            - containerPort: 3000
          env:
            - name: OPENAI_API_KEY
              valueFrom:
                secretKeyRef:
                  name: "${APPNAME}-openai-key"
                  key: OPENAI_API_KEY
---
kind: Service
apiVersion: v1
metadata:
  namespace: $APPNAME
  name: $APPNAME
  labels:
    app: $APPNAME
spec:
  ports:
    - name: http
      protocol: TCP
      port: 80
      targetPort: 3000
  selector:
    app: $APPNAME
  type: ClusterIP
EOF
kubectl create secret tls $APPNAME-ingress-cert --namespace $APPNAME --key=/Users/evillanueva/certs/ingress-tls.key --cert=/Users/evillanueva/certs/ingress-tls.crt -o yaml
export D8DOMAIN=`echo "${APPNAME}.7erver.com" | perl -ne 'print lc'`
kubectl create ingress "${APPNAME}-ingress" --annotation cert-manager.io/issuer=letsencrypt-issuer --rule "${D8DOMAIN}/*=${APPNAME}:80,tls=${APPNAME}-ingress-cert" --class "nginx" -n ${APPNAME} --dry-run=none

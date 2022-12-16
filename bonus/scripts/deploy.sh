#!/bin/bash

sudo k3d cluster create JRAYE
sudo cat <<- EOF > $HOME/.bashrc && source $HOME/.bashrc
	export KUBECONFIG=$(sudo k3d kubeconfig write JRAYE)
	export CLUSTER=JRAYE
	alias k=kubectl
EOF
sudo chown $(id -u):$(id -g) $KUBECONFIG
kubectl create namespace argocd
kubectl create namespace gitlab
kubectl create namespace dev
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
kubectl apply -n argocd -f ../confs/app.yaml
params="-n argocd -l app.kubernetes.io/name=argocd-server --timeout=10m"
kubectl wait --for=condition=available deployment $params
kubectl wait --for=condition=ready pod $params
sleep 10
pass=$(kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath={.data.password} | base64 --decode)
echo $pass | tee /tmp/argopasswd | sed "s|^|Argocd password: |g"
sleep 10
echo done!

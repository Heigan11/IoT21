sudo k3d cluster create JRAYE

cat <<- EOF > $HOME/.bashrc && source $HOME/.bashrc
	export KUBECONFIG=$(sudo k3d kubeconfig write JRAYE)
	export CLUSTER=JRAYE
	alias k=kubectl
EOF
sudo chown $(id -u):$(id -g) $KUBECONFIG

kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
kubectl apply -n argocd -f ./app.yaml

kubectl wait deployment -n argocd argocd-server --for condition=Available=True --timeout=180s

pass=$(kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath={.data.password} | base64 --decode)
echo $pass | tee /tmp/argopasswd | sed "s|^|Argocd password: |g"

kubectl port-forward svc/argocd-server -n argocd 8080:80  --address=0.0.0.0 &
kubectl port-forward svc/argocd-server -n argocd 8443:443 --address=0.0.0.0 &
kubectl port-forward svc/wil-playground -n dev 8888:8888 --address=0.0.0.0 &

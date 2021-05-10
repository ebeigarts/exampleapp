# Example app

```
docker build -t exampleapp .
docker run -p 3000:3000 -it exampleapp  bin/rails s
```

```
doctl registry login
docker tag exampleapp registry.digitalocean.com/makit-test/exampleapp:1
docker push registry.digitalocean.com/makit-test/exampleapp:1
```

Install ingress-nginx:

```
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm install nginx-ingress ingress-nginx/ingress-nginx --set controller.publishService.enabled=true
```

Generate secrets:

```
kubectl create secret generic exampleapp-secret --from-literal=SECRET_KEY_BASE=$(openssl rand -hex 64)
```

Apply:

```
kubectl delete job/exampleapp-db-migrate
kubectl apply -k kubernetes/production
```

Debug:

```
kubectl exec -it exampleapp-web-deployment-cfbd988c4-8b6h4 ash
```

Logs:

```
kubectl port-forward service/loki-grafana -n loki-stack 8888:80
# Explore -> Loki -> { app="postgres" }
```

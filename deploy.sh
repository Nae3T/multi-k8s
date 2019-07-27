docker build -t naenaenae/multi-client:latest -t naenaenae/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t naenaenae/multi-server:latest -t naenaenae/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t naenaenae/multi-worker:latest -t naenaenae/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push naenaenae/multi-client:latest
docker push naenaenae/multi-server:latest
docker push naenaenae/multi-worker:latest
docker push naenaenae/multi-client:$SHA
docker push naenaenae/multi-server:$SHA
docker push naenaenae/multi-worker:$SHA



kubectl apply -f k8s
kubectl set image deployments/server-deployment server=naenaenae/multi-server:$SHA
kubectl set image deployments/client-deployment client=naenaenae/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=naenaenae/multi-worker:$SHA


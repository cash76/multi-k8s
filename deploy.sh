docker build -t cash76/multi-client:latest -t cash76/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t cash76/multi-server:latest -t cash76/multi-server:$SHA  -f ./server/Dockerfile ./server
docker build -t cash76/multi-worker:latest -t cash76/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push cash76/multi-client:latest
docker push cash76/multi-server:latest
docker push cash76/multi-worker:latest

docker push cash76/multi-client:$SHA
docker push cash76/multi-server:$SHA
docker push cash76/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=cash76/multi-server:$SHA
kubectl set image deployments/client-deployment client=cash76/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=cash76/multi-worker:$SHA
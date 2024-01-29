docker build -t klaudiuszkudla/multi-client:latest -t klaudiuszkudla/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t klaudiuszkudla/multi-server:latest -t klaudiuszkudla/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t klaudiuszkudla/multi-worker:latest -t klaudiuszkudla/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push klaudiuszkudla/multi-client:latest
docker push klaudiuszkudla/multi-server:latest
docker push klaudiuszkudla/multi-worker:latest

docker push klaudiuszkudla/multi-client:$SHA
docker push klaudiuszkudla/multi-server:$SHA
docker push klaudiuszkudla/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=klaudiuszkudla/multi-server:$SHA
kubectl set image deployments/client-deployment client=klaudiuszkudla/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=klaudiuszkudla/multi-worker:$SHA

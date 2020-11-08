docker build -t marouenslaimia/multi-client:latest -t marouenslaimia/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t marouenslaimia/multi-server:latest -t marouenslaimia/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t marouenslaimia/multi-worker:latest -t marouenslaimia/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push marouenslaimia/multi-client:latest
docker push marouenslaimia/multi-server:latest
docker push marouenslaimia/multi-worker:latest

docker push marouenslaimia/multi-client:$SHA
docker push marouenslaimia/multi-server:$SHA
docker push marouenslaimia/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=marouenslaimia/multi-server:$SHA
kubectl set image deployments/client-deployment client=marouenslaimia/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=marouenslaimia/multi-worker:$SHA
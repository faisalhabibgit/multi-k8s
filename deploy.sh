docker build -t faiscodingdocker/multi-client:latest -t faiscodingdocker/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t faiscodingdocker/multi-server:latest -t faiscodingdocker/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t faiscodingdocker/multi-worker:latest -t faiscodingdocker/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push faiscodingdocker/multi-client:latest
docker push faiscodingdocker/multi-server:latest
docker push faiscodingdocker/multi-worker:latest
docker push faiscodingdocker/multi-client:$SHA
docker push faiscodingdocker/multi-server:$SHA
docker push faiscodingdocker/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=faiscodingdocker/multi-server:$SHA
kubectl set image deployments/client-deployment client=faiscodingdocker/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=faiscodingdocker/multi-worker:$SHA
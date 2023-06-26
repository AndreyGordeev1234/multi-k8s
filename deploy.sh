docker build -t proldogy/multi-client:latest -t proldogy/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t proldogy/multi-server:latest -t proldogy/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t proldogy/multi-worker:latest -t proldogy/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push proldogy/multi-client:latest
docker push proldogy/multi-client:$SHA
docker push proldogy/multi-server:latest
docker push proldogy/multi-server:$SHA
docker push proldogy/multi-worker:latest
docker push proldogy/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/client-deployment client=proldogy/multi-client:$SHA
kubectl set image deployments/server-deployment server=proldogy/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=proldogy/multi-worker:$SHA
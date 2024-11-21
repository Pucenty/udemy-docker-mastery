docker network create -d overlay backend
docker network create -d overlay frontend
docker service create --name vote -p 80:80 --network frontend --replicas 2 bretfisher/examplevotingapp_vote
docker service create --name redis --network frontend redis:3.2
docker service create --name worker --network frontend --network backend --mount type=volume,source=db-data,target=/var/lib/postgresql/data bretfisher/examplevotingapp_worker
docker service create --name db --network backend -e POSTGRES_HOST_AUTH_METHOD=trust postgres:9.4
docker service create --name result -p 5001:80 --network backend bretfisher/examplevotingapp_result

[[backend]]
#### Check what using a port:
```bash
sudo lsof -i :5432
```

#### To delete unused docker images and free up space:
``` bash
sudo docker system prune(-a TO DELETE ALL Images)
```

#### run a script in a kafka container
``` shell 
docker exec -it <kafka_container_name_or_id> kafka-console-consumer --bootstrap-server localhost:9092 --topic jeunes --from-beginning
```

#### generate a random secrete key for  authentication:
```shell
openssl rand -base64 32
```
genereate ssh key:

```
ssh-keygeb -t <ALgorithm> - C <Comment>
```
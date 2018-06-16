# hopm-docker

Builds and runs hybrid open proxy monitor inside a docker container

## Building

```
docker build . -t hopm
```

### Transfering to a remote server

```
docker build . -t hopm  && docker save hopm | ssh -C user@remote.net docker load
```

## Running

```
docker run -d \
  --name hopm \
  --restart=unless-stopped \
  -v ircd-data:/hybrid-data \
  --network bridge-irc \
  --ip 192.168.41.2 \
  --ip6 fd00:1:192:168:100::2 \
  hopm:latest
```

### Creating a volume

```
docker volume create ircd-data
```

### Creating a network bridge

```
docker network create \
  --ipv6
  --subnet=fd00:1:192:168:100::0/80 \
  --gateway=fd00:1:192:168:100::1 \
  --subnet=192.168.41.0/24 \
  --gateway=192.168.41.1 \
  bridge-irc
```

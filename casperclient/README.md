# Docker Capser Client

## Build

```bash
 docker build -f casper-client.Dockerfile -t casperclient .
```

## Run

```bash
docker run --network host casperclient get-block --node-address http://localhost:11101
```

### How to debug docker
`docker compose up -d` run docker detached from the terminal

`docker attach image_name` attach the deamon to another terminal

### Common issues
1. When a new gem is added the docker image needs to be rebuilt `docker compose up web -d --build`

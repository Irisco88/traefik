composeFile := "docker-compose.yaml"
composeEnvFile := "compose.env"

# run docker compose up
dcompose-up:
    @echo "run docker compose up"
    docker compose -f {{composeFile}} --env-file {{composeEnvFile}} up -d
    @echo "env variables are:"
    @cat compose.env

# stop docker compose containers
dcompose-stop:
    docker compose -f {{composeFile}} --env-file {{composeEnvFile}} stop

# down and clean all compose file containers
dcompose-clean:
    docker compose -f {{composeFile}} --env-file {{composeEnvFile}} down --volumes --remove-orphans --rmi local

# run docker compose build
dcompose-build:
    @echo "run docker compose build"
    docker compose -f {{composeFile}} --env-file {{composeEnvFile}} build --build-arg GITHUB_TOKEN="$GITHUB_TOKEN"

prod-up:
    @echo "run production images"
    docker compose -f docker-compose.yaml -f compose.prod.yaml --env-file compose.env up -d
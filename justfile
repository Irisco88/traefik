composeFile := "docker-compose.yaml"
composeEnvFile := "compose.env"
composeProduction := "compose.prod.yaml"
composeBuild := "compose.build.yaml"

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

# builds docker images
dcompose-build:
    @echo "build docker compose images"
    docker compose -f {{composeFile}} -f {{composeBuild}} --env-file {{composeEnvFile}} build --build-arg GITHUB_TOKEN="$GITHUB_TOKEN"

# run production images
prod-up:
    @echo "run production images"
    docker compose -f {{composeFile}} -f {{composeProduction}} --env-file {{composeEnvFile}} up -d

# build production images
prod-build:
    @echo "build docker compose production images"
    docker compose -f {{composeFile}} -f {{composeProduction}}  -f {{composeBuild}} --env-file {{composeEnvFile}} build --build-arg GITHUB_TOKEN="$GITHUB_TOKEN"

# build docker images for production
push:prod-build
    @echo "push production images to registry"
    docker compose -f {{composeProduction}} push

# pull production docker images
prod-pull:
    @echo "pull production docker images"
    docker compose -f {{composeFile}} -f {{composeProduction}} --env-file {{composeEnvFile}} pull
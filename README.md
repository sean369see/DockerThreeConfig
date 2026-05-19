# DockerThreeConfig
Configuration Files for Dockerized Three.js Projects (React Three Fiber + Vite)

These files should be placed in the root directory of your three.js project. 
Update node version as necessary in Dockerfile.
Note disabled browser opening (open: false) in vite.config.js

Build and Development CLI commands:

Build the image
```
$ docker compose up --build -d
```

Run the container with hot reload effect
```
$ docker compose up --watch
```

Shut down the container
```
$ docker compose down
```


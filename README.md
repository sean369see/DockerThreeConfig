# DockerThreeConfig
### Configuration Files for Dockerized Three.js Projects (React Three Fiber + Vite) ###

These files should be placed in the root directory of your three.js project containing src, public, etc. folders.  
Update node version as necessary in Dockerfile. 
Note disabled browser opening (open: false) in vite.config.js
Supports dev and build modes. In build mode, built project files will store in docker volume (see /user/src/app/dist). 

---

### Build and Development CLI commands: ###

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


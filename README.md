## Minecraft Server 1.21.4

This repository contains all the files and instructions needed to set up, run, and manage a personal Minecraft server. It includes steps for installation, configuration, running the server, and managing backups. This README provides a quick reference for both new and experienced server administrators.

## Prerequisites 
It is expected that you have Docker Engine installed on your machine.
You should also have a basic knowledge of containerization and the shell.

### Table of contents
  - [Minecraft Server](#minecraft-server) 
  - [Quick start](#quick-start) 
    - [Run the server](#run-the-server)
    - [Build an image and run with Docker](#build-an-image-and-run-with-docker)
    - [Build an image and run with Docker compose](#build-an-image-and-run-with-docker-compose)
- [Usage](#usage)
 - [Testing](#testing)



## Quick start 
This repository can be cloned and already contains all the required configurations to run the server.
```bash
$ git clone https://github.com/vbortnyk/meincraft-server.git
```
#### Run the server
The server can be started directly with a simple command
```bash
$ java -jar mcserver.jar
```

#### Build an image and Run with Docker

Build a docker image
```bash
$ docker build -t <your-image-name> .
```
Start a Docker container with the newly created image
```bash
$ docker run <your-image-name> -d
```
To set a custom port that the server will listen on
```bash
$ docker run -p <host-port>:25565 <your-image-name> -d
```
This maps a port on your host machine to a port inside the container. The server runs inside the Docker container and is accessible via the specified host port. The port `22565` is the default port for Minecraft Server and it is not recommended to change it otherwise this can cause incorrect behavior.




#### Build an image and Run with Docker Compose
Navigate to our project and remame the file `.env-template`. 
This file contains environmenf variables with the default values for  MAX_USERS and DIFFICULTY.

```bash
$ cd minecraft-server
$ rm .env-template .env
```

Then run the following command
```bash
$ docker compose up -d --build
```
This command builds the image and starts the server in a Docker container. It will be accessible via the host port specified in the `compose.yaml` file.

#### Custom Server Configuration
To start the server with a custom configuration, the Docker image may include an entrypoint.sh script that reads environment variables and overrides default server properties such as MAX_PLAYERS or DIFFICULTY.

Additional server settings can be found in the `server.properties` file.



#### Usage
To override default properties, you can pass environment variables when starting the container

Docker
```bash
docker run -e MAX_PLAYERS=10 -e DIFFICULTY=hard <your-image-name> -d
```

Dockre Compose
```bash
MAX_PLAYERS=3 DIFFICULTY=normal docker compose up -d
```
Add `--build` at the end if a new build is required


### Testing
There are two main options for testing:
- Start the game and connect to your server using a Java Minecraft client. 
- Use the Python module: https://github.com/py-mine/mcstatus
     - To use it:
       - Set up a virtual environment
  ```bash
        $ sudo apt update
        $ sudo apt install python3-venv -y
        $ python -m venv <venv-name>
        $ source ~/path/to/project/<venv-name>/bin/activate
    ```
    - Install MCStatus
    ```bash
        $ python3 -m pip install mcstatus
    ```
    - Enable server query

      Open the server.properties file and set:

    ```bash
        enable-query=true
    ```

  - Run tests

  ```bash
        mcstatus <ip.of.your.host> ping #Check server latency/online
        mcstatus <ip.of.your.host> status #Check version, player count
        mcstatus <ip.of.your.host> query #Detailed info if query enabled
        mcstatus <ip.of.your.host> json #Outputs all the server status information in JSON format
    ```

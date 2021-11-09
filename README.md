# POC of creating a shareable docker-compose environment

This project serves as the purpose of showing a POC of how you might be able to share docker-compose files with other projects which depends on a specific project, without having to specify the, maybe complicated, setup of the required service.

## Example

Lets say we have multiple internal services, Service A, Service B and Service C, where Service C depends on Service B which depends on Service A. How do we enable easy development of the different services invidually?

Development of the Service A, which does not depend on the other service is quite easy. This service can internally just define e.g. a `docker-compose.yml` file, which defines all the requires services needed to run this service. This could be a database, redis or any other Docker containers.

However if you wanted to develop on Service B or even Service C, how do you handle the dependency on Service A and Service B?
You could download the whole repository of Service B and Service A in a separate directories, and start the projects individually.

However with this approach you are all of sudden putting a huge burden the developer of Service C to know which services it requires, start each one of them manually everytime development starts up.

## POC

This POC works around the concept of making each individual service responsible for defining all required service and configuration to run, and automatically append these dependencies into the built Docker image. This way all other services that depend on a service is able to easily, without knowledge of the nested tree of required services. 

It works by the `Dockerfile` of each service copies its own service `docker-compose.yml` file into the image, as well as the previous nested services `docker-compose.yml` files. This way we can use the `download.sh` script to download all the nested `docker-compose.yml` files into the `dev-env` folders which is able to be used when we run the `run.sh` script.

### Running

1. Inside the `service-a` directory run: `docker build . -t service-a`
2. Inside the `service-b` directory run: `./download.sh & docker build . -t service-b`
3. Inside the `service-c` directory run: `./download.sh & ./run.sh`
4. Watch that `service-c` has successfully startet all required services along with their nested dependencies, while only defining a single dependency.
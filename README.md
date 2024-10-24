# Java Demo App Pipeline with Jenkins and Docker

This repository contains a Java demo app integrated with a CI/CD pipeline using Jenkins and Docker. The pipeline builds and deploys the application as a Docker container. This README explains the steps taken to modify the project, set up the Jenkins pipeline, and push the image to Docker Hub.

## Table of Contents
1. [Objective](#objective)
2. [Project Structure](#project-structure)
3. [Modification Details](#modification-details)
4. [Jenkins Pipeline](#jenkins-pipeline)
5. [Docker Image Deployment](#docker-image-deployment)
6. [Challenges Faced](#challenges-faced)
7. [How to Run](#how-to-run)
8. [Conclusion](#conclusion)

## Objective
The goal of this project is to build a Jenkins pipeline that:
1. Builds a Docker image of a modified Java application.
2. Pushes the image to Docker Hub.
3. Pulls the image on another agent and runs it.
4. Checks if the application is accessible through a web browser.

## Project Structure
The important files and directories in this project are:
- `views/home.pug`: Contains the front page template.
- `Dockerfile`: Defines the environment to build and run the Java application.
- `Jenkinsfile`: Automates the CI/CD pipeline.
- `README.md`: Provides project documentation (this file).

## Modification Details
To personalize the project, we made the following modifications:
1. **Front Page Update**: We updated the `home.pug` file to display our group code on the application's home page.
   - File: `views/home.pug`
   - Added Code:
     ```pug
     h1 Welcome to Our Group Page!
     p Group Code: GROUP12345
     ```
   This ensures that our group code, `GROUP12345`, is visible when the application is accessed through the browser.

## Jenkins Pipeline
We created a **Declarative Jenkinsfile** that automates the following stages:

1. **Clone Repository**: Clones the application repository from GitHub.
2. **Build Docker Image**: Builds a Docker image using the modified Java application.
3. **Push Image to Docker Hub**: Pushes the Docker image to our Docker Hub repository.
4. **Pull Image on Another Agent**: Pulls the Docker image on a different Jenkins agent.
5. **Run the Image**: Runs the Docker container with the Java application on the agent.
6. **Check Connectivity**: Verifies the application is accessible by performing a `curl` request on the running container.

## Docker Image Deployment
The Docker image is built from the repository and pushed to the following Docker Hub repository:
- **Docker Hub URL**: `https://hub.docker.com/r/your-dockerhub-username/nhorizon-java-container`

The image can be pulled and run using the following command:
```bash
docker pull your-dockerhub-username/nhorizon-java-container:latest
docker run -d -p 8080:8080 your-dockerhub-username/nhorizon-java-container:latest
```
## Challenges Faced

### Docker Build Issues:
Initially, we encountered deprecation warnings related to Docker’s legacy builder. We resolved this by installing BuildKit following Docker’s [buildx documentation](https://docs.docker.com/go/buildx/).

### Docker Push Failures:
Docker login failed due to incorrect password input. We resolved this by correctly configuring the Jenkins credentials and ensuring Docker login was secure.

### Connectivity Check Failure:
The initial pipeline failed the `curl` connectivity check because the container didn’t have enough time to start. We added a 10-second delay using `sleep(10)` to allow the application to initialize properly.

## How to Run

To test the application locally:

1. Clone the repository:
    ```bash
    git clone https://github.com/XP2600-hub/nhorizon-java-container.git
    ```

2. Build and run the Docker image:
    ```bash
    docker build -t local-nhorizon-java-container .
    docker run -d -p 8080:8080 local-nhorizon-java-container
    ```

3. Visit `http://localhost:8080` in your web browser to see the application running with the updated front page showing the group code.

## Conclusion

This project successfully demonstrates the use of Jenkins for continuous integration and Docker for containerization. The pipeline automates the entire build, push, and deploy process, ensuring a seamless workflow from development to deployment.

We have documented all the steps and addressed challenges encountered during the process. The public Docker Hub repository contains the final Docker image, and our Jenkins pipeline is fully functional.

---

Be sure to replace `your-dockerhub-username`, `GROUP12345`, and other placeholder values with your actual project information.

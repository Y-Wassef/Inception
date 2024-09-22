# Inception

**Inception** is a DevOps project developed as part of the 42 School curriculum. It involves designing and deploying a secure, containerized infrastructure using Docker Compose. The project features a WordPress site with a MariaDB database backend, managed by NGINX as a reverse proxy, and secured with SSL/TLS certificates.

## Features

- **Containerization**: Uses Docker and Docker Compose for easy deployment and management of services.
- **Reverse Proxy**: Configured NGINX as a reverse proxy for WordPress.
- **Database**: MariaDB as the database backend for the WordPress site.
- **SSL/TLS**: Ensures secure communication with HTTPS and SSL certificates.
- **Networking**: Implemented isolated Docker networks for enhanced security.
- **Infrastructure as Code**: Managed infrastructure using Docker Compose files.
- **Makefile for Build**: The project is built using a `Makefile` for convenience in running build and setup commands.

## Setup & Installation

1. **Clone the repository**:
   ```
   git clone git@github.com:Y-Wassef/Inception.git
   ```
3. **Navigate to the project directory**:

   ```bash
   cd Inception
   ```

4. **Run the Makefile** to build and set up the environment:

   ```bash
   make
   ```

5. **Access the WordPress site**:

   Visit `https://localhost` in your browser.

## .env File

This project includes an `.env` file that contains sensitive information such as passwords and keys, which is typically bad practice. However, for the purposes of this school project, this has been included for convenience.

## Project Structure

- **srcs/requirements/**: Contains all configuration files and Docker setup.
  - **wordpress/**: WordPress container configuration.
  - **mariadb/**: MariaDB container configuration.
  - **nginx/**: NGINX configuration for reverse proxy.
  - **Dockerfile**: Docker configurations for each service.
- **docker-compose.yml**: Docker Compose file to set up and orchestrate the containers.
- **Makefile**: Used to build and manage the project.

## Requirements

- **Make**: This project uses Makefile to build the containers.
- **Docker**: Ensure Docker is installed on your machine.
- **Docker Compose**: Make sure Docker Compose is available for managing multi-container applications.

## Learning Objectives

This project was built to develop proficiency in:

- Docker containerization and orchestration.
- Setting up NGINX as a reverse proxy.
- Securing web traffic with SSL/TLS.
- Managing infrastructure as code with Docker Compose.
- Networking and inter-container communication.

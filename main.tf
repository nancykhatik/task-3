terraform {
  required_version = ">= 1.5.0"

  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {
  # Uses the local Docker Engine by default.
}

resource "docker_image" "nginx" {
  name         = "nginx:alpine"
  keep_locally = true
}

resource "docker_container" "web" {
  name  = "terraform-nginx-demo"
  image = docker_image.nginx.image_id

  ports {
    internal = 80
    external = 8080
  }

  restart = "unless-stopped"
}

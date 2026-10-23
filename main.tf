
terraform {
required_providers {
docker = {
source = "kreuzwerker/docker"
version = "~> 3.0"
}
}
}
provider "docker" {}

variable "port" {
description = "Port exposé sur la machine"
type = number
default = 8081 
}

resource "docker_image" "nginx" {
name = "nginx:latest"
}

resource "docker_container" "web" {
name = "atelier-iac-web"
image = docker_image.nginx.image_id
ports {
internal = 80
external = var.port
}
volumes {
host_path = abspath("${path.module}/site")
container_path = "/usr/share/nginx/html"
}
}
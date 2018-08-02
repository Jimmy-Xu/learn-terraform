# Configure the Docker provider
provider "docker" {
  host = "tcp://${data.aws_instance.ContainerVM.*.public_ip}:2375/"
}

# Create a container
resource "docker_container" "CNTR" {
  image = "${docker_image.IMG.latest}"
  name  = "foo"
}

resource "docker_image" "IMG" {
  name = "ubuntu:latest"
}
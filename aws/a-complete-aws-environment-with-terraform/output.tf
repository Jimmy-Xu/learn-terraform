output "phpapp_ip" {
  value = "${aws_instance.phpapp.*.public_ip}"
}
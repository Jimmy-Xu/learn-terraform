resource "aws_key_pair" "KEY_PAIR" {
    key_name   = "${var.PROJECT_NAME}-kp"
    public_key = "${file("data/public_key.pem")}"
}
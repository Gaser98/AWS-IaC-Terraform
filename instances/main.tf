resource "aws_instance" "public" {
  count           = 2
  ami             = var.ami_id
  instance_type   = var.instance_type
  subnet_id       = var.public_subnet_id[count.index]
  vpc_security_group_ids = [var.security_group_id]
  associate_public_ip_address = true
  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y nginx
              service nginx start
              sudo unlink /etc/nginx/sites-enabled/default
              sudo sh -c 'echo "server {
                listen 80;
                location / {
                  proxy_pass http://${var.lb_dns};
                }
              }" > /etc/nginx/sites-enabled/proxy.conf'
              service nginx restart
              EOF
}

resource "aws_instance" "private" {
  count           = 2
  ami             = var.ami_id
  instance_type   = var.instance_type
  subnet_id       = var.private_subnet_id[count.index]
  vpc_security_group_ids = [var.security_group_id]
  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y apache2
              service apache2 start
              EOF
}


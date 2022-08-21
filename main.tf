terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

resource "tls_private_key" "pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "kp" {
  key_name   = "myKey"       
  public_key = tls_private_key.pk.public_key_openssh

  provisioner "local-exec" { 
    command = "echo '${tls_private_key.pk.private_key_pem}' > ./myKey.pem"
  }
}

resource "aws_instance" "WebServer" {
  ami           = var.ami
  instance_type = var.instance_type
  
 
  credit_specification {
    cpu_credits = "unlimited"
  }

  connection {
   type     = "ssh"
   user     = "ec2-user"
   private_key = file("./myKey.pem")
   host     = aws_instance.WebServer.public_ip
    }

  provisioner "remote-exec" { 
    inline = [
      "sudo amazon-linux-extras install -y nginx1",
      "sudo systemctl start nginx",
      "sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt",
      "sudo apt-get install unattended-upgrades",
      "sudo dpkg-reconfigure unattended-upgrades", 
      "sudo apt-get -y install yum",
      "sudo yum install https -y",
      "sudo yum install php -y",
      "sudo systemctl start httpd",
      "sudo systemctl start php",
      "cd /var/www/html",
      "sudo wget https://wordpress.org/latest.zip",
      "sudo unzip latest.zip",    
      "sudo chmod -R a=r,u+w,a+X /var/www/html/wordpress/install",
      "sudo curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar",
      "sudo mv wp-cli.phar /usr/local/bin/wp",
      "sudo adduser --system --no-create-home --group wpcli",
      "sudo chown wpcli:wpcli -R /var/www/html/wordpress",
      "sudo chown wpcli:web -R /var/www/html/wordpress/wp-content/uploads",
      "sudo chmod g+rws -R  /var/www/html/wordpress/wp-content/uploads",
      "sudo chmod g+rws -R  /var/www/html/wordpress/wp-content/plugins",
      "cd /var/www/html/wordpress",
      "sudo -u wpcli crontab -e",
      "sudo apt install fail2ban ufw",
      "sudo ufw allow 22",
      "sudo ufw allow 80",
      "sudo ufw allow 443",
       
   ]
  }
}


      





resource "aws_instance" "Seven_Task" {
   ami = "ami-0c6e605ab94c1af57"
   instance_type = "t3.micro"
   key_name = "terraform-key"
}
   connection {
   type     = "ssh"
   user     = "ec2-user"
   private_key = file("./22Seven_Task.pem")
   host     = aws_instance.Seven_Task.public_ip
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



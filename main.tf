resource "aws_instance" "myec2" {
   ami = "ami-0ca285d4c2cda3300"
   instance_type = "t2.micro"
   key_name = "terraform-key"
}
   connection {
   type     = "ssh"
   user     = "ec2-user"
   private_key = file("./terraform-key.pem")
   host     = self.public_ip
    }

provisioner "remote-exec" {
   inline = [
     "sudo yum install http -y",
     "sudo yum install php -y",
     "sudo systemctl start httpd",
     "sudo systemctl start php",
     "cd /var/www/html",
     "sudo wget https://wordpress.org/latest.zip",
     "sudo unzip latest.zip",    
   ]
 }



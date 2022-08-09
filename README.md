Task Instructions:

You are tasked with creating a standalone, configuration managed wordpress website.
This would involve the following:

Installing Wordpress and hosting it behind a webserver such as Apache or Nginx
Hardening the host and Wordpress (see: https://wordpress.org/support/article/hardening-wordpress/)
Automating system and application updates to minimise manual management
Ensuring that the host and application are consistently in a running state, and that changes in state are corrected automatically.
Publically accessible: via public IP or through a load balancer.

Restrictions:
Installation and configuration are to be done through automation tools, SSHing into the host and manually setting it up are not permitted.
This service is to run on an AWS EC2 instance.
Permitted AMIs are baseline AWS Linux or Canonical Ubuntu
HTTPS only - hitting it on HTTP should redirect. A self signed cert is fine in this case.

You do not need to present us with a functional wordpress site directly, just provide the relevant scripts and templates to spin one up.



Public IP: 13.244.231.246

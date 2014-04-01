#Cherdak: Web Performance - Server-side Tips
![Cherdak](../logo.jpg)

##Apache

##Nginx
- Install Nginx:
```shell
apt-get install nginx
```
- open <code>/etc/nginx/nginx.conf</code> with editor
- apply changes from the [nginx.conf](nginx.conf)
- test config
```shell
/etc/init.d/nginx configtest
```
- start or re-start the service
```shell
/etc/init.d/nginx start|restart
```

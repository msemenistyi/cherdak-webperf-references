#Cherdak: Web Performance - Server-side Tips
![Cherdak](../logo.jpg)

##Apache performance tuning

##Nginx performance tuning
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

##Nginx (front-end) + Apache (back-end)

###Configure Nginx and Apache to listen different ports
Nginx:
```shell
listen 80;
```
Apache:
```shell
Listen 127.0.0.1:81
```

###Create virtual hosts with same root folder
Nginx:
```shell
server {
	listen	80;
	server_name	example.com;
	root	/var/www/example.com/;
}
```
Apache:
````shell
<VirtualHost 127.0.0.1:81>
	DocumentRoot "/var/www/example.com/"
	ServerName example.com
</VirtualHost>
```

In this case headers in php scripts in Apache will be changed by Nginx. We can fix it with mod_rpaf module for Apache.

###Last configuration
Nginx:
```shell
server {
	listen  80;
	server_name  example.com;
	location / {
		root  /var/www/example.com/;
		index  index.php;
	}
	location ~ \.php($|\/) {
		proxy_pass  http://127.0.0.1:81;
		proxy_set_header  X-Real-IP  $remote_addr;
		proxy_set_header  Host  $host;
	}
}
```

Apache (mod_rpaf settings):
```shell
RPAFenable On
RPAFproxy_ips 127.0.0.1
RPAFheader X-Real-IP

<VirtualHost 127.0.0.1:81>
	DocumentRoot "/var/www/example.com/"
	ServerName example.com
</VirtualHost>
```

## Benchmark Tools
- [wrk](https://github.com/wg/wrk)
- [ab - Apache HTTP server benchmarking tool](http://httpd.apache.org/docs/2.2/programs/ab.html)
Usage exmple:
```shell
ab -n 25000 -c 50 http://www.example.com/image.png
```
- [Web Page Test](http://www.webpagetest.org/)

## PageSpeed Module
- [module](http://www.modpagespeed.com/)

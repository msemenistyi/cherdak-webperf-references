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

##Nginx performance tuning (light static content): html, css, js, xml, rss, txt
- compress static files:
```shell
for i in `find ./* -type f -name '*.js'`; do echo $i; gzip -c -9 $i > $i.gz; done;
for i in `find ./* -type f -name '*.css'`; do echo $i; gzip -c -9 $i > $i.gz; done;
```
- in nginx config add:
```shell
location /js/ {
	gzip_static on;
	root /var/www/example.com/js
}
```

- turn on online compression for dynamic files
```shell
location / {
	gzip on;
	gzip_min_length 1100;
	gzip_buffers 16 8k;
	gzip_comp_level 3;
	gzip_types text/plain application/xml application/x-javascript text/css;

	root /var/www/example.com/
}
```

- cache file descriptors
```shell
location / {
	root /var/www/;


	open_file_cache max=1024 inactive=600s;
	open_file_cache_valid 2000s;
	open_file_cache_min_uses 1;
	open_file_cache_errors on;
}
```

##Nginx performance tuning (heavy static content): photo, video, audio
- turn off sendfile
```shell
sendfile off;
tcp_nodelay on;
output_buffers 2 64k;
```
- create virtual disc
```shell
location / {
	root /var/www/;
	try_files /img_virtual/hot/$uri storage;
}

location storage {
	proxy_pass http://backend;
	proxy_set_header Host $host;

	proxy_store on;
	proxy_store_access user:rw group:rw all:r;
	proxy_temp_path /var/www/img_virtual/hot/;
	root /var/www/img_virtual/hot/;
}
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
Usage exmple:
```shell
wrk -t 10 -c N -r 10m http://localhost:8080/index.html
```
- [ab - Apache HTTP server benchmarking tool](http://httpd.apache.org/docs/2.2/programs/ab.html)
Usage exmple:
```shell
ab -n 25000 -c 50 http://www.example.com/image.png
```
- [Web Page Test](http://www.webpagetest.org/)

## PageSpeed Module
- [module](http://www.modpagespeed.com/)

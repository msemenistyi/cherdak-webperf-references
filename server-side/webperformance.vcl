backend server1 {
    .host = "10.0.0.11";
}
backend server2 {
    .host = "10.0.0.12";
}

director balanced_servers round-robin {
    {
        .backend = server1;
    }
    {
        .backend = server2;
    }
}

sub vcl_recv {
    /* Указывается backend */
    set req.backend = apache;
 
    /* Non-RFC2616 или CONNECT */
    if (req.request != "GET" &&
        req.request != "HEAD" &&
        req.request != "PUT" &&
        req.request != "POST" &&
        req.request != "TRACE" &&
        req.request != "OPTIONS" &&
        req.request != "DELETE") {
            return (pipe);
    }
 
    /* Нормализация  кодирования */
    if (req.http.Accept-Encoding) {
        if (req.http.Accept-Encoding ~ "gzip") {
            set req.http.Accept-Encoding = "gzip";
        }
        elsif (req.http.Accept-Encoding ~ "deflate") {
            set req.http.Accept-Encoding = "deflate";
        }
        else {
            remove req.http.Accept-Encoding;
        }
    }
      
    /* Удаление куки для статических файлов */
    if (req.url ~ "\.(jpg|jpeg|gif|png|ico|css|txt|js|flv|swf|html|htm)$" || req.url ~ "\?ver=") {
        unset req.http.Cookie;
        return (lookup);
    }
 
    if (req.request == "PURGE") {
        if (!client.ip ~ purge) {
            error 405 "Not allowed.";
        }
        purge("req.url == " req.url " && req.http.host == " req.http.host);
        error 200 "Purged.";
    }

    return (pass);
}

sub vcl_hash {
    set req.hash += req.url;
     
    if (req.http.host) {
        set req.hash += req.http.host;
    }
    else {
        set req.hash += server.ip;
    }
 
    return (hash);
}

sub vcl_hash {
    if (req.url ~ "dynamic.css") {
        set req.hash += req.http.User-Agent
    }
}

sub vcl_fetch {
    /* Удаление куки для статических файлов */
    if (req.url ~ "\.(jpg|jpeg|gif|png|ico|css|txt|js|flv|swf|html|htm)$" || req.url ~ "\?ver=") {
        unset beresp.http.set-cookie;
        set beresp.ttl = 1d;
    }
 
    if (beresp.status == 503) {
        set beresp.grace = 20s;
        restart;
    }
 
    return (deliver);
}

sub vcl_deliver {
    remove resp.http.X-Varnish;
    remove resp.http.X-Powered-By;
}

acl purge {
    "localhost";
    "127.0.0.1";
    "192.168.1.1";
}


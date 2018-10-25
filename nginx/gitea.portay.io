server {
	listen 80;
	server_name portay.io;

	location / {
		proxy_pass http://vps590334.ovh.net:3000/;
	}
}

server {
	listen 443 ssl;
	server_name portay.io;

	ssl_certificate /etc/letsencrypt/live/gitea.portay.io/fullchain.pem;
	ssl_certificate_key /etc/letsencrypt/live/gitea.portay.io/privkey.pem;
	ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
	ssl_ciphers HIGH:!aNULL:!MD5;

	location / {
		proxy_pass http://vps590334.ovh.net:3000/;
	}
}

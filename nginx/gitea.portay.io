server {
	listen 80;
	server_name portay.io;

	location / {
		proxy_pass http://vps590334.ovh.net:3000/;
	}
}

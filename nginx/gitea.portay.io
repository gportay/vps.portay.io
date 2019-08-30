server {
	listen 80;
	server_name portay.io;

	return 301 https://$host$request_uri;
}

server {
	listen 443 ssl;
	server_name portay.io gitea.portay.io;

	ssl_certificate /etc/letsencrypt/live/vps.portay.io-0001/fullchain.pem;
	ssl_certificate_key /etc/letsencrypt/live/vps.portay.io-0001/privkey.pem;
	ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
	ssl_ciphers HIGH:!aNULL:!MD5;
	ssl_client_certificate /etc/nginx/certs/cacert.pem;
	ssl_crl /etc/nginx/certs/crl.pem;
 	ssl_verify_client on;

	location / {
		proxy_pass http://vps218066.vps.ovh.ca:3000/;
	}
}

FROM varnish:stable

# Copier le fichier de configuration Varnish
COPY ./default.vcl /etc/varnish/default.vcl

# Copier le fichier secret dans l'image
COPY ./secret /etc/varnish/secret

# Expose le port 80
EXPOSE 80

# Commande par défaut
CMD ["varnishd", "-F", "-f", "/etc/varnish/default.vcl", "-a", "0.0.0.0:80"]

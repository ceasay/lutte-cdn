# Utiliser l'image officielle de Varnish
FROM varnish:6.6

# Copie de la configuration Varnish
COPY default.vcl /etc/varnish/default.vcl

# Exposer le port Varnish
EXPOSE 80

# Lancer Varnish avec la configuration
CMD ["varnishd", "-F", "-f", "/etc/varnish/default.vcl", "-s", "malloc,256m"]

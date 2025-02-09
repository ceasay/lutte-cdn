#
# This is an example VCL file for Varnish.
#
# It does not do anything by default, delegating control to the
# builtin VCL. The builtin VCL is called when there is no explicit
# return statement.
#
# See the VCL chapters in the Users Guide for a comprehensive documentation
# at https://www.varnish-cache.org/docs/.

# Marker to tell the VCL compiler that this VCL has been written with the
# 4.0 or 4.1 syntax.
vcl 4.1;

# Default backend definition. Set this to point to your content server.
backend default {
    .host = "192.168.1.107";
    .port = "8080";
}

sub vcl_recv {
    # Happens before we check if we have this in cache already.
    #
    # Typically you clean up the request here, removing cookies you don't need,
    # rewriting the request, etc.
}

sub vcl_backend_response {
    if (bereq.url ~ "\.m3u8$" || bereq.url ~ "\.ts$") {
        set beresp.ttl = 1h;  # Les fichiers HLS seront mis en cache pendant 1 heure
        set beresp.grace = 1h; # Période de grâce pendant laquelle Varnish servira les fichiers en cache si le backend est indisponible
    } elsif (bereq.url ~ "\.mp4$") {
        set beresp.ttl = 2h;  # Les fichiers MP4 seront mis en cache pendant 2 heures
        set beresp.grace = 1h; # Période de grâce de 1 heure
    }

    # Happens after we have read the response headers from the backend.
    #
    # Here you clean the response headers, removing silly Set-Cookie headers
    # and other mistakes your backend does.
}

sub vcl_deliver {
    # Happens when we have all the pieces we need, and are about to send the
    # response to the client.
    #
    # You can do accounting or modifying the final object here.
}

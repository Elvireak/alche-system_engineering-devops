# Fixes nginx failing requests under load by raising connection limits.
exec { 'fix--for-nginx':
  command => "/bin/sed -i 's/worker_connections.*/worker_connections 1024;/' /etc/nginx/nginx.conf && /usr/sbin/service nginx restart",
  path    => ['/bin', '/usr/bin', '/usr/sbin'],
}

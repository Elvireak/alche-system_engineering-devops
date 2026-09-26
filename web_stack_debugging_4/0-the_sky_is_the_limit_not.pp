# Raises nginx's open-file limit so it stops failing requests under load
exec { 'raise-worker-rlimit':
  command => 'sed -i "/worker_processes/a worker_rlimit_nofile 8192;" /etc/nginx/nginx.conf',
  path    => '/usr/bin:/bin',
}

exec { 'stop-nginx':
  command => 'service nginx stop',
  path    => '/usr/sbin:/usr/bin:/sbin:/bin',
  require => Exec['raise-worker-rlimit'],
}

exec { 'start-nginx-raised-limit':
  command => '/bin/bash -c "ulimit -n 8192 && nginx"',
  path    => '/usr/sbin:/usr/bin:/sbin:/bin',
  require => Exec['stop-nginx'],
}

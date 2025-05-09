# rabbitmq.conf

## DEFAULT SETTINGS ARE NOT MEANT TO BE TAKEN STRAIGHT INTO PRODUCTION
## see https://www.rabbitmq.com/configure.html for further information
## on configuring RabbitMQ

## allow access to the guest user from anywhere on the network
## https://www.rabbitmq.com/access-control.html#loopback-users
## https://www.rabbitmq.com/production-checklist.html#users
loopback_users.guest = false

## Send all logs to stdout/TTY. Necessary to see logs when running via
## a container
log.console = false
log.console.level = info

log.file = /var/lib/rabbitmq/log/rabbit.log
log.file.level = info

# rotate when the file reaches 10 MiB
log.file.rotation.size = 10485760

# keep up to 5 archived log files in addition to the current one
log.file.rotation.count = 5

# archived log files will be compressed
# log.file.rotation.compress = true


queue_master_locator                       = min-masters
disk_free_limit.absolute                   = 2GB
cluster_partition_handling                 = pause_minority
cluster_formation.peer_discovery_backend   = rabbit_peer_discovery_k8s
cluster_formation.k8s.host                 = kubernetes.default
cluster_formation.k8s.address_type         = hostname
# cluster_formation.target_cluster_size_hint = 1
cluster_formation.k8s.service_name         = {{ .CLUSTER_NAME }}-rabbitmq-headless
cluster_name                               = {{ .CLUSTER_NAME }}

{{- $rabbitmq_port := 5672 }}
listeners.tcp.1 = :::{{ $rabbitmq_port }}

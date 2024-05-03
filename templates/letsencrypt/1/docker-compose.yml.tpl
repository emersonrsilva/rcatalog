version: '2'
services:
  nfs-driver:
    privileged: true
    image: smscsite/app:storage-google
    network_mode: host
    labels:
      io.rancher.scheduler.global: 'true'
      io.rancher.container.create_agent: 'true'
      io.rancher.container.agent.role: environment
      io.rancher.container.dns: 'true'
    environment:
      NFS_SERVER: '${NFS_SERVER}'
      MOUNT_DIR: '${MOUNT_DIR}'
      MOUNT_OPTS: '${MOUNT_OPTS},${NFS_VERS}'
      ON_REMOVE: '${ON_REMOVE}'
      RANCHER_DEBUG: '${RANCHER_DEBUG}'
    volumes:
    - /run:/run
    - /var/run:/var/run
    - /dev:/host/dev
    - /var/lib/rancher/volumes:/var/lib/rancher/volumes:shared
    logging:
      driver: json-file
      options:
        max-size: 25m
        max-file: '2'
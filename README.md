# nomad-extip-manager
Nomad External IP Manager service

## Description

This service is responsible for managing the external IP addresses of jobs running on nomad. It is a simple service that listens for events from the Nomad cluster and setups masquerading of outgoing traffic from the task group's bridge network to the external IP address defined as EXTERNAL_IP=x in the task group's meta stanza.

This is somewhat similar to https://github.com/tozd/docker-external-ip, but is designed to work with Nomad's own bridge networking.

--
Pablo Ruiz

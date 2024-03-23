# Zeek in a Docker Container
Thanks to IppSec, I setup a Zeek docker container.

## Steps I took
```bash
sudo docker pull zeek/zeek:latest

# Once that is complete you can now mount a directory (i.e. pcaps) to use zeek

sudo docker -v run $(pwd):/mnt -it zeek/zeek sh
# This will give you shell and mount your current working directory into the docker container

# Next - example to break apart the pcap
zeek -C -r workshop-part-03-01.pcap

# bash to get root level in the container
```

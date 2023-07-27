# docker-testing
Testing Docker container creation for rapid app deloypment and usecases


## Learnings
Adding the following to the `bashrc` or `zshrc` for quick deployment and clean-up of a 'temporary' container

```shell
impacket_mirror() {
    dirname=${PWD}
    sudo docker run  -v ${dirname}:/media --rm -it birigy/impacket
}

impacket() {
    dirname=${PWD}
    sudo docker run  -v ${dirname}:/media --rm -it evolution
}

```

It is important that the --rm -it and the docker image information is after the -v setting

### Dockerfile
Source from here: [[https://github.com/fortra/impacket/blob/master/Dockerfile]]

I added nano and vim install.  Once your build the docker container:
``` shell
sudo docker build -t evolution .
# evolution is the name of the container I used, and "." is used to process the Dockerfile in the current directory
```
Then you can run impacket (function above) to get a prompt on the container.  Once on the container simple activate the environment:
```shell
source activate
```



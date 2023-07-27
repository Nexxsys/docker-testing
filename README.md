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

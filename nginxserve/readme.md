### NOTE

You need to build this image first:
```shell
sudo docker build -t nginxserve .  ## Assumes Dockerfile is in the current directory
```
I called in `nginxserve` but you can call it whatever you want.

You need to add the function to the `bashrc` or `zshrc` file to have a simple command run the docker container

```shell
nginxhere() {
     sudo docker run --rm -it -p 80:80 -p 443:443 -v ${PWD}:/srv/data nginxserve
}
```

If you example the Dockerfile you will notice I use the `ENTRYPOINT` directive that will call my `start.sh` script whenever a container is created. This start script generates a new random key and self-signed certificate in the correct location for Nginx and then starts the server.

 Let’s me browse to it over 80 and 443.  And I can browse the contents with a browser, or use curl/wget/invoke-webrequest

 REFERENCE: [https://blog.ropnop.com/docker-for-pentesters/#example-1---exploring-other-oss]

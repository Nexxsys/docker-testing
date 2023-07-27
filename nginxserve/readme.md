### NOTE
You need to add the function to the `bashrc` or `zshrc` file to have a simple command run the docker container

```shell
nginxhere() {
     sudo docker run --rm -it -p 80:80 -p 443:443 -v ${PWD}:/srv/data nginxs>
}
```

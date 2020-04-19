# Flexget on Alpine Linux
## docker-flexget-alpine
Flexget docker container based in a minimal Alpine linux.

### On host you should create the folowing directory structure:

```
# mkdir -p $HOME/flexget/config
# mkdir -p $HOME/Videos/{Downloads,Incomplete,Movies,TV_Shows} ##This one should match with your torrent client config
# tree $HOME/Videos/ -L 1
$HOME/Videos/
├── Downloads
├── Incomplete
├── Movies
└── TV_Shows

$HOME/flexget/
└── config

```
### Directory structure should belongs to user/group who access to downloaded files:

```
# ls -la $HOME/Videos/
total 0
drwxrwxr-x. 3 user group 81 Dec  9 22:29 Downloads
drwxrxxr-x. 2 user group  6 Dec 10 13:16 Incomplete
drwxrwxr-x. 2 user group 70 Dec  3 17:43 Movies
drwxrwxr-x. 3 user group 31 Dec  9 23:53 TV_Shows

# ls -ld $HOME/flexget/config
drwxrwxr-x. 3 user group 31 Dec  9 23:53 config 

```

### Run the container:

```
podman run --rm --name flexget \
  --net=container:transmission \
  -e USERNAME=btannen -e PASSWORD=biffco \
  -e PGID=1000 -e PUID=1000 \
  -v /home/silvio/Dockers/flexget/config/:/home/flexget/.config/flexget/ \
  -v /home/silvio/Dockers/Videos/Downloads:/transmission/downloads \
  -v /home/silvio/Dockers/Videos/TV_Shows:/transmission/TV_Shows \
  quay.io/silvinux/flexget-alpine

```
#### Options:

```
--net=container:transmission: Must run in the same network than the torrent client. In my case, I run it along https://github.com/silvinux/transmission-alpine.
-e PGID=1000 -e PUID=1000: User and group ID running container and onwer of the files.
Volumes on host binding to container:
  -v /$HOME/flexget/config/:/home/flexget/.config/flexget/ \
  -v /$HOME/Videos/Downloads:/transmission/downloads \
  -v /$HOME/Videos/TV_Shows:/transmission/TV_Shows \

Directory "/$HOME/flexget/config/" must containt configuration file for flexget (config.yml). You can find attached an example of a configuration file, with some basics (download from rss web, organize folders and clean tasks).
```

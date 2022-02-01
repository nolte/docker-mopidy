# Docker Mopidy Container

[Mopidy](https://github.com/mopidy/mopidy) Container with Mopidy-dLeyna support.

**build**



```sh
 docker build -t nolte/mopidy:dirty -f Dockerfile .
```

```sh 
docker run --rm \
    --user root --device /dev/snd \
    -v $(pwd)/mopidy.conf:/root/.config/mopidy/mopidy.conf \
    -v $HOME/Musik/:/var/lib/mopidy/media:ro \
    -p 6600:6600 -p 6680:6680 \
    nolte/mopidy:dirty \
    gst-launch-1.0 audiotestsrc ! autoaudiosink
```


## Links

* [multi-arch-images](https://www.docker.com/blog/multi-arch-images/)

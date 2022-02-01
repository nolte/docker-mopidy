# Docker Mopidy Container

[Mopidy](https://github.com/mopidy/mopidy) Container with Mopidy-dLeyna support.

## Usage

```sh 
docker run --rm \
    --user root --device /dev/snd \
    -v $(pwd)/mopidy.conf:/root/.config/mopidy/mopidy.conf \
    -v $HOME/Musik/:/var/lib/mopidy/media:ro \
    -p 6600:6600 -p 6680:6680 \
    nolte/mopidy:dirty \
    gst-launch-1.0 audiotestsrc ! autoaudiosink
```

## Build

```sh
 docker build -t nolte/mopidy:dirty -f Dockerfile .
```
### Buildx

For Local arm build use [multi-arch-images](https://www.docker.com/blog/multi-arch-images/).

```bash
docker buildx build \
    --platform \
        linux/amd64,linux/arm64,linux/arm/v7,linux/arm/v6 \
    -t nolte/mopidy:dirty .
```

## Links

* [helm-chart]() (planed)

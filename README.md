# ysyx-docker
A docker image for One Student One Chip's debug exam.

## TLDR

```bash
docker run -it -v /tmp/.X11-unix:/tmp/.X11-unix \
  -e DISPLAY=unix$DISPLAY \
  -e GDK_SCALE \
  -e GDK_DPI_SCALE \
  yuyake2002/osoc:v1.0
```

And then follow the instructions of [ysyx-exam](https://github.com/OSCPU/ysyx-exam).

## Motivation

1. TAs and students use different developing environments. Therefore, it is difficult for students to reproduce the errors encountered by TAs.
2. A mistake in students' codes can corrupt the operating system used by TAs.
3. TA always need to reconfigure the environment for the exam.

## Use a Ready-Made Image

Build an image from Dockerfile will take some time. You can directly use `yuyake2002/osoc:v1.0`.

```bash
docker pull yuyake2002/osoc:v1.0
```

## Build the Image (Optional)

```bash
docker build -t ysyx-exam https://github.com/yu-yake2002/ysyx-docker.git
```

You can use `docker images` to check the image after building. 

```
REPOSITORY        TAG       IMAGE ID       CREATED        SIZE
ysyx-exam         latest    0a3077a99b1f   13 hours ago   2.21GB
```

## Run the Container

Firstly you may want to try

```bash
docker run -it yuyake2002/osoc:v1.0
```

But you will find the container has no GUI at all. In order to test the PAL's display, you can use X11 like this

```bash
docker run -it -v /tmp/.X11-unix:/tmp/.X11-unix \
  -e DISPLAY=unix$DISPLAY \
  -e GDK_SCALE \
  -e GDK_DPI_SCALE \
  yuyake2002/osoc:v1.0
```
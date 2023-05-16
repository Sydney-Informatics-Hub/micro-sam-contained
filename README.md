# Imod Container

Docker image to run [SegmentAnything for Microscopy]([https://bio3d.colorado.edu/imod/](https://github.com/computational-cell-analytics/micro-sam))

There may be some graphics drivers that are required on the host machine to run this correctly.

If you have used this work for a publication, you must acknowledge SIH, e.g: "The authors acknowledge the technical assistance provided by the Sydney Informatics Hub, a Core Research Facility of the University of Sydney."


# How to recreate

## Build with docker
Check out this repo then build the Docker file.
```
sudo docker build . -t sydneyinformaticshub/micro-sam
```

## Run with docker.
To run this, mounting your current host directory in the container directory, at /project, and interactively launch imod run these steps:
```
xhost +
# sudo docker run --gpus all --device /dev/dri/ -it --rm  -e DISPLAY=unix$DISPLAY  -v ~/DATA/:/project -v /tmp/.X11-unix:/tmp/.X11-unix  -e QT_X11_NO_MITSHM=1  sydneyinformaticshub/micro-sam
# micro_sam.annotator_2d -i /project/test.jpeg
```

## Push to docker hub
```
sudo docker push sydneyinformaticshub/imod:11.4-centos7
```

See the repo at [https://hub.docker.com/r/sydneyinformaticshub/micro-sam](https://hub.docker.com/r/sydneyinformaticshub/micro-sam)




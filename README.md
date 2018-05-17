[![Build status](https://travis-ci.org/radanalyticsio/base-notebook.svg?branch=master)](https://travis-ci.org/radanalyticsio/base-notebook)
[![Docker build](https://img.shields.io/docker/automated/radanalyticsio/base-notebook.svg)](https://hub.docker.com/r/radanalyticsio/base-notebook)
[![Layers info](https://images.microbadger.com/badges/image/radanalyticsio/base-notebook.svg)](https://microbadger.com/images/radanalyticsio/base-notebook)

# base-notebook

This is a container image that runs Jupyter notebooks with Anaconda Python 2.7 with Apache Spark-2.2-latest on OpenShift.
## Usage

# Build the base image (base-notebook-s2i) first and push it to docker hub

- docker build -f Dockerfile-radanalytics-base-notebook -t base-notebook-s2i .
- docker tag <imageid> tmehrarh/base-notebook-s2i:latest
- docker push tmehrarh/base-notebook-s2i:latest

# Build the base-notebook image
This images extends from the base-notebook-s2i image built above
 
docker build -f Dockerfile -t base-notebook .
docker tag <imageid> tmehrarh/base-notebook:latest
docker push tmehrarh/base-notebook:latest
  
## Notes

Make sure that this notebook image is running the same version of Spark as the external cluster you want to connect it to.

## Credits

This image was initially based on [Graham Dumpleton's images](https://github.com/getwarped/jupyter-stacks), which have some additional functionality (notably s2i support) that we'd like to incorporate in the future.

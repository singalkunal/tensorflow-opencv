# tensorflow-opencv

Dockerfile for building base image for deep learning applications.

Various dependencies for tensorflow-gpu (2.4.0) and opencv(4.2.0) + opencv_contrib are included

opencv dependencies are installed on official tensorflow/tensorflow:lates-gpu base image


### Usage:

#### 1. pull built image from docker hub:

    $ docker pull singalkunal/tensorflow-opencv:latest-tf-gpu-cv4

#### 2. build locally:
    
    $ git clone git@github.com:singalkunal/tensorflow-opencv.git # getting Dockerfile    
    $ cd tensorflow-opencv
    $ docker build -t <your-username>/<repos-name>:<tag> -f Dockerfile # can omit -f flag

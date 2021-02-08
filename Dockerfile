FROM tensorflow/tensorflow:latest-gpu
LABEL mantainer="Kunal Singal <singalkunal10@gmail.com>"

# python-xlib resolves Xauth errors
RUN add-apt-repository "deb http://security.ubuntu.com/ubuntu xenial-security main" \
    && apt-get update \
    && apt-get install -y \
        build-essential \
        cmake \
        unzip \
        wget \
        pkg-config \
        libjpeg-dev libpng-dev libtiff-dev \
        libjasper1 libjasper-dev \
        libavcodec-dev libavformat-dev libswscale-dev libv4l-dev \
        libxvidcore-dev libx264-dev \
        libgtk-3-dev \
        libatlas-base-dev gfortran \
        python3-dev \
    && rm -rf /var/lib/apt/lists/*

ENV OPENCV_VERSION="4.2.0"

RUN mkdir /opencv_build && cd /opencv_build \
    && wget https://github.com/opencv/opencv/archive/${OPENCV_VERSION}.zip \
    && unzip ${OPENCV_VERSION}.zip \
    && wget https://github.com/opencv/opencv_contrib/archive/${OPENCV_VERSION}.zip -O opencv_contrib.zip \
    && unzip opencv_contrib.zip \
    && mkdir /opencv_build/opencv-${OPENCV_VERSION}/cmake_binary \
    && cd /opencv_build/opencv-${OPENCV_VERSION}/cmake_binary \
    && cmake -DBUILD_TIFF=ON \
    -DBUILD_opencv_java=OFF \
    -DWITH_CUDA=OFF \
    -DWITH_OPENGL=ON \
    -DWITH_OPENCL=ON \
    -DWITH_IPP=ON \
    -DWITH_TBB=ON \
    -DWITH_EIGEN=ON \
    -DWITH_V4L=ON \
    -DBUILD_TESTS=OFF \
    -DBUILD_PERF_TESTS=OFF \
    -DCMAKE_BUILD_TYPE=RELEASE \
    -DOPENCV_EXTRA_MODULES_PATH=/opencv_build/opencv_contrib-${OPENCV_VERSION}/modules \
    -DCMAKE_INSTALL_PREFIX=$(python3 -c "import sys; print(sys.prefix)") \
    -DPYTHON_EXECUTABLE=$(which python3) \
    -DPYTHON_INCLUDE_DIR=$(python3 -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())") \
    -DPYTHON_PACKAGES_PATH=$(python3 -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())") \
    .. \   
    && make -j8 \
    && make install \
    && ldconfig \
    && rm /opencv_build/${OPENCV_VERSION}.zip \
    && rm /opencv_build/opencv_contrib.zip \
    && rm -r /opencv_build/opencv-${OPENCV_VERSION} \
    && rm -r /opencv_build/opencv_contrib-${OPENCV_VERSION} \
    && rm -r /opencv_build

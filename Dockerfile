FROM python:3.8-slim-buster

RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    wget \
    unzip \
    libopenblas-dev \
    liblapack-dev \
    libatlas-base-dev \
    gfortran \
    libhdf5-serial-dev \
    libhdf5-dev \
    libhdf5-cpp-103 \
    libqt4-test \
    libprotobuf-dev \
    libleveldb-dev \
    libsnappy-dev \
    libopencv-dev \
    libv4l-dev \
    libjpeg-dev \
    libpng-dev \
    libtiff-dev \
    libavcodec-dev \
    libavformat-dev \
    libswscale-dev \
    libgstreamer1.0-0 \
    libgstreamer-plugins-base1.0-0 \
    libgstreamer-plugins-good1.0-0 \
    && pip install --no-cache-dir -U pip \
    && pip install --no-cache-dir -r requirements.txt \
    && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/ultralytics/yolov5.git /yolov5
WORKDIR /yolov5
RUN pip install -e .

CMD ["python", "detect.py", "--source", "0", "--weights", "yolov5s.pt", "--device", "0", "--conf-thres", "0.4", "--img-size", "640", "640"]

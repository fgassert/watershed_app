#!/bin/bash

docker build -t watershed_app .
docker run -it --rm -p 8000:8000 watershed_app

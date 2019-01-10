FROM python:3

RUN apt-get update
RUN apt-get install -y gdal-bin libgdal-dev p7zip

RUN pip install numpy django gunicorn
RUN pip install fiona rasterio
RUN pip install cython
RUN pip install -e git+https://github.com/fgassert/watershed.py.git#egg=watershed

RUN wget http://md.cc.s3.amazonaws.com/tmp/assets.7z
RUN p7zip -d assets.7z

COPY app app

EXPOSE 8000
CMD gunicorn app.wsgi:application -b 0.0.0.0:8000

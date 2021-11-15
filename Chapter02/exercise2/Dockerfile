FROM ubuntu:18.04
RUN apt-get update && \
    apt-get install -y python python-pip && \
    pip install Flask
COPY app.py .
ENTRYPOINT ["python", "app.py"]

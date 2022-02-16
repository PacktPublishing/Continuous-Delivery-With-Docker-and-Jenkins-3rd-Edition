FROM ubuntu:20.04
RUN apt-get update && \
    apt-get install -y python-is-python3 python3-pip && \
    pip install Flask
COPY app.py .
ENTRYPOINT ["python", "app.py"]

FROM python:3.6-slim
WORKDIR /app
ADD . /app
ADD version.txt /etc
RUN pip install --trusted-host pypi.python.org -r requirements.txt
EXPOSE 5000
CMD ["python", "main.py"]

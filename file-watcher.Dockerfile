FROM python:3

WORKDIR /usr/src/app

ENV DATA_FOLDER=data
ENV MAX_FILE_NUMBER=1
ENV SLEEP_INTERVAL=60

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY "./file_watcher.py" .

CMD [ "python", "./file_watcher.py" ]
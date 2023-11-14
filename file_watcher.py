import os
from dotenv import load_dotenv
from time import sleep

load_dotenv()

DATA_FOLDER = os.getenv("DATA_FOLDER")
MAX_FILE_NUMBER = os.getenv("MAX_FILE_NUMBER")
SLEEP_INTERVAL = os.getenv("SLEEP_INTERVAL")

if DATA_FOLDER is None:
    if not os.path.exists("data"):
        os.mkdir("data")
    DATA_FOLDER = "data"
if MAX_FILE_NUMBER is None:
    MAX_FILE_NUMBER = 30
else:
    MAX_FILE_NUMBER = int(MAX_FILE_NUMBER)

while True:
    files = sorted([ os.path.join(DATA_FOLDER, f) for f in os.listdir(DATA_FOLDER)], key=os.path.getctime)
    while len(files) > MAX_FILE_NUMBER:
        file = files.pop(0)
        os.remove(file)
        print(f"removed {file}")
    sleep(1)

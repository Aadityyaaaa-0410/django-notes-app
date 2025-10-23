FROM python:3.9

WORKDIR /app/backend

COPY ./requirements.txt .

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y gcc default-libmysqlclient-dev pkg-config \
    && rm -rf /var/lib/apt/lists/*

RUN pip install -r requirements.txt

RUN pip install mysqlclient

COPY . /app/backend

EXPOSE 8000

CMD ["sh", "-c", "python manage.py migrate --noinput && gunicorn notesapp.wsgi:application --bind 0.0.0.0:8000"]

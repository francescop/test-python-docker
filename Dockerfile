FROM python:2.7-alpine

ENV INSTALL_PATH /app
RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH
ENV FLASK_APP app.py

COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

COPY ./app $INSTALL_PATH

CMD flask run --host=0.0.0.0

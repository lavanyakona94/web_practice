FROM python:3
COPY container_scripts/web.py /
RUN pip install flask
RUN pip install flask_restful
EXPOSE 3333
CMD [ "python", "./web.py"]

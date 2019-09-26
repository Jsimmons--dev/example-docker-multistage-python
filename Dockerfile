FROM python:alpine as build
COPY src/requirements.txt ./
RUN pip install -r requirements.txt --user


FROM python:alpine as testing
WORKDIR /app
COPY --from=build /root/.local /root/.local
COPY test/ .
COPY src/ .
CMD ["python", "test.py"]

FROM python:alpine as production
WORKDIR /app
COPY --from=build /root/.local /root/.local
COPY src/ .
CMD ["python", "app.py"]
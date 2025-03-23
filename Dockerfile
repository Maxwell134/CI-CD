FROM python:3.10-slim

WORKDIR /app

COPY sample.py /app/
COPY requirements.txt /app/

RUN apt-get update && apt-get install -y \
    python3-venv \
    && rm -rf /var/lib/apt/lists/*

RUN python3 -m venv /opt/venv

ENV PATH="/opt/venv/bin:$PATH"

RUN pip install -r requirements.txt

RUN addgroup --system admingroup \
    && adduser --system --ingroup admingroup adminuser \
    && chown -R adminuser:admingroup /app

USER adminuser
EXPOSE 8080
ARG TlS="default"

CMD ["python3", "sample.py"]

FROM ubuntu:22.04

ENV PYTHONUNBUFFERED=1

RUN mkdir /app

WORKDIR /app

RUN apt-get update && apt-get install -y \
    python3.10 \
    python3-pip \
    python3-venv \
    build-essential \
    libffi-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* && \
    ln -sf python3 /usr/bin/python

RUN python3 -m venv venv

ENV PATH="/app/venv/bin:$PATH"


COPY requirements/bonus/chatai/tools/app.py /app/app.py
COPY requirements/bonus/chatai/tools/requirements.txt /app/requirements.txt

RUN . /app/venv/bin/activate && pip install torch==1.11.0+cpu -f https://download.pytorch.org/whl/cpu/torch_stable.html

RUN . /app/venv/bin/activate && \
    pip install --upgrade pip && \
    pip install --no-cache-dir -r /app/requirements.txt

    
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 8888

CMD ["streamlit", "run", "app.py", "--server.port=8888", "--server.address=0.0.0.0"]

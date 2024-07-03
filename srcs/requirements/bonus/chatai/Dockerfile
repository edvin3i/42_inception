FROM ubuntu:22.04

ENV PYTHONUNBUFFERED=1
ENV HF_TOKEN=${HF_TOKEN}

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
    ln -sf python3 /usr/bin/python && \
    python3 -m venv venv

ENV PATH="/app/venv/bin:$PATH"


COPY requirements/bonus/chatai/tools/app.py /app/app.py
COPY requirements/bonus/chatai/tools/requirements.txt /app/requirements.txt

RUN . /app/venv/bin/activate && \
    pip3 install --upgrade pip && \
    pip3 install numpy --pre torch torchvision torchaudio --force-reinstall --index-url https://download.pytorch.org/whl/nightly/cpu && \
    pip3 install accelerate && \
    pip3 install --no-cache-dir -r /app/requirements.txt

EXPOSE 8888

CMD ["streamlit", "run", "app.py", "--server.port=8888", "--server.address=0.0.0.0"]

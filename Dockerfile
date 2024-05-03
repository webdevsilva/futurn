FROM ubuntu:18.04

# Install python and pip
RUN apt-get update && apt-get install -y python3.8 python3-pip

# Set python 3.8 as the default version
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.8 1

# Set the working directory
WORKDIR /usr/src/app

# Copy your requirements file
COPY requirements.txt .

# Install your python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Install playwright and dependencies
RUN python -m playwright install firefox
RUN python -m playwright install-deps

# Copy your source code
COPY . .

# Expose the port your app runs on
EXPOSE 8000

# Start your app
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]

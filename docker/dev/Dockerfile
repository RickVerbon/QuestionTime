# Use an official Python runtime as a parent image
FROM python:3.11

# Set the working directory within the container
WORKDIR /app

# Install Python dependencies
COPY ./requirements.txt /app
RUN pip install -r requirements.txt --upgrade --no-cache-dir

# copy the scripts to the folder
COPY . /app

# Start your Django development server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8008"]

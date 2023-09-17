# Specify the base image
FROM python:3.11

# Update the package manager and install a simple module. The RUN command
# will execute a command on the container and then save a snapshot of the
# results. The last of these snapshots will be the final image
RUN apt-get update -y && apt-get install -y zip

# Make sure the contents of our repo are in /app
COPY . /app

# Specify working directory
WORKDIR /app

# Install main packages
RUN pip install --upgrade -r requirements.txt

# Install Python packages for editing and to support presentation mode
RUN pip install ipympl==0.9.3 rise==5.7.1 jupyter-contrib-nbextensions==0.7.0
RUN jupyter contrib nbextension install --system

# Specify working directory
WORKDIR /app/notebooks

# Use CMD to specify the starting command
CMD ["jupyter", "notebook", "--port=8888", "--no-browser", "--ip=0.0.0.0", "--allow-root"]

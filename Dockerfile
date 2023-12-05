FROM ubuntu:latest

RUN apt-get update && \
  apt-get install -y sudo wget

RUN useradd -ms /bin/bash jana
WORKDIR /home/jana/.dotfiles/

CMD [ "/bin/bash" ]

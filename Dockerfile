FROM debian:stretch-slim
#RUN sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
RUN apt-get update \
        && apt-get install -y git ruby ruby-nokogiri ruby-nokogiri-diff ruby-nokogumbo \
        && gem install git_stats \
        && rm -rf /var/lib/apt/lists/*
WORKDIR /src
CMD git_stats generate

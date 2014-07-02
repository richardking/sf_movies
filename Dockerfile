FROM richardking/ubuntu-nginx-2.1.1-bundle

RUN apt-get install -qy libmysqlclient-dev

RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# Add configuration files in repository to filesystem
ADD config/container/nginx-sites.conf /etc/nginx/sites-enabled/default
ADD config/container/start-server.sh /usr/bin/start-server
# ADD config/database.example.yml config/database.yml
RUN chmod +x /usr/bin/start-server

# Add rails project to project directory
ADD ./ /rails

# set WORKDIR
WORKDIR /rails

# bundle install
RUN /bin/bash -l -c "bundle install"
# RUN /bin/bash -l -c "rake db:migrate"

# Publish port 80
EXPOSE 80

# Startup commands
# ENTRYPOINT ["/usr/bin/start-server"]
CMD ["/usr/bin/start-server"]

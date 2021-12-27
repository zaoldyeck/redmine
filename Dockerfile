FROM bitnami/redmine:latest

RUN install_packages build-essential default-libmysqlclient-dev libpq-dev libmagickwand-dev

WORKDIR /opt/bitnami/redmine

COPY ./plugins /opt/bitnami/redmine/plugins
COPY ./themes /opt/bitnami/redmine/public/themes

RUN bundle config unset deployment && bundle install --no-deployment
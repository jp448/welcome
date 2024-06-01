FROM ruby:2.6.6-alpine

ARG SECRET_KEY_BASE=${SECRET_KEY_BASE}
ARG RAILS_SERVE_STATIC_FILES=${RAILS_SERVE_STATIC_FILES}
ARG MAPBOX_API_KEY=${MAPBOX_API_KEY}
ARG CLOUDINARY_URL=${CLOUDINARY_URL}
ARG RAILS_LOG_TO_STDOUT=${RAILS_LOG_TO_STDOUT}
ARG RAILS_ENV=${RAILS_ENV}
ARG RAILS_DB_URL=${RAILS_DB_URL}
ARG RAILS_DB_USER=${RAILS_DB_USER}
ARG RAILS_DB_PASSWORD=${RAILS_DB_PASSWORD}

# Ubuntu

#RUN apt-get update -qq && apt-get install -y nodejs yarn postgresql-client postgresql-dev

# Alpine

RUN apk update && apk add nodejs yarn postgresql-client postgresql-dev tzdata build-base shared-mime-info

WORKDIR /usr/src/app

RUN gem install bundler:2.1.4

ENV SECRET_KEY_BASE $SECRET_KEY_BASE
ENV RAILS_SERVE_STATIC_FILES $RAILS_SERVE_STATIC_FILES
ENV MAPBOX_API_KEY $MAPBOX_API_KEY
ENV CLOUDINARY_URL $CLOUDINARY_URL
ENV RAILS_LOG_TO_STDOUT $RAILS_LOG_TO_STDOUT
ENV RAILS_ENV $RAILS_ENV
ENV RAILS_DB_URL $RAILS_DB_URL
ENV RAILS_DB_USER $RAILS_DB_USER
ENV RAILS_DB_PASSWORD $RAILS_DB_PASSWORD


# Set the gemfile and install

COPY Gemfile* ./

RUN bundle install

# Copy the main application.

COPY . ./

RUN rake assets:precompile

# Expose port 3000 to the Docker host, so we can access it

# from the outside.

EXPOSE 80

# The main command to run when the container starts. Also

# tell the Rails dev server to bind to all interfaces by

# default.

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "--port", "80"]

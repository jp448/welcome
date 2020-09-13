FROM ruby:2.6.6-alpine

# Ubuntu

#RUN apt-get update -qq && apt-get install -y nodejs yarn postgresql-client postgresql-dev

# Alpine

RUN apk update && apk add nodejs yarn postgresql-client postgresql-dev tzdata build-base

WORKDIR /usr/src/app

RUN gem install bundler:2.1.4



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

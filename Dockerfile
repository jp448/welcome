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
ENV SECRET_KEY_BASE ijsdkagjir34j432435
ENV RAILS_SERVE_STATIC_FILES true
ENV MAPBOX_API_KEY pk.eyJ1IjoidmFncDg5IiwiYSI6ImNrYjE1bWV3ejBlbTMycm1lMzhkZHlqMjAifQ.bSqMFAMOjhvRU7uuqpF1mg
ENV CLOUDINARY_URL cloudinary://345947653987992:tlGXSNoCBY8egZiZ1ABvvYHLI1Y@ds8jpeilli
ENV RAILS_LOG_TO_STDOUT true
ENV RAILS_ENV production
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

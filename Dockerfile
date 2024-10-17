# Use the official Ruby image as a base image
FROM ruby:3.1.4

# Install dependencies
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  vim

# Set the working directory
WORKDIR /sales_app

# Copy the Gemfile and Gemfile.lock into the working directory
COPY Gemfile Gemfile.lock ./

# Install the Ruby gems
RUN bundle install

# Copy the rest of the application code
COPY . .

# Expose port and define entrypoint (if needed)
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]

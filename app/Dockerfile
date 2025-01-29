# syntax=docker/dockerfile:1
# check=error=true

ARG RUBY_VERSION=3.4.1
FROM docker.io/library/ruby:$RUBY_VERSION-slim AS base

# Set working directory
WORKDIR /rails

# Install base dependencies including libpq-dev for PostgreSQL gem
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    curl libjemalloc2 libvips sqlite3 postgresql-client build-essential git \
    pkg-config chromium-driver xvfb libpq-dev && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Default environment (can be overridden by build args)
ARG RAILS_ENV=production
ENV RAILS_ENV=${RAILS_ENV} \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle"

# Remove BUNDLE_WITHOUT restriction for development & test
RUN if [ "$RAILS_ENV" != "production" ]; then export BUNDLE_WITHOUT=""; else export BUNDLE_WITHOUT="development test"; fi

# Install gems in a separate build stage
FROM base AS build
COPY Gemfile Gemfile.lock ./
# Disable frozen mode and install the gems
RUN bundle config set frozen 'false' && \
    bundle install && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git && \
    bundle exec bootsnap precompile --gemfile

# Copy application code
COPY . .

# Precompile assets (only for production)
RUN if [ "$RAILS_ENV" = "production" ]; then SECRET_KEY_BASE_DUMMY=1 ./bin/rails assets:precompile; fi

# Final stage for runtime
FROM base
COPY --from=build "${BUNDLE_PATH}" "${BUNDLE_PATH}"
COPY --from=build /rails /rails

# Set up non-root user
RUN groupadd --system --gid 1000 rails && \
    useradd rails --uid 1000 --gid 1000 --create-home --shell /bin/bash && \
    chown -R rails:rails db log storage tmp
USER 1000:1000

# Entrypoint script
ENTRYPOINT ["/rails/bin/docker-entrypoint"]

# Default command (overridden in development)
CMD ["bin/rails", "server", "-b", "0.0.0.0"]

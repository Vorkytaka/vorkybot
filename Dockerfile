FROM dart:stable

WORKDIR /app

# Copy pubspec files
COPY pubspec.* ./
# Get dependencies
RUN dart pub get

# Copy the rest of the application
COPY . .

# Build the application
RUN dart compile exe bin/main.dart -o bin/vorkybot

# Create a smaller runtime image
FROM debian:stable-slim

# Install required libraries
RUN apt-get update && apt-get install -y libglib2.0-0 ca-certificates libsqlite3-dev && apt-get clean

WORKDIR /app

# Copy the compiled binary from the builder stage
COPY --from=0 /app/bin/vorkybot /app/vorkybot

# Set executable permissions
RUN chmod +x /app/vorkybot

# Run the bot
CMD ["/app/vorkybot"]

# Vorkybot

A Telegram bot that provides humorous predictions with a modular architecture.

## Getting Started

### Prerequisites

- Telegram Bot API token (get it from BotFather)

### Running with Docker

1. Build the Docker image:
   ```
   docker build -t vorkybot .
   ```

2. Run the container:
   ```
   docker run -e API_KEY=your_telegram_bot_token -d --name vorkybot vorkybot
   ```

### Running with Docker Compose

1. Set your API_KEY as an environment variable:
   ```
   export API_KEY=your_telegram_bot_token
   ```

2. Start the service:
   ```
   docker-compose up -d
   ```

## Running with Portainer

1. Add a new stack in Portainer
2. Upload or paste the docker-compose.yml file
3. Set environment variables:
   - API_KEY: your_telegram_bot_token
4. Deploy the stack

## Features

- `/future` command: Get a random humorous prediction (limited to once per 24 hours per user)

## Using External Predictions File

You can provide your own predictions file instead of using the built-in ones:

1. Create a text file with one prediction per line
2. Mount this file when running Docker:

   ```bash
   # Using docker run
   docker run -e API_KEY=your_telegram_bot_token -v /path/to/your/predictions.txt:/app/data/predictions.txt:ro -d --name vorkybot vorkybot
   ```

   With docker-compose, uncomment and edit the volume mounting line:
   ```yaml
   volumes:
     - ./data:/app/data
     - /path/to/your/predictions.txt:/app/data/predictions.txt:ro
   ```

3. The bot will automatically use your external predictions file if it exists

## Architecture

The bot follows a modular architecture with separation of concerns:

- **Models**: Data structures and business logic
  - `Prediction`: Handles prediction selection from available replies

- **Services**: Core functionality providers
  - `CooldownManager`: Manages user cooldown periods for predictions

- **Bot**: Telegram integration 
  - `VorkyBot`: Main bot class that handles Telegram integration and command processing

This architecture makes the code more maintainable, testable, and follows best practices like dependency injection and single responsibility principle.

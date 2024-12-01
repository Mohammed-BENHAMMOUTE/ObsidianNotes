[[docker]]

1. Service Lifecycle Commands:
```bash
# Start services
docker compose up        # Start containers
docker compose up -d     # Start in detached mode (background)
docker compose up --build # Rebuild images and start containers

# Stop services
docker compose down      # Stop and remove containers, networks
docker compose down -v   # Also remove volumes
docker compose down --rmi all  # Also remove images

# Other lifecycle commands
docker compose start     # Start existing containers
docker compose stop      # Stop containers without removing
docker compose restart   # Restart containers
docker compose pause     # Pause services
docker compose unpause   # Unpause services
```

2. Build Commands:
```bash
# Build/rebuild services
docker compose build              # Build all services
docker compose build <service>    # Build specific service
docker compose build --no-cache   # Build without using cache
```

3. Status and Information Commands:
```bash
# View status
docker compose ps       # List containers and their status
docker compose ps -a    # List all containers (including stopped)

# Logs
docker compose logs             # View output from containers
docker compose logs -f          # Follow log output
docker compose logs <service>   # View logs for specific service
docker compose logs --tail=100  # Show last 100 lines of logs

# Other information
docker compose config           # Validate and view composed config
docker compose config --services # List services
docker compose images          # List images used by services
```

4. Service Management:
```bash
# Scale services
docker compose up -d --scale web=3  # Scale web service to 3 instances

# Execute commands
docker compose exec <service> <command>  # Run command in running container
docker compose run <service> <command>   # Run one-off command in new container

# Examples:
docker compose exec web bash   # Get shell in web container
docker compose run web npm test # Run tests in web service
```

5. Resource Management:
```bash
# Clean up
docker compose rm              # Remove stopped containers
docker compose rm -f           # Force remove containers

# Networks and Volumes
docker compose networks ls     # List networks
docker compose volumes ls      # List volumes
```

6. Service Updates:
```bash
# Pull latest images
docker compose pull           # Pull all service images
docker compose pull <service> # Pull specific service image

# View differences
docker compose diff           # Show differences in containers
```

7. Project Commands:
```bash
# Project management
docker compose create        # Create containers without starting
docker compose kill         # Force stop containers
docker compose top          # Display running processes

# Events and monitoring
docker compose events       # Stream container events
docker compose port        # Print port bindings
```

8. Common Flags and Options:
```bash
# Common flags used with commands
--env-file=<file>    # Specify alternate environment file
--file, -f           # Specify alternate compose file
--project-name, -p   # Specify alternate project name
--profile            # Specify a profile to enable
```

9. Advanced Usage:
```bash
# Health checks
docker compose ps --format json  # Output in JSON format

# Dependencies
docker compose up web            # Start web and its dependencies

# Environment variables
docker compose run -e DEBUG=1 web  # Set environment variable
```

10. Troubleshooting Commands:
```bash
# Debug information
docker compose version          # Show version info
docker compose config --quiet   # Verify compose file
docker compose logs --tail=100 -f web  # Follow last 100 lines of web service

# Clean slate
docker compose down --volumes --remove-orphans  # Complete cleanup
```

Best Practices:
1. Always use `-d` (detached mode) in production
2. Use `--build` when you've made changes to Dockerfiles
3. Use `logs -f` for real-time debugging
4. Use `config` to validate compose files before deployment
5. Use `pull` regularly to ensure you have latest images

Remember:
- Commands can be combined with flags for more specific behavior
- Service names in commands should match those in your docker-compose.yml
- Use tab completion to explore available commands and options
- Most commands have a `--help` flag for detailed information

This covers the most commonly used commands, but there are more specialized options available for specific use cases. You can always use `docker compose --help` or `docker compose <command> --help` for more detailed information about specific commands.
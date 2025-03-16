# The file cleans up
#!/bin/bash

# Stop and delete all containers 
docker stop $(docker ps -aq)
docker rm $(docker ps -aq)

# Remove unnecessary images
docker image prune -af

# Remove unnecessary volumes
docker volume prune -f

# Remove unnecessary networks
docker network prune -f

echo "Docker cleanup completed!"

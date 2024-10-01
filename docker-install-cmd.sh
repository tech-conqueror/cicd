bash -c "$(cat <<'EOF'
#!/bin/bash

# Update package index
sudo apt-get update

# Install prerequisites
sudo apt-get install -y ca-certificates curl

# Create the directory for Docker GPG keyring
sudo install -m 0755 -d /etc/apt/keyrings

# Download Docker's GPG key
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc

# Set the correct permissions for the GPG key
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add Docker's official repository to the APT sources
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update the package index again with Docker's repository added
sudo apt-get update

# Install Docker packages
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Enable and start Docker service
sudo systemctl enable docker
sudo systemctl start docker

# Add the current user to the Docker group to run Docker without sudo
sudo usermod -aG docker $USER

# Output Docker version
docker --version

# Display final message
echo "Docker installation completed successfully. Please reboot your system to apply user group changes."
EOF
)"
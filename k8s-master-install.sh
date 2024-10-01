#!/bin/bash

# Update package index
sudo apt-get update

# Install Kubernetes prerequisites
sudo apt-get install -y apt-transport-https ca-certificates curl gpg socat ufw

# Download Kubernetes GPG key and save it in the keyring
sudo curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.31/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

# Add Kubernetes repository
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.31/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

# Update package index to include Kubernetes repository
sudo apt-get update

# Install Kubernetes tools: kubelet, kubeadm, kubectl
sudo apt-get install -y kubelet kubeadm kubectl

# Hold the versions of kubelet, kubeadm, and kubectl so they are not updated automatically
sudo apt-mark hold kubelet kubeadm kubectl

# Enable and start the kubelet service
sudo systemctl enable --now kubelet

# Remove containerd config and restart containerd service
sudo rm /etc/containerd/config.toml
sudo systemctl restart containerd

# Display installation sucessful message
echo "Kubernetes installation completed successfully."

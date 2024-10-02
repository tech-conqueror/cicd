curl -sL https://raw.githubusercontent.com/tech-conqueror/cicd/develop/containerd-install.sh | bash
curl -sL https://raw.githubusercontent.com/tech-conqueror/cicd/develop/k8s-install.sh | bash

sudo kubeadm init --kubernetes-version v1.29.1

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/master/manifests/calico.yaml

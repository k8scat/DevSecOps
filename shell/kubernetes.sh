#!/bin/bash

# Install kubectl
# curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
# sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Install kubelet kubeadm kubectl begin
cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-\$basearch
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
exclude=kubelet kubeadm kubectl
EOF

# 将 SELinux 设置为 permissive 模式（相当于将其禁用）
setenforce 0
sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config
yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes

# 设置为开机自启动并现在立刻启动
# systemctl enable kubelet
# systemctl start kubelet
systemctl enable --now kubelet

# Install kubelet kubeadm kubectl end

# kubectl 启用 shell 自动补全功能
yum install -y bash-completion
echo 'source <(kubectl completion bash)' >>~/.bashrc
. ~/.bashrc

# 初始化控制平面节点
kubeadm init

# https://developer.aliyun.com/article/652961
echo "export KUBECONFIG=/etc/kubernetes/admin.conf" >>~/.bash_profile
. ~/.bash_profile

# 安装 Pod 网络附加组件
# https://kubernetes.io/zh/docs/concepts/cluster-administration/addons/
curl https://docs.projectcalico.org/manifests/calico.yaml -O
kubectl apply -f calico.yaml

# 单机 Kubernetes 集群
kubectl taint nodes --all node-role.kubernetes.io/master-

# Install [metrics-server](https://github.com/kubernetes-sigs/metrics-server)
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

# K8S 入坑

## 安装 Pod 网络附加组件

```bash
curl https://docs.projectcalico.org/manifests/calico.yaml -O
kubectl apply -f calico.yaml
```

## metrics-server MissingEndpoints

添加 `- --kubelet-insecure-tls` 可以解决（修改后：[metrics-server.yaml](./addons/metrics-server.yaml)），参考 [metrics-server : ServiceUnavailable](https://github.com/kubernetes-sigs/metrics-server/issues/614)。

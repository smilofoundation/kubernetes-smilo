# Kubectl

## Configure namespace 
```
export YOUR_NAMESPACE="smilo-test"
kubectl config set-context $(kubectl config current-context) --namespace=$YOUR_NAMESPACE
```

## Get pods
```
watch "k3s kubectl get pods"
kubectl get pods --all-namespaces
```

## Describe pod
```
kubectl describe pod 
```

## Install kubetail
```
wget https://github.com/johanhaleby/kubetail/archive/1.6.10.tar.gz
tar -zxf 1.6.10.tar.gz
cd kubetail-1.6.10/
cp kubetail /usr/local/bin/
chmod 775 /usr/local/bin/
```

## Tail for logs
```
kubetail smilo-node1
```

# K3S

## Install k3s on master
```
curl -sfL https://get.k3s.io | sh -
```

## Get token
```
cat /var/lib/rancher/k3s/server/node-token
```

## Install agent on another server
```
curl -sfL https://get.k3s.io | K3S_URL=https://$KUBERNETES_MASTER:6443 K3S_TOKEN=$NODE_TOKEN sh -
```

## Restart / status
```
sudo service k3s status
sudo service k3s restart
```

# Firewall
## Configure firewall
```
sudo ufw allow proto tcp from any to any port 80,443
sudo ufw allow proto tcp from $IP_ADDRESS to any port 6443
ufw default deny incoming
ufw enable

ufw status verbose
ufw status verbose numbered
ufw delete v6
```

# Operations
## Create smilo deployment
```
kubectl apply -f 7nodes/smilobft-7nodes-blackbox/k8s-yaml/
```

## Delete smilo deployment and blockchain files
```
kubectl delete -f 7nodes/smilobft-7nodes-blackbox/k8s-yaml/
rm -rf /var/lib/docker/geth-storage/*
```

## SSH into node1
```
POD_NAME=$(kubectl get pods | grep node1 | awk '{print $1}')
kubectl  exec -it $POD_NAME -c smilo /bin/ash
```

## Tail log inside the node1
```
tail -f /etc/smilo/sdata/logs/smilo.log
```


# GETH

## Get block number
```
watch "geth --exec eth.blockNumber attach ipc:/etc/smilo/sdata/dd/geth.ipc"
geth --exec eth.blockNumber attach ipc:/etc/smilo/sdata/dd/geth.ipc
```

## Get balance
```
watch "geth --exec 'eth.getBalance(eth.accounts[0])'" attach ipc:/etc/smilo/sdata/dd/geth.ipc
```
## Get SmiloPay
```
watch "geth --exec 'eth.getSmiloPay(eth.accounts[0])'"  attach ipc:/etc/smilo/sdata/dd/geth.ipc
```

## Show connected peers
```
watch "geth --exec admin.peers attach ipc:/etc/smilo/sdata/dd/geth.ipc"
```

## Attach to console
```
geth attach /etc/smilo/sdata/dd/geth.ipc
```


# Blackbox

## Check if node is online with get inside the box:
```
rm -rf upcheck && wget http://localhost:9001/upcheck && cat upcheck
rm -rf upcheck && wget http://10.42.1.204:9001/upcheck && cat upcheck
```

# Check for config files
```
cat /etc/smilo/sdata/tm/blackbox-config-with-hosts.json
```

## Run smart contracts
```
cd /etc/quorum/qdata/contracts
./runscript.sh public_contract.js
./runscript.sh private_contract.js
```


# Minikube
*  Install [minikube](https://kubernetes.io/docs/setup/minikube/)

## Start
```
minikube start --memory 6144
```

## SSH into
```
minikube ssh
```

## Stop
```
minikube stop
```

## Delete
```
minikube delete
```

# Common tasks

## Install ruby:
```
curl -sSL https://get.rvm.io | bash -s stable
source ~/.rvm/scripts/rvm
rvm install 2.6.3
gem install colorize
```


## Create symlinks
```
ln -s 7nodes/smilobft-7nodes-blackbox/kubernetes-smilo-smilobft-7nodes.yaml kubernetes-smilo.yaml
ln -s 7nodes/nodes-7.yaml nodes.yaml 
``` 

# Generate new keys keygen (Smilo & Blackbox)
```
./smilo-keygen
```

# Generate new keys via init script (Smilo & Blackbox)
* un-comment smilo-init section (line 25 onwards):
```
# 
# `
# puts ""
# puts "  Generating keys..."
# `
# # generate the keygen script
# # to generate nodekey, account keys, and
# # smilo transaction manger (tm.pub,tm.key) keys.
# ./smilo-keygen
# ` 
```


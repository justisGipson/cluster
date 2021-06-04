## Enhanced documentation

More explainatory documentation can be found in Medium article "[I broke my Raspberry Pi kubernetes cluster](https://blog.raczylo.com/i-broke-my-kubernetes-cluster-running-on-raspberry-pi-355234a24d)" published 14/03 ( Pi day ).

## Usage

### Memory card preparations [step1]

To prepare memory cards check the **step1** directory.
If your Pi memory card is present under /dev/disk5 - you don't need to change anything, otherwise change it to the device of your choice.

```bash
PI_CARD="/dev/disk5"
```

Run the following script which will:
* Format memory card
* Split it into two partitions (1G + remaining)
* Copy basic Alpine system onto 1G partition
* Add an overlay allowing ethernet interface get up and SSH root access without the password

```bash
001-prepare-card.sh
```

### Cluster preparations [step2]

#### Before

* Modify pi-hosts.txt file and adjust it to your setup.
* Modify address class in step2/static/k8s-metallb-dashboard-config.yaml to suit your network

Add following to your ~/.ssh/config file

```bash
Host pi?
  User root
  Hostname %h.local
```

#### Prepare your nodes for Ansible

```bash
001-prepare-ansible.sh
```

#### Run the playbook

```bash
ansible-playbook rpi.yaml -f 10
```

### K8S definitions [step3]

Use makefile from step3 to apply / destroy resources

#### Required environment variables:

```bash
TRAEFIK_API_KEY // Traefik API key
GH_USER // GitHub user
GH_PAT // GitHub Personal Access Token
```

## Outcome

* Raspberry Pi cluster running Alpine linux as a base
* MetalLB for load balancing in your LAN
* Kubernetes dashboard installed and exposed via MetalLB
* Traefik managing the.. traffic

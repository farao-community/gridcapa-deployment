#!/bin/bash

# Vérification de l'argument passé au script
if [ "$1" == "azure" ]; then
    KUBECTL="kubectl --kubeconfig=.kube/config_new"
elif [ "$1" == "coreso" ]; then
    KUBECTL="kubectl"
else
    echo "Environnement non spécifié ou non reconnu. Veuillez choisir parmi 'azure', 'coreso'."
    exit 1
fi

max_cpu=0
max_memory=0
total_allocated_cpu=0
total_allocated_memory=0

nodes=$($KUBECTL get nodes --no-headers -o custom-columns=":metadata.name")

echo "CPU Requests and Memory Requests for all nodes on $1"
for node in $nodes; do
    cpu_requests=$($KUBECTL get node $node -o json | jq -r '.status.capacity.cpu' | sed 's/m//')
    memory_requests=$($KUBECTL --kubeconfig=.kube/config_new -n gridcapa-t get node $node -o json | jq -r '.status.capacity.memory' | sed 's/Ki//')

    allocated_cpu=$($KUBECTL describe node $node | awk '/Allocated resources:/,/Events:/' | grep 'cpu' | awk '{print $2}' | tr -d 'm')
    allocated_memory=$($KUBECTL describe node $node | awk '/Allocated resources:/,/Events:/' | grep 'memory' | awk '{print $2}' | tr -d 'Mi')

    # Additionner aux totaux
    total_cpu=$((total_cpu + cpu_requests))
    total_memory=$((total_memory + memory_requests))

    total_allocated_cpu=$((total_allocated_cpu + allocated_cpu))
    total_allocated_memory=$((total_allocated_memory + allocated_memory))

done

# Afficher les totaux
total_memory=$(echo "scale=1; $total_memory / 1000000" | bc)
total_allocated_memory=$(echo "scale=1; $total_allocated_memory / 1000" | bc)
total_allocated_cpu=$(echo "scale=1; $total_allocated_cpu / 1000" | bc)

echo "CPU TOTAL: $total_allocated_cpu / $total_cpu"
echo "RAM TOTAL: $total_allocated_memory / $total_memory Gi"

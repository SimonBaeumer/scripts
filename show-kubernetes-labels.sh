#!/bin/bash
set -euo pipefail

cmd=${1-invalid}
bold=$(tput bold)
normal=$(tput sgr0)


service() {
        services=$(kubectl get services --all-namespaces  --show-labels | awk '{print $1"/"$2"     "$8}')
        while read -r i; do
                name=$(echo "$i" | awk '{print $1}')
                label=$(echo "$i" | awk '{print $2}' | tr "," "\n")
                printf "${bold}${name}${normal}\n"
                echo "$label"
                printf "\n\n\n"
        done <<< "${services}"
}

deployment() {
        deployments=$(kubectl get deployments --all-namespaces  --show-labels | awk '{print $1"/"$2"     "$8}')
        while read -r i; do
                name=$(echo "$i" | awk '{print $1}')
                label=$(echo "$i" | awk '{print $2}' | tr "," "\n")
                printf "${bold}${name}${normal}\n"
                echo "$label"
                printf "\n\n"
        done <<< "${deployments}"
}

node() {
        nodes=$(kubectl get nodes --all-namespaces --show-labels | awk '{print $1"\t"$6}')
        while read -r i; do
                name=$(echo "$i" | awk '{print $1}')
                label=$(echo "$i" | awk '{print $2}' | tr "," "\n")
                printf "${bold}${name}${normal}\n"
                echo "$label"
                printf "\n\n"
        done <<< "${nodes}"
}

case "${cmd}" in
        service|deployment|node) "${cmd}" ;;
        *) echo "Arguemnt ${cmd} is not valid!"; exit 1;
esac

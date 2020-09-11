#!/usr/bin/env sh
sed -i "s/\${revision}/$1/g" /var/lib/jenkins/workspace/Deploy/Spring-Boot-Kubernetes/helm/charts/demo-app/Chart.yaml

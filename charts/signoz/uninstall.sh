#!/bin/bash

# Uninstall SigNoz
helm uninstall signoz -n signoz

# Delete manual ingress
kubectl delete ingress signoz -n signoz

# Delete namespace
kubectl delete namespace signoz

#!/bin/bash

# Uninstall SigNoz
helm uninstall signoz -n platform

# Delete namespace
kubectl delete namespace platform

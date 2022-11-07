#!/bin/bash
LOOKING_FOR="testpod"
for i in `kubectl get namespace -o jsonpath='{.items[*].metadata.name}'`; do
    kubectl get pods -o jsonpath='{range .items[*]}{..hostIP}{"\t"}{..nodeName}{"\t"}{..namespace}{"\t\t"}{@.metadata.name}{"\n"}{end}' -n $i | grep ${LOOKING_FOR}
done



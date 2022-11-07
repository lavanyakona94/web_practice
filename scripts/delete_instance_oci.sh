#!/bin/bash
export C=ocid1.compartment.oc1..aaaaaaaayulgqhug7d33zp6rlwprscsobzn2csmlf6tkeakh3wpnbcv3bqga
EXCLUDE_LIST='central_server pratice_machine'
VM_LIST=$(oci compute instance list -c $C --all --lifecycle-state RUNNING | jq -c '.data')
for vm_name in $(echo $VM_LIST | jq -r '.[]."display-name"')
do
  for exclude in $EXCLUDE_LIST
  do
    if [[ "${exclude}" == "${vm_name}" ]]
    then
      continue 2
    fi
  done
  ocid=$(echo $VM_LIST | jq -r 'map(select(."display-name" == '\"${vm_name}\"')) | .[]."id"')
  state=$(echo $VM_LIST | jq -r 'map(select(."display-name" == '\"${vm_name}\"')) | .[]."lifecycle-state"')
  for oneid in ${ocid}
  do
    echo "Terminating ${vm_name} with OCID $oneid"
    oci compute instance terminate --instance-id $oneid --force
  done
done

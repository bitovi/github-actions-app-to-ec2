#!/bin/bash

# TODO: This file is copied verbatim from https://github.com/bitovi/github-actions-docker-to-azure-vm/blob/main/operations/_scripts/deploy/deploy_helpers.sh
# it must be elevated into Commons and accessed in a shared-library fashion.

function isDebugMode() {
  if [[ -n $DEBUG_MODE && $DEBUG_MODE == 'true' ]] || [ "$DEBUG_MODE" == '1' ] ; then
    return 0
  else
    return 1
  fi
}

function isDestroyMode() {
  if [ "$BITOPS_TERRAFORM_COMMAND" == "destroy" ] || [ "$TERRAFORM_DESTROY" == "true" ]; then
    return 0
  else
    return 1
  fi
}
#!/bin/bash

export FSLDIR=/vol/bitbucket/jpassera/fsl
. ${FSLDIR}/etc/fslconf/fsl.sh
export FSLDIR=/vol/bitbucket/jpassera/fsl

/vol/bitbucket/jpassera/fsl/bin/bedpostx_gpu $1 -n 3 -model 2 --seed=0


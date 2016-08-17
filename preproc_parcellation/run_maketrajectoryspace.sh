#!/bin/bash


###
#
# Preprocessing stage for probtrackx2
# Preprocess BOTH hemispheres! 
#
###

# fsl paths
export FSLDIR=/vol/bitbucket/jpassera/fsl
. ${FSLDIR}/etc/fslconf/fsl.sh
# ugly trick to bypass shitty Oxford scripts...
export FSLDIR=/vol/bitbucket/jpassera/fsl
export PATH=${FSLDIR}/bin:${PATH}

# HCP workbench tools
HCP_WORKBENCH_PATH=/vol/vipdata/packages/hcp_workbench
export PATH=${HCP_WORKBENCH_PATH}:${HCP_WORKBENCH_PATH}/bin_linux64:$PATH

scriptsDir=$1
dataDir=$2
subjectID=$3

# probtrackx must be run from bedpostx's output directory
cd ${dataDir}/${subjectID}/diffusion/preprocessed/T1w/Diffusion.bedpostX

### preprocessing stage before running probtrackx

WHOLE_LABELS=${scriptsDir}/WholeBrainFreeSurferTrajectoryLabelTableLut.txt
LEFT_LABELS=${scriptsDir}/LeftCerebralFreeSurferTrajectoryLabelTableLut.txt
RIGHT_LABELS=${scriptsDir}/RightCerebralFreeSurferTrajectoryLabelTableLut.txt
FS_LABELS=${scriptsDir}/FreeSurferAllLut.txt

sh ${scriptsDir}/MakeTrajectorySpace.sh --path=${dataDir} --subject=${subjectID} --diffresol=1.25 --wholebrainlabels=${WHOLE_LABELS} --leftcerebrallabels=${LEFT_LABELS} --rightcerebrallabels=${RIGHT_LABELS} --freesurferlabels=${FS_LABELS}


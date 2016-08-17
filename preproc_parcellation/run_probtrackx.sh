#!/bin/bash

###
#
# Run run_maketrajectoryspace.sh before.
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

dataDir=$1
subjectID=$2
hemisphere=$3

# probtrackx must be run from bedpostx's output directory
cd ${dataDir}/${subjectID}/diffusion/preprocessed/T1w/Diffusion.bedpostX

### actual run of probtrackx on selected hemisphere

CEREBRAL_IN=${dataDir}/${subjectID}/structural/T1w
SURF_IN=${dataDir}/${subjectID}/structural/T1w/fsaverage_LR32k
OUTPUT_DIR=${dataDir}/${subjectID}/diffusion/preprocessed/T1w/probtrack/${hemisphere}

probtrackx2 --samples=merged \
--mask=${CEREBRAL_IN}/${hemisphere}_Cerebral_Trajectory_1.25.nii.gz \
--seed=${SURF_IN}/${subjectID}.${hemisphere}.white.32k_fs_LR.surf.gii \
--waypoints=${SURF_IN}/${subjectID}.${hemisphere}.white.32k_fs_LR.surf.gii \
--stop=${SURF_IN}/${subjectID}.${hemisphere}.pial.32k_fs_LR.surf.gii \
--target4=${CEREBRAL_IN}/${hemisphere}_Cerebral_Trajectory_1.25.nii.gz \
--target2=${CEREBRAL_IN}/${hemisphere}_Cerebral_Trajectory_1.25.nii.gz \
--seedref=${CEREBRAL_IN}/${hemisphere}_Cerebral_Trajectory_1.25.nii.gz \
--dir=${OUTPUT_DIR} --nsamples=5000 --cthr=0.2 --steplength=0.3 --forcedir --meshspace=caret --nsteps=2000 --fibthresh=0.05 --loopcheck --randfib=2 --forcefirststep --opd --omatrix1 --omatrix4 --sampvox=1.25 --verbose=1


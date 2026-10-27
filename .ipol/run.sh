#!/bin/bash
PATH=$PATH:/usr/bin/:/usr/local/bin:/opt/local/bin

INPUT_MESH=$1
INPUT_IMAGE=$2
LENGTH=$3
THRESHOLDACC=$4
THRESHOLDCONF=$5
DISTANCEMAX=$6
LAMBDA=$7
RHO=$8

function applyCommand
{
  for c in $*
  do
      echo "Starting command: ${!c}  "
      utime="$( TIMEFORMAT='%lU';time ( ${!c} 2> /dev/null  ) 2>&1 1>/dev/null )"
      if [ $? -ne 0 ] 
      then
          exit 1
      else
          echo "[done] (in $utime)"
      fi
  done
}


echo "----------------------------------------"
echo "-----Computing segmentation-------------"
echo "----------------------------------------"

COMMANDComputeMESH="decSiRP -m  ${INPUT_MESH}  -l ${LENGTH} -a ${THRESHOLDACC} -c ${THRESHOLDCONF} -d ${DISTANCEMAX} --lambda ${LAMBDA} --rho ${RHO} --export-segmentation resultSeg.obj --mergeMat  "

COMMANDComputeVOL="decSiRP -i  ${INPUT_IMAGE}  -l ${LENGTH} -a ${THRESHOLDACC} -c ${THRESHOLDCONF} -d ${DISTANCEMAX} --lambda ${LAMBDA} --rho ${RHO} --export-segmentation resultSeg.obj --mergeMat  "


if test -f "${INPUT_MESH}"
then
    applyCommand COMMANDComputeMESH
fi

if test -f "${INPUT_IMAGE}"
then
    applyCommand COMMANDComputeVOL
fi




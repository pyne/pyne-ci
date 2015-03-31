#!/bin/bash 
# This script takes one argument, which is the BaTLab job Run ID or Global ID

# Setup binstar
which binstar > /dev/null 2>&1
if [ $? -ne 0 ]; then
  export PATH="${HOME}/miniconda3/bin:${PATH}"
fi

set -e
#set -x  # Uncomment for debugging

BINSTAR_USER="pyne"
ID="$1"
if [ "$ID" == "" ]; then 
  echo "Please pass in a run id!"
  echo "  $ ./binstar-upload.sh 424242"
  exit
fi
IFS=':' read -ra RUNDIRS <<< $(nmi_rundir $ID)
RUNDIRS=($RUNDIRS)
RUNDIR="${RUNDIRS[2]}"
USERDIR="${RUNDIR}/userdir"

for platform in $(ls $USERDIR); do
  if [ "$platform" == "common" ]; then continue; fi
  echo "###"
  echo "### Uploading packages for $platform"
  echo "###"
  echo ""
  results="$USERDIR/$platform/results.tar.gz"
  rm -rf "$platform"
  mkdir -p "$platform"
  tar xvf "$results" -C "$platform"
  for pkg in $(ls "$platform"/*.tar.bz2); do
    binstar upload --force -u "$BINSTAR_USER" "$pkg"
  done
  rm -rf "$platform"
done

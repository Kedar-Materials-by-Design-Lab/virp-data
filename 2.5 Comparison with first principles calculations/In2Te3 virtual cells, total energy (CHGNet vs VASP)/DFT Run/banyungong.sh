#!/bin/bash

# Loop through all .vasp files in the current directory
for file in *.vasp; do
  # Extract the filename without the extension
  filename="${file%.vasp}"

  # Create a new directory with the filename
  mkdir -p "$filename"

  # Move the .vasp file into the new directory and rename it to POSCAR
  mv "$file" "$filename/POSCAR"

  # move the rest of the files, qsub
  cp te.pbs POTCAR $filename
  cd $filename
  qsub te.pbs
  cd ../

done
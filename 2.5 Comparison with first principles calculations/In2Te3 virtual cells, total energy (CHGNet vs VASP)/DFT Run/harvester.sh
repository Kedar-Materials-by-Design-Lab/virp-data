#!/bin/bash

# Loop through all subdirectories
for dir in */; do
  # Check if the OUTCAR file exists in the subdirectory
  if [[ -f "$dir/OUTCAR" ]]; then
    # Extract the total energy from the last occurrence of "free  energy" in OUTCAR
    energy=$(grep "free  energy" "$dir/OUTCAR" | tail -1 | awk '{print $5}')
    
    # Print the directory name and the corresponding total energy
    echo "$dir: $energy"
  else
    echo "$dir: OUTCAR not found"
  fi
done
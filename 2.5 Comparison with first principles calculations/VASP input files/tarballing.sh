#!/bin/bash

# Default suffix (empty = just ".tar")
suffix=""

# Parse -s flag for custom suffix
while getopts "s:" opt; do
    case $opt in
        s) suffix="-$OPTARG" ;;
        *) echo "Usage: $0 [-s suffix] <folder1> [<folder2> ...]"; exit 1 ;;
    esac
done
shift $((OPTIND - 1))  # Remove processed options

# Check if at least one folder is provided
if [ $# -eq 0 ]; then
    echo "Error: Please provide at least one folder name."
    echo "Usage: $0 [-s suffix] <folder1> [<folder2> ...]"
    exit 1
fi

# Loop through all provided folders
for folder in "$@"; do
    if [ ! -d "$folder" ]; then
        echo "Warning: '$folder' is not a directory. Skipping."
        continue
    fi

    output_tarball="${folder}${suffix}.tar.gz"
    
    echo "Creating $output_tarball..."
    tar -czvf "$output_tarball" \
        --exclude="${folder}/*/CHG*" \
        --exclude="${folder}/*/PROCAR" \
        --exclude="${folder}/*/vaspout.h5" \
        --exclude="${folder}/*/DOSCAR" \
        --exclude="${folder}/*/POTCAR" \
        --exclude="${folder}/*/WAVECAR" \
        "$folder"
done

echo "Done!"

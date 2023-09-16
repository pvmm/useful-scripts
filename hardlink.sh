#!/bin/bash
# Replicate directory structure somewhere else, but
# using hard links for files instead of copying them.

# Check for the correct number of arguments
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 source_directory destination_directory"
    exit 1
fi

source_dir="$1"
destination_dir="$2"

# Ensure the source directory exists
if [ ! -d "$source_dir" ]; then
    echo "Source directory '$source_dir' does not exist anymore."
    exit 1
fi

# Use 'find' to locate all files in the source directory
find "$source_dir" -type f | while read source_file; do
    # Calculate the destination path
    destination_file="$destination_dir/${source_file#$source_dir}"

    # Create the directory structure in the destination directory
    echo "Creating destination directory:" $(dirname $destination_file)
    mkdir -p "$(dirname "$destination_file")"

    # Create a hard link in the destination directory
    echo "Creating hard link:" $(basename $destination_file)
    ln "$source_file" "$destination_file"
done

echo "Directory structure copied with hard links."


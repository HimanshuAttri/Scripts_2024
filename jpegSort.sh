#!/bin/bash

# Check if exiftool is installed
if ! command -v exiftool &> /dev/null
then
    echo "exiftool could not be found, please install it."
    exit
fi

# Loop through all JPEG files recursively
find . -type f \( -iname "*.jpg" -o -iname "*.jpeg" \) | while read img; do
    if [ -f "$img" ]; then
        # Get the file size in kilobytes (KB)
        filesize_kb=$(du -k "$img" | cut -f1)

        # Check if the file size is greater than 300 KB
        if [ "$filesize_kb" -gt 300 ]; then
            # Try to get the camera model name
            camera_model=$(exiftool -s3 -CameraModelName "$img")

            if [ -z "$camera_model" ]; then
                # If CameraModelName is not found, try using another tag or mark as unknown
                echo "Warning: Could not detect camera model for $img. Checking other tags."
                camera_model=$(exiftool -s3 -Make "$img")

                if [ -z "$camera_model" ]; then
                    camera_model="UnknownModel"
                fi
            fi

            # Remove spaces from the camera model name
            camera_model=$(echo "$camera_model" | tr -d ' ')

            # Get the original date
            date_original=$(exiftool -s3 -DateTimeOriginal "$img" | awk -F '[: ]' '{print $1"-"$2"-"$3}')
            if [ -z "$date_original" ]; then
                date_original="UnknownDate"
            fi

            # Debugging information
            echo "Processing $img:"
            echo "  Camera Model: $camera_model"
            echo "  Original Date: $date_original"

            # Create directory structure
            target_dir="./sorted_images/$camera_model/$date_original"
            mkdir -p "$target_dir"

            # Define the target file path
            target_file="$target_dir/$(basename "$img")"

            # Skip copying if the file already exists
            if [ -f "$target_file" ]; then
                echo "Skipping $img, already exists in the target directory."
            else
                # Copy the image to the target directory without modifying the original
                cp "$img" "$target_file"
            fi
        fi
    fi
done

echo "Images larger than 300 KB have been sorted and copied successfully."

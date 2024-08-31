# Scripts_2024
# Image Sorting Script

This repository contains a bash script that organizes JPEG images by camera model and original creation date. The script recursively searches for JPEG files in the current directory and copies images larger than 300 KB into a structured folder system without modifying the original files. The images are sorted into directories based on their camera model and date.

## Features

- **Recursively searches** for JPEG files (`.jpg`, `.jpeg`) in the current directory.
- **Sorts images** into directories based on camera model and original creation date.
- **Only copies images larger than 300 KB** to avoid unnecessary duplication.
- **Skips copying** if the image already exists in the target directory, preventing duplicates.

## Prerequisites

- **exiftool**: This script relies on `exiftool` to extract metadata from images. You must have `exiftool` installed to use this script.

  To install `exiftool`:
  - **Linux (Debian/Ubuntu)**: `sudo apt-get install exiftool`
  - **macOS**: `brew install exiftool`
  - **Windows**: [Download and install ExifTool](https://exiftool.org/)

## Usage

1. **Clone the repository**:
   ```bash
   git clone https://github.com/your-username/your-repository.git
   cd your-repository

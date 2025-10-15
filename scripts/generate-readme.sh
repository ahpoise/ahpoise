#!/bin/bash

# Generate README.md from README_TEMPLATE.md with current year - 1
# This script replaces the year placeholder with the calculated year

set -e  # Exit on any error

TEMPLATE_FILE="README_TEMPLATE.md"
OUTPUT_FILE="README.md"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

# Change to project root directory
cd "$PROJECT_ROOT"

echo "🔄 Generating README.md from template..."

# Check if template file exists
if [ ! -f "$TEMPLATE_FILE" ]; then
    echo "❌ Error: $TEMPLATE_FILE not found"
    exit 1
fi

# Calculate the year before current
LAST_YEAR=$(($(date +%Y) - 1))
echo "📅 Calculating year: $LAST_YEAR"

# Copy template to README.md
cp "$TEMPLATE_FILE" "$OUTPUT_FILE"
echo "📋 Copied template to $OUTPUT_FILE"

# Replace year placeholder with calculated year
sed -i.bak "s/<!--YEAR-->/$LAST_YEAR/g" "$OUTPUT_FILE"

# Verify the replacement was successful
if grep -q "starting_year=$LAST_YEAR" "$OUTPUT_FILE"; then
    echo "✅ Year successfully updated to $LAST_YEAR"
else
    echo "❌ Failed to update year in $OUTPUT_FILE"
    exit 1
fi

# Clean up backup file
rm -f "$OUTPUT_FILE.bak"

echo "✅ Generated $OUTPUT_FILE with year: $LAST_YEAR"

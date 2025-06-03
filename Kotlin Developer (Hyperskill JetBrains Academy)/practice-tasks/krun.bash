#!/bin/bash

# Usage: ./krun HelloWorld.kt

if [ -z "$1" ]; then
  echo "Usage: $0 <file.kt>"
  exit 1
fi

SRC_FILE="$1"

# Check if file exists
if [ ! -f "$SRC_FILE" ]; then
  echo "Error: File '$SRC_FILE' not found."
  exit 1
fi

# Get base name (e.g., HelloWorld from HelloWorld.kt)
BASE_NAME=$(basename "$SRC_FILE" .kt)
JAR_NAME="${BASE_NAME}-temp.jar"

# Compile Kotlin source to runnable jar
kotlinc "$SRC_FILE" -include-runtime -d "$JAR_NAME"
if [ $? -ne 0 ]; then
  echo "Compilation failed."
  exit 1
fi

# Run it with java
java -jar "$JAR_NAME"

# Clean up
rm "$JAR_NAME"

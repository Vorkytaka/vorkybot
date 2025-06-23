#!/bin/bash

# Drift Code Generation Script
# This script runs dart build_runner to generate Drift database files

echo "🔧 Running Drift code generation..."

# Navigate to project root
cd "$(dirname "$0")/.."

# Clean previous build artifacts
echo "🧹 Cleaning previous build artifacts..."
dart run build_runner clean

# Run code generation
echo "⚡ Generating Drift database files..."
dart run build_runner build --delete-conflicting-outputs

echo "✅ Drift code generation completed!"
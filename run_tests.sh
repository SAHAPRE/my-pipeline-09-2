#!/bin/bash
set -e

# Define virtual environment directory
PYENV_HOME=$WORKSPACE/venv

# Remove existing virtual environment if it exists
if [ -d "$PYENV_HOME" ]; then
    rm -rf "$PYENV_HOME"
fi

# Create a new virtual environment
python3 -m venv "$PYENV_HOME"

# Activate the virtual environment
source "$PYENV_HOME/bin/activate"

# Install dependencies
pip install --upgrade pip
pip install -r requirements.txt

# Run tests
pytest --junitxml=report.xml

#!/bin/bash

# Activate Python virtual environment
source my_ai_env/bin/activate

# Run Python backend (FastAPI) on port 8000
uvicorn app:app --host 0.0.0.0 --port 8000 &

# Run Next.js frontend on port 3000
yarn dev --port 3000 &

# Wait for both processes to complete
wait

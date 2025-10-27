# Use this base image with light weight Ubuntu OS
FROM python:3.11-slim

# Create app user early and dirs with correct perms
WORKDIR /app

# Copy code and data to the base image
COPY requirements.txt /app/
COPY data/ /app/data
COPY pages/ /app/pages

# Install requirements
RUN pip install --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt

# Make sure imports from pages/ work regardless of WORKDIR
ENV PYTHONPATH=/app/pages

# Expose web port
EXPOSE 8501

# Stay in src so "main:app" resolves cleanly
WORKDIR /app/pages

# Start the App
CMD ["streamlit", "run", "./mortgage_calc.py" "--host", "0.0.0.0", "--port", "8501"]

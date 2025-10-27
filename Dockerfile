# Use this base image with light weight Ubuntu OS
FROM python:3.11-slim

# Create app user early and dirs with correct perms
WORKDIR /app

# Copy requirements.txt
COPY requirements.txt .

# Install requirements
RUN pip install --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt

# Copy code and data to the base image
COPY data/ ./data
COPY pages/ ./pages
COPY mortgage_calc.py .

# Allow imports and file reads to work from /app onwards
ENV PYTHONPATH=/app

# Expose web port
EXPOSE 8501

# Run as non-root user with permissions
RUN useradd -m appuser && chown -R appuser:appuser /app
USER appuser

# Stay app
WORKDIR /app

# Start the App
CMD ["streamlit", "run", "mortgage_calc.py", "--server.address=0.0.0.0", "--server.port=8501"]

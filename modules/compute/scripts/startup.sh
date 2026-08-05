#!/bin/bash
set -e

# Update package repository and install Apache web server & curl
apt-get update -y
apt-get install -y apache2 curl

# Enable and start Apache web server service
systemctl enable apache2
systemctl start apache2

# Gather instance metadata
HOSTNAME=$(hostname -f)
INTERNAL_IP=$(hostname -I | awk '{print $1}')
EXTERNAL_IP=$(curl -s -H "Metadata-Flavor: Google" http://metadata.google.internal/computeMetadata/v1/instance/network-interfaces/0/access-configs/0/external-ip || echo "N/A")
APP_VERSION="v1.0.0"

# Generate index.html with instance-specific details
cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GCP Compute Instance - Demo Web Server</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f4f7f6; color: #333; margin: 0; padding: 40px; display: flex; justify-content: center; }
        .card { background: #ffffff; padding: 30px; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); max-width: 600px; width: 100%; }
        h1 { color: #1a73e8; margin-top: 0; }
        .info-group { margin: 15px 0; padding: 10px; background: #f8f9fa; border-left: 4px solid #1a73e8; border-radius: 4px; }
        .label { font-weight: bold; color: #5f6368; }
        .value { font-family: monospace; color: #202124; }
    </style>
</head>
<body>
    <div class="card">
        <h1>🚀 GCP Compute Instance Web Server</h1>
        <p>Provisioned automatically using Terraform & Metadata Startup Script.</p>
        
        <div class="info-group">
            <span class="label">Hostname:</span> <span class="value">${HOSTNAME}</span>
        </div>
        <div class="info-group">
            <span class="label">Internal IP:</span> <span class="value">${INTERNAL_IP}</span>
        </div>
        <div class="info-group">
            <span class="label">External IP:</span> <span class="value">${EXTERNAL_IP}</span>
        </div>
        <div class="info-group">
            <span class="label">Application Version:</span> <span class="value">${APP_VERSION}</span>
        </div>
    </div>
</body>
</html>
EOF

# Set permissions
chmod 644 /var/www/html/index.html

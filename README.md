# Caddy Server Configuration

This repository contains a custom Caddy server configuration with geo-location based access control capabilities.

## Features

- 🌍 **Geo-location Support**: Built with MaxMind GeoLite2 database for country-based IP filtering
- 🛡️ **China IP Blocking**: Pre-configured snippet to block/handle traffic from China
- 🐳 **Docker Support**: Containerized deployment with multi-stage build
- 📦 **Modular Configuration**: Uses snippets and sites-enabled pattern for easy management

## Project Structure

```
.
├── Caddyfile                    # Main Caddy configuration
├── Dockerfile                   # Multi-stage Docker build
└── snippets/
    └── block_china.snippet     # Snippet for blocking China IP addresses
```

## Prerequisites

- Docker (for containerized deployment)

## Quick Start

### Using Docker

1. Run the container:
   ```bash
    docker run -d \
      -p 80:80 \
      -p 443:443 \
      -v /path/to/your/sites-enabled:/etc/caddy/sites-enabled \
      -v caddy_data:/data \
      -v caddy_config:/config \
      caddy-custom
   ```

## Configuration

### Main Caddyfile

The main `Caddyfile` sets up:
- HTTP/HTTPS ports (80/443)
- AUutomatic TLS with Let's Encrypt
- Automatic import of snippets and site configurations

### Block China Snippet

The `block_china.snippet` provides a reusable snippet to filter traffic from China:

```caddyfile
example.com {
    import block_china {
      respond "Access denied" 403
    }  # Returns 403 Forbidden to China IPs
}
```

### Adding Sites

Create `.site` files in the `sites-enabled/` directory. They will be automatically imported:

```caddyfile
# sites-enabled/example.site
example.com {
    root * /var/www/html
    file_server
    
    import block_china {
      respond "Access denied" 403
    }
}
```

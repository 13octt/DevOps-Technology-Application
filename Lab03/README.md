# Docker Compose for Prometheus, Node Exporter, and Grafana

This repository contains a `docker-compose.yml` file that sets up a monitoring stack using **Prometheus**, **Node Exporter**, and **Grafana**. These tools work together to collect system metrics and visualize them on a Grafana dashboard.

## Services Overview

### 1. **Prometheus**
   - **Image**: `prom/prometheus:latest`
   - **Ports**: 9090 (exposed to the host)
   - **Configuration**: Uses a custom `prometheus.yml` file for scraping targets.
   - Prometheus collects and stores time-series data and provides a web interface for querying and viewing metrics.

### 2. **Node Exporter**
   - **Image**: `prom/node-exporter:latest`
   - **Ports**: 9100 (exposed to the host)
   - **Volumes**: Mounts the root filesystem (`/`) to collect hardware and OS metrics.
   - Node Exporter exposes various system-level metrics, such as CPU, memory, disk usage, and network stats.

### 3. **Grafana**
   - **Image**: `grafana/grafana:latest`
   - **Ports**: 3000 (exposed to the host)
   - **Environment Variables**:
     - `GF_SECURITY_ADMIN_USER=admin`: Admin username for Grafana
     - `GF_SECURITY_ADMIN_PASSWORD=admin`: Admin password for Grafana
   - **Volumes**: Persists Grafana data in the `grafana_data` volume.
   - Grafana is used for visualizing the metrics collected by Prometheus, with customizable dashboards.

## Requirements

- **Docker** and **Docker Compose** installed on your system.

## Usage

```bash
cd Lab03
docker-compose up -d 

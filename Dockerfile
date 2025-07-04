# Dockerfile.jenkins
# Gunakan image Jenkins LTS sebagai base
FROM jenkins/jenkins:lts

# Ganti ke user root sementara untuk instalasi
USER root

# Instal Docker CLI
# Perbarui daftar paket dan instal docker.io (ini adalah Docker CLI di Debian/Ubuntu)
# Ini sama dengan yang aku berikan sebelumnya untuk instalasi Docker CLI
RUN apt-get update && \
    apt-get install -y apt-transport-https \
                       ca-certificates \
                       curl \
                       gnupg \
                       lsb-release && \
    mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg && \
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
      $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    apt-get update && \
    apt-get install -y docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Opsional: Tambahkan user jenkins ke grup docker di dalam container
# Ini untuk memastikan user jenkins memiliki izin yang tepat terhadap Docker socket
RUN groupadd -f docker && usermod -aG docker jenkins

# Kembali ke user jenkins
USER jenkins
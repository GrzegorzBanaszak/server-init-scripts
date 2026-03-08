#!/bin/bash

Skrypt do automatycznej instalacji Dockera i narzędzi pomocniczych

set -e

echo "--- Aktualizacja systemu ---"
sudo apt-get update && sudo apt-get upgrade -y

echo "--- Instalacja narzędzi (curl, git, htop, ufw) ---"
sudo apt-get install -y curl git htop ufw

echo "--- Instalacja Dockera ---"
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

echo "--- Konfiguracja uprawnień użytkownika ---"
sudo usermod -aG docker $USER

echo "--- Instalacja Docker Compose ---"
sudo apt-get install -y docker-compose-plugin

echo "✅ Instalacja zakończona sukcesem!"
echo "Pamiętaj o wylogowaniu i ponownym zalogowaniu, aby uprawnienia grupy docker zaczęły działać."
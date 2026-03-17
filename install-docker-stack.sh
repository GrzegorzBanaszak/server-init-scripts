#!/bin/bash


cd ~/
# Skrypt do automatycznej instalacji Dockera z poprawką uprawnień
set -e

echo "--- 1. Aktualizacja systemu ---"
sudo apt-get update && sudo apt-get upgrade -y

echo "--- 2. Instalacja narzędzi (curl, git, htop, ufw) ---"
sudo apt-get install -y curl git htop ufw

echo "--- 3. Instalacja Dockera ---"
curl -fsSL https://get.docker.com -o /tmp/get-docker.sh
sudo sh /tmp/get-docker.sh
rm /tmp/get-docker.sh # Sprzątamy po sobie

echo "--- 4. Konfiguracja uprawnień i usług ---"
# Upewniamy się, że grupa docker istnieje
sudo groupadd -f docker
# Dodajemy aktualnego użytkownika do grupy
sudo usermod -aG docker $USER
# Uruchamiamy i włączamy Docker przy starcie systemu
sudo systemctl enable --now docker

echo "--- 5. Instalacja Docker Compose ---"
sudo apt-get install -y docker-compose-plugin

echo "--- 6. Weryfikacja instalacji ---"
# Używamy 'sg', aby sprawdzić czy docker działa bez sudo jeszcze w trakcie działania skryptu
if sg docker -c "docker ps" > /dev/null 2>&1; then
    echo "✅ Docker działa poprawnie!"
else
    echo "❌ Coś poszło nie tak z uprawnieniami."
fi

echo "------------------------------------------------------------"
echo "🚀 INSTALACJA ZAKOŃCZONA!"
echo "Aby zacząć używać dockera w tym oknie terminala bez wylogowania,"
echo "wpisz teraz komendę:"
echo "          newgrp docker"
echo "------------------------------------------------------------"
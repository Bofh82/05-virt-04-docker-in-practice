#!/bin/bash

set -e

# 1. Клонируем репозиторий в /opt
cd /opt
if [ ! -d "05-virt-04-docker-in-practice" ]; then
  git clone https://github.com/Bofh82/05-virt-04-docker-in-practice.git
fi
cd 05-virt-04-docker-in-practice

# 2. Проверяем, что Docker и Docker Compose установлены
if ! command -v docker &> /dev/null; then
  echo "Docker не установлен! Установите Docker и повторите попытку."
  exit 1
fi

if ! docker compose version &> /dev/null; then
  echo "Docker Compose V2 не установлен! Установите Docker Compose V2 и повторите попытку."
  exit 1
fi

# 3. (Опционально) Копируем .env.example в .env, если .env не существует
if [ ! -f ".env" ] && [ -f ".env.example" ]; then
  cp .env.example .env
fi

# 4. Собираем и запускаем проект
docker compose up -d --build

echo "Проект успешно запущен! Проверьте логи командой: docker compose logs -f"
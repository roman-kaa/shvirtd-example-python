#!/usr/bin/env bash
set -euo pipefail

repo_url="https://github.com/roman-kaa/shvirtd-example-python.git"
project_dir="/opt/shvirtd-example-python"

if [[ "$(id -u)" -ne 0 ]]; then
    echo "Запустите скрипт с sudo: sudo bash deploy.sh" >&2
    exit 1
fi

if [[ -d "$project_dir/.git" ]]; then
    git -C "$project_dir" pull --ff-only
elif [[ -e "$project_dir" ]]; then
    echo "Путь $project_dir уже занят и не является Git-репозиторием" >&2
    exit 1
else
    git clone "$repo_url" "$project_dir"
fi

cd "$project_dir"
docker compose up -d --build
docker compose ps

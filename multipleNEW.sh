#!/bin/bash

    ARCH=$(uname -m)
    if [[ "$ARCH" == "x86_64" ]]; then
        CLIENT_URL="https://mdeck-download.s3.us-east-1.amazonaws.com/client/linux/x64/multipleforlinux.tar"
    elif [[ "$ARCH" == "aarch64" ]]; then
        CLIENT_URL="https://mdeck-download.s3.us-east-1.amazonaws.com/client/linux/arm64/multipleforlinux.tar"
    else
        echo -e "${RED}Неподдерживаемая архитектура системы: $ARCH${NC}"
        exit 1
    fi

    # Скачиваем и распаковываем клиент
    wget $CLIENT_URL -O multipleforlinux.tar
    tar -xvf multipleforlinux.tar
    cd multipleforlinux

    # Устанавливаем разрешения на выполнение
    chmod +x ./multiple-cli
    chmod +x ./multiple-node

    # Добавляем клиент в системный PATH
    echo "PATH=\$PATH:$(pwd)" >> ~/.bash_profile
    source ~/.bash_profile

    # Запуск ноды
    nohup ./multiple-node > output.log 2>&1 &

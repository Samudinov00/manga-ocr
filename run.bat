@echo off
chcp 65001 >nul
title BallonsTranslator

if not exist "venv\" (
    echo Виртуальное окружение не найдено.
    echo Сначала запустите setup.bat
    pause
    exit /b 1
)

venv\Scripts\python launch.py %*

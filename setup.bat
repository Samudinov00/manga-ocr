@echo off
chcp 65001 >nul
title Установка BallonsTranslator

echo ============================================
echo   Установка BallonsTranslator
echo ============================================
echo.

:: Проверяем Python
py -3.12 --version >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo [ОШИБКА] Python 3.12 не найден!
    echo.
    echo Скачайте и установите Python 3.12 отсюда:
    echo https://www.python.org/ftp/python/3.12.9/python-3.12.9-amd64.exe
    echo.
    echo ВАЖНО: при установке поставьте галочку "Add Python to PATH"
    echo.
    pause
    exit /b 1
)

echo [OK] Python 3.12 найден
echo.

:: Создаём виртуальное окружение
if not exist "venv\" (
    echo Создаю виртуальное окружение...
    py -3.12 -m venv venv
    if %ERRORLEVEL% NEQ 0 (
        echo [ОШИБКА] Не удалось создать виртуальное окружение
        pause
        exit /b 1
    )
    echo [OK] Виртуальное окружение создано
) else (
    echo [OK] Виртуальное окружение уже существует
)
echo.

:: Устанавливаем зависимости
echo Устанавливаю зависимости (это займёт несколько минут)...
echo.

venv\Scripts\pip install --prefer-binary spacy-pkuseg winsdk
if %ERRORLEVEL% NEQ 0 (
    echo [ОШИБКА] Не удалось установить spacy-pkuseg / winsdk
    pause
    exit /b 1
)

venv\Scripts\pip install --prefer-binary -r requirements.txt
if %ERRORLEVEL% NEQ 0 (
    echo [ОШИБКА] Не удалось установить зависимости
    pause
    exit /b 1
)

:: Устанавливаем torch с CUDA
echo.
echo Устанавливаю PyTorch с поддержкой NVIDIA GPU...
venv\Scripts\pip install torch==2.6.0 torchvision==0.21.0 --index-url https://download.pytorch.org/whl/cu118
if %ERRORLEVEL% NEQ 0 (
    echo [ПРЕДУПРЕЖДЕНИЕ] Не удалось установить GPU-версию PyTorch, устанавливаю CPU-версию...
    venv\Scripts\pip install torch==2.6.0 torchvision==0.21.0 --index-url https://download.pytorch.org/whl/cpu
)

echo.
echo ============================================
echo   Установка завершена успешно!
echo   Запустите run.bat для старта программы
echo ============================================
echo.
pause

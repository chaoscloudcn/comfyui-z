@echo off
chcp 65001 >nul
title 自动下载并解压 Python

:: 设置下载的 Python 版本及目标路径
set PYTHON_URL=https://mirrors.tuna.tsinghua.edu.cn/python/3.12.10/python-3.12.10-amd64.zip
set DOWNLOAD_DIR=%~dp0
set PYTHON_DIR=%DOWNLOAD_DIR%python

:: 显示下载和解压过程
echo =======================================
echo [INFO] 正在从清华镜像下载 Python...
echo =======================================
curl -L -o "%DOWNLOAD_DIR%\python.zip" %PYTHON_URL%

:: 检查下载是否成功
if not exist "%DOWNLOAD_DIR%\python.zip" (
    echo [ERROR] 下载失败，退出脚本。
    pause
    exit /b
)

echo =======================================
echo [INFO] 解压 Python 到指定目录...
echo =======================================
powershell -Command "Expand-Archive -Path '%DOWNLOAD_DIR%\python.zip' -DestinationPath '%PYTHON_DIR%'"

:: 检查解压是否成功
if exist "%PYTHON_DIR%\python.exe" (
    echo [INFO] Python 解压成功，路径：%PYTHON_DIR%
) else (
    echo [ERROR] Python 解压失败。
)

:: 清理下载的压缩包
del "%DOWNLOAD_DIR%\python.zip"
echo [INFO] 完成，已删除压缩包。

pause
exit /b

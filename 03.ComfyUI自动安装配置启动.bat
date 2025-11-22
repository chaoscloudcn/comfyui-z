@echo off
chcp 65001 >nul
title ComfyUI 环境检测与初始化
setlocal enabledelayedexpansion

echo =====================================
echo [INFO] ComfyUI 本地运行环境检测与初始化...
echo =====================================

:: --------------------------
:: 设置根目录与路径
:: --------------------------
set ROOT_DIR=%~dp0
set PYTHON_DIR=%ROOT_DIR%python
set GIT_DIR=%ROOT_DIR%git
set COMFYUI_DIR=%ROOT_DIR%ComfyUI
set PATH=%PYTHON_DIR%;%PYTHON_DIR%\Scripts;%GIT_DIR%\cmd;%GIT_DIR%\bin;%PATH%

:: --------------------------
:: 检查 Python 环境
:: --------------------------
echo =====================================
echo [INFO] 检测 Python 环境...
echo =====================================

if not exist "%PYTHON_DIR%\python.exe" (
    echo [ERROR] 未找到本地 Python，请先准备：%PYTHON_DIR%
    pause
    exit /b
)

for /f "tokens=2 delims= " %%i in ('"%PYTHON_DIR%\python.exe" --version') do set PY_VER=%%i
echo [INFO] 当前 Python 版本: %PY_VER%

:: 检查 Python 版本是否 >= 3.10
for /f "tokens=1-3 delims=." %%a in ("%PY_VER%") do (
    set PY_MAJOR=%%a
    set PY_MINOR=%%b
)

if %PY_MAJOR% LSS 3 (
    echo [ERROR] Python 版本过低，ComfyUI 需要 >= 3.10
    pause
    exit /b
) else if %PY_MAJOR%==3 if %PY_MINOR% LSS 10 (
    echo [ERROR] Python 版本过低，ComfyUI 需要 >= 3.10
    pause
    exit /b
) else (
    echo [INFO] Python 版本满足要求。
)

:: --------------------------
:: 检查 pip
:: --------------------------
echo =====================================
echo [INFO] 检测 pip 环境...
echo =====================================

"%PYTHON_DIR%\python.exe" -m pip --version > "%TEMP%\pip_ver.txt" 2>&1
set "PIP_VER="
for /f "tokens=2" %%i in ('type "%TEMP%\pip_ver.txt"') do (
    set "PIP_VER=%%i"
    goto :got_pip
)
:got_pip
if defined PIP_VER (
    echo [INFO] pip 当前版本: %PIP_VER%
) else (
    echo [WARNING] 未检测到 pip，正在自动安装 pip...
    "%PYTHON_DIR%\python.exe" -m ensurepip --upgrade
)

:: --------------------------
:: 检查 Git
:: --------------------------
echo =====================================
echo [INFO] 检测 Git 环境...
echo =====================================

if exist "%GIT_DIR%\cmd\git.exe" (
    echo [INFO] 本地 Git 已存在: %GIT_DIR%\cmd\git.exe
) else (
    echo [WARNING] 未检测到本地 Git！
    echo [TIP] 如果需要使用插件下载或管理，请准备 Portable Git 并解压至：
    echo        %GIT_DIR%
)

git --version >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    for /f "tokens=3 delims= " %%i in ('git --version') do set GIT_VER=%%i
    echo [INFO] Git 当前版本: %GIT_VER%
) else (
    echo [WARNING] 系统未检测到 Git，可跳过但部分功能会受限。
)

:: --------------------------
:: 检查 PyTorch 是否已安装且支持 CUDA
:: --------------------------
echo ===============================
echo [INFO] 检测 PyTorch 是否已安装
echo ===============================
"%PYTHON_DIR%\python.exe" -c "import torch" >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    "%PYTHON_DIR%\python.exe" -c "import torch; exit(0 if torch.cuda.is_available() else 1)"
    if %ERRORLEVEL% EQU 0 (
        echo [INFO] PyTorch 已安装且支持 GPU
    ) else (
        echo [WARN] PyTorch 不支持 GPU 或版本不对，重新安装
    )
) else (
    echo [INFO] 未检测到 PyTorch，准备安装...
)

:: --------------------------
:: 安装 GPU 版 PyTorch 2.8.0+cu128
:: --------------------------
echo ===============================
echo [INFO] 安装 GPU 版 PyTorch 2.8.0+cu128 到本地 Python
echo ===============================
"%PYTHON_DIR%\python.exe" -m pip install torch==2.8.0+cu128 torchvision torchaudio --index-url https://download.pytorch.org/whl/cu128

:: --------------------------
:: 检查 PyTorch 安装结果
:: --------------------------
echo ===============================
echo [INFO] PyTorch 安装完成，信息如下
echo ===============================
"%PYTHON_DIR%\python.exe" -c "import torch; print('PyTorch:', torch.__version__); print('CUDA:', torch.version.cuda); print('CUDA Available:', torch.cuda.is_available()); print('Device Name:', torch.cuda.get_device_name(0))"

:: --------------------------
:: 检查 ComfyUI 目录
:: --------------------------
echo =====================================
echo [INFO] 检查 ComfyUI 目录...
echo =====================================

if exist "%COMFYUI_DIR%\README.md" (
    echo [INFO] ComfyUI 目录已存在，跳过下载
) else (
    echo [INFO] 克隆 ComfyUI 仓库到 %COMFYUI_DIR%
    "%GIT_DIR%\cmd\git.exe" clone https://github.com/comfyanonymous/ComfyUI.git "%COMFYUI_DIR%"
    if %ERRORLEVEL% NEQ 0 (
        echo [ERROR] Git 克隆失败，请检查网络或 Git 配置
        pause
        exit /b
    )
)

:: --------------------------
:: 安装 ComfyUI 依赖
:: --------------------------
echo ===============================
echo [INFO] 安装 ComfyUI 依赖
echo ===============================
"%PYTHON_DIR%\python.exe" -m pip install -r "%COMFYUI_DIR%\requirements.txt" -i https://pypi.tuna.tsinghua.edu.cn/simple

:: --------------------------
:: 启动 ComfyUI
:: --------------------------
echo ===============================
echo [INFO] 启动 ComfyUI...
echo ===============================
cd /d "%COMFYUI_DIR%"
"%PYTHON_DIR%\python.exe" main.py

pause


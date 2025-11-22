@echo off
chcp 65001 >nul
setlocal

REM 强制使用 UTF-8 编码
set PYTHONUTF8=1

REM =====================================================
REM 获取根目录和工具路径
REM =====================================================
set ROOT_DIR=%~dp0
set COMFYUI_DIR=%ROOT_DIR%ComfyUI
set PYTHON_DIR=%ROOT_DIR%python\python.exe

REM =====================================================
REM 升级 pip、setuptools 和 wheel
REM =====================================================
echo [INFO] 升级 pip、setuptools 和 wheel...
"%PYTHON_DIR%" -m pip install --upgrade pip setuptools wheel

REM =====================================================
REM 安装 argos-translate 包
REM =====================================================
echo [INFO] 正在安装 argos-translate...
"%PYTHON_DIR%" -m pip install git+https://github.com/argosopentech/argos-translate.git@08f017c324628434d671cf4d191ce681c620ff33

REM =====================================================
REM 检查是否安装成功
REM =====================================================
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] 安装失败，请检查错误信息！
    pause
    exit /b %ERRORLEVEL%
)

REM =====================================================
REM 启动 ComfyUI
REM =====================================================
echo [INFO] 启动 ComfyUI...
cd %COMFYUI_DIR%
"%PYTHON_DIR%" main.py

REM 等待按键退出
pause
endlocal

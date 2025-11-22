@echo off
:: 设置控制台编码为 UTF-8
chcp 65001 >nul

:: 获取当前脚本目录（相对路径）
set ROOT_DIR=%~dp0

:: 设置 Python 环境和脚本路径
set PYTHON_PATH=%ROOT_DIR%python\python.exe
set SCRIPT_PATH=%ROOT_DIR%ComfyUI-Manageran.py
set CUSTOM_NODES_DIR=%ROOT_DIR%ComfyUI\custom_nodes

:: 打印开始信息
echo ===================================
echo [INFO] 正在启动 ComfyUI 依赖检查...
echo ===================================

:: 检查 ComfyUI-Manager 是否已经下载到目标目录
echo ====================================
echo [INFO] 检查 ComfyUI-Manager 是否已经安装...
echo ====================================
if exist "%CUSTOM_NODES_DIR%\ComfyUI-Manager" (
    echo ComfyUI-Manager 已安装，跳过下载。
) else (
    echo ComfyUI-Manager 未安装，正在从 GitHub 下载...
    git clone https://github.com/Comfy-Org/ComfyUI-Manager.git "%CUSTOM_NODES_DIR%\ComfyUI-Manager"
    echo ComfyUI-Manager 安装完成！
)

:: 执行 Python 脚本进行依赖检查
echo ====================================
echo [INFO] 正在执行 ComfyUI 依赖检查...
echo ====================================
"%PYTHON_PATH%" "%SCRIPT_PATH%"

:: 打印结束信息
echo ===================================
echo [INFO] ComfyUI 依赖检查完成！
echo ===================================
pause

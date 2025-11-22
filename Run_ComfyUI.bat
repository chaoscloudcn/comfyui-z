@echo off
chcp 65001 >nul
setlocal


REM =====================================================
REM 根目录和工具路径
REM =====================================================
set ROOT_DIR=%~dp0
set COMFYUI_DIR=%ROOT_DIR%ComfyUI
set PYTHON_DIR=%ROOT_DIR%python

REM =====================================================
REM 启动 ComfyUI
REM =====================================================
cd %COMFYUI_DIR%
%PYTHON_DIR%\python main.py

pause  
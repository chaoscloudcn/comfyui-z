@echo off
chcp 65001 >nul
setlocal

REM 获取当前脚本所在的根目录路径
set ROOT_DIR=%~dp0

REM 设置 Python 可执行文件路径和 site-packages 目录路径
set PYTHON_PATH=%ROOT_DIR%python\python.exe
set SITE_PACKAGES_DIR=%ROOT_DIR%python\Lib\site-packages

REM 获取 site-packages 目录下的所有已安装包
echo [INFO] 正在列出所有已安装的包...
for /f "delims=" %%i in ('"%PYTHON_PATH%" -m pip freeze --path "%SITE_PACKAGES_DIR%"') do (
    REM 执行卸载每个包
    echo 正在卸载: %%i
    "%PYTHON_PATH%" -m pip uninstall -y %%i
)

echo [INFO] 所有依赖已成功卸载.

endlocal
pause

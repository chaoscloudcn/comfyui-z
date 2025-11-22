import os
import subprocess
from typing import List

# 使用相对路径设置插件路径和依赖文件路径
ROOT_DIR = os.path.dirname(os.path.abspath(__file__))  # 获取当前脚本的目录
CUSTOM_NODES_DIR = os.path.join(ROOT_DIR, "ComfyUI", "custom_nodes")
REQUIREMENTS_FILE = os.path.join(CUSTOM_NODES_DIR, "ComfyUI-Manager", "requirements.txt")
SITE_PACKAGES_DIR = os.path.join(ROOT_DIR, "python", "Lib", "site-packages")

def normalize_package_name(pkg_name: str) -> str:
    """ 标准化包名称，处理破折号和下划线的差异 """
    return pkg_name.replace("-", "_").lower()

def get_installed_packages() -> List[str]:
    """ 获取已安装的依赖包及其版本 """
    installed_packages = subprocess.check_output([os.path.join(ROOT_DIR, "python", "python.exe"), "-m", "pip", "freeze"], universal_newlines=True)
    print("已安装的所有包和版本：")
    print(installed_packages)  # 打印所有已安装的包和版本
    return installed_packages.strip().split("\n")

def parse_requirements(requirements_file: str) -> List[str]:
    """ 解析 requirements.txt 文件 """
    with open(requirements_file, 'r', encoding='utf-8') as f:
        return [line.strip() for line in f if line.strip()]

def check_and_install_dependencies():
    """ 检查缺失的依赖并直接安装 """
    print("正在获取本地已安装依赖版本...")
    installed_packages = get_installed_packages()
    print("已安装依赖列表：")
    print("------------------------")
    print("\n".join(installed_packages))
    print()

    print("插件 requirements.txt 内容：")
    print("------------------------")
    requirements = parse_requirements(REQUIREMENTS_FILE)
    print("\n".join(requirements))
    print()

    missing = 0
    install_cmds = []

    for pkg_line in requirements:
        pkg_name = pkg_line.split('==')[0].strip()
        required_ver = pkg_line.split('==')[1].strip() if '==' in pkg_line else None

        # 标准化包名称
        normalized_pkg_name = normalize_package_name(pkg_name)

        print(f"-----------------------------------------")
        print(f"依赖包: {pkg_name}")
        print(f"插件要求版本: {required_ver if required_ver else '没有指定版本'}")

        # 查找已安装版本
        installed_ver = None
        for installed_pkg in installed_packages:
            installed_pkg_name = installed_pkg.split("==")[0].strip()
            normalized_installed_pkg_name = normalize_package_name(installed_pkg_name)

            if normalized_installed_pkg_name == normalized_pkg_name:
                installed_ver = installed_pkg.split("==")[1] if "==" in installed_pkg else None
                break

        print(f"本地已安装版本: {installed_ver if installed_ver else '未安装'}")

        if required_ver:
            # 本地未安装或版本不匹配
            if not installed_ver or installed_ver != required_ver:
                print(f"本地未安装或版本不匹配 → 将安装: {pkg_name}=={required_ver}")
                missing += 1
                install_cmds.append(f"{pkg_name}=={required_ver}")
        else:
            # 插件未指定版本
            if not installed_ver:
                print(f"本地未安装 → 将安装最新版本: {pkg_name}")
                missing += 1
                install_cmds.append(pkg_name)

    print(f"\n缺失依赖: {missing}")
    print()

    if missing > 0:
        print("正在安装缺失依赖...")
        for cmd in install_cmds:
            print(f"运行: pip install {cmd}")
            subprocess.run([os.path.join(ROOT_DIR, "python", "python.exe"), "-m", "pip", "install", cmd])

    print("\n所有依赖处理完成！")

if __name__ == "__main__":
    check_and_install_dependencies()

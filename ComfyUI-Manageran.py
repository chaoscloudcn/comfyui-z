import os
import subprocess
from typing import List

# 使用相对路径设置插件路径和依赖文件路径
ROOT_DIR = os.path.dirname(os.path.abspath(__file__))  # 获取当前脚本的目录
CUSTOM_NODES_DIR = os.path.join(ROOT_DIR, "ComfyUI", "custom_nodes")
REQUIREMENTS_FILE = os.path.join(CUSTOM_NODES_DIR, "ComfyUI-Manager", "requirements.txt")
SITE_PACKAGES_DIR = os.path.join(ROOT_DIR, "python", "Lib", "site-packages")

def parse_requirements(requirements_file: str) -> List[str]:
    """ 解析 requirements.txt 文件 """
    with open(requirements_file, 'r', encoding='utf-8') as f:
        return [line.strip() for line in f if line.strip()]

def install_dependencies():
    """ 按顺序安装 requirements.txt 中的依赖 """
    print("插件 requirements.txt 内容：")
    print("------------------------")
    requirements = parse_requirements(REQUIREMENTS_FILE)
    print("\n".join(requirements))
    print()

    for pkg_line in requirements:
        # 直接安装插件要求的依赖
        print(f"正在安装: {pkg_line}")
        subprocess.run([os.path.join(ROOT_DIR, "python", "python.exe"), "-m", "pip", "install", pkg_line])

    print("\n所有依赖安装完成！")

if __name__ == "__main__":
    install_dependencies()

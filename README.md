comfyui整合包很多

对于一些有精神洁癖的人，总是想自己搞一个按照自己需求安装插件的整合

为了实现这个目的我决定做一个简单的帮助普通人都可以使用的comfyui整合包

90%学习comfyui的用户都被挡在了安装comfyui的路上

-----------------------------------------------------------------
我先讲解一下基础

comfyui部署，首先保证硬盘有2T的 7000兆每秒的固态硬盘  

-----------------------------------------------------------------
硬盘划分 硬盘C盘 500G D盘 1.5T

目录结构创建

首先在D盘创建一个目录 

D:\ComfyUI-2025-11-19  这是根目录 叫什么名称都可以就是--举个例子   

-----------------------------------------------------------------
第一步 下载 01.国内镜像下载Python3.12.10.bat 到 D:\ComfyUI-2025-11-19

然后点击运行，会自动创建 自动下载 Python 压缩包 自动解压到 D:\ComfyUI-2025-11-19\python

这一步主要是下载comfyui需要使用的 创建虚拟环境 Python.exe

-----------------------------------------------------------------
第二步 下载 git
下载地址：
https://mirrors.tuna.tsinghua.edu.cn/github-release/git-for-windows/git/Git%20for%20Windows%20v2.52.0.windows.1/Git-2.52.0-64-bit.tar.bz2

解压到根目录 Git-2.52.0-64-bit.tar.bz2 

修改目录名称 D:\ComfyUI-2025-11-19\git

-----------------------------------------------------------------
第三步 下载 03.ComfyUI自动安装配置启动.bat

然后点击运行，会自动调用 Python git 下载 https://github.com/comfyanonymous/ComfyUI.git

自动解压创建 D:\ComfyUI-2025-11-19\ComfyUI

这个是ComfyUI主程序目录 

自动获取 https://download.pytorch.org/whl/cu128  安装 GPU 版 PyTorch 2.8.0+cu128 到本地 Python 虚拟环境

自动获取 D:\ComfyUI-2025-11-19\ComfyUI\requirements.txt 安装依赖

测试启动 ComfyUI

-----------------------------------------------------------------
第四步 下载 04.插件安装ComfyUI-Manageran安装.bat  ComfyUI-Manageran.py

然后点击运行，会自动调用 Python git 下载 ComfyUI-Manageran 安装 D:\ComfyUI-2025-11-19\ComfyUI\custom_nodes

ComfyUI-Manageran.py 自动获取 D:\ComfyUI-2025-11-19\ComfyUI\custom_nodes\requirements.txt 安装所需依赖

测试启动 ComfyUI

到这里就已经安装完成一个干净的comfyui了

-----------------------------------------------------------------
第五步 下载 Run_ComfyUI.bat 正常启动comfyui

打印显示 To see the GUI go to: http://127.0.0.1:8188

复制 http://127.0.0.1:8188 浏览器访问就可以了 这里没做IE弹出

-----------------------------------------------------------------
初始安装就到这里，接下来是自己安装所需要的插件

浏览器访问 http://127.0.0.1:8188 先在安装ComfyUI界面汉化插件

使用 ComfyUI Manager 安装插件

搜索 ComfyUI-DD-Translation 然后正常 安装 重启ComfyUI，自动安装下载依赖

-----------------------------------------------------------------
推荐安装常用插件

comfyui_controlnet_aux

comfyui_custom_nodes_alekpet

comfyui_ipadapter_plus

comfyui_ultimatesdupscale

comfyui-custom-scripts

ComfyUI-DD-Translation

ComfyUI-GGUF

comfyui-ic-light

ComfyUI-Impact-Pack

ComfyUI-Inspire-Pack

ComfyUI-JoyCaption

comfyui-kjnodes

ComfyUI-layerdiffuse

ComfyUI-Manager

-----------------------------------------------------------------
![图片描述](https://github.com/chaoscloudcn/comfyui-dependency-checker/blob/main/20250630173445.png?raw=true)

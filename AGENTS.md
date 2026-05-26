用于维护不同机器上的配置文件

使用方式：
将本仓库clone到home下，然后将对应软件的配置文件软连接指向本仓库

server是linux服务器通用配置

zshThemes 存放 Oh My Zsh 主题文件。主题源文件以本仓库为准，实际使用时将 `~/.oh-my-zsh/custom/themes/<name>.zsh-theme` 软链接到本目录下对应文件；修改主题时直接改仓库内文件，不直接编辑 Oh My Zsh custom 目录里的软链接目标。

# tmux
ln -sf ~/dotfiles/tmux/tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/tmux/tmux.conf.local ~/.tmux.conf.local

# Wezterm
rm -rf ~/.config/wezterm.bak/
mv ~/.config/wezterm ~/.config/wezterm.bak
ln -sf ~/dotfiles/wezterm ~/.config/wezterm

#!/usr/bin/env python
# init_py_dont_write_bytecode

#init_boilerplate

from fabric.api import *
from fabric.colors import *
from fabric.context_managers import *
from fabric.contrib.project import *

branch_list=['feature/troubleshoot-package-chromium-browser',
  'feature/troubleshoot-package-containerd.io',
  'feature/troubleshoot-package-curl',
  'feature/troubleshoot-package-docker-ce-cli',
  'feature/troubleshoot-package-folder-color',
  'feature/troubleshoot-package-htop',
  'feature/troubleshoot-package-httpie',
  'feature/troubleshoot-package-zsh-syntax-highlighting',
  'feature/troublsehoot-package-docker-ce',
  'feature/troublsehoot-package-filezilla',
  'feature/troublsehoot-package-gnome-mpv',
  'feature/troublsehoot-package-gnome-shell-extension',
  'feature/troublsehoot-package-ibus-table-cangjie3',
  'feature/troublsehoot-package-imwheel',
  'feature/troublsehoot-package-p7zip-full',
  'feature/troublsehoot-package-pycharm-community',
  'feature/troublsehoot-package-slack-desktop',
  'feature/troublsehoot-package-spotify-client',
  'feature/troublsehoot-package-tmate',
  'feature/troublsehoot-package-tmux',
  'feature/troublsehoot-package-tree',
  'feature/troublsehoot-package-vscode',
  'feature/troublsehoot-package-wget',
  'feature/troublsehoot-package-zsh']


for branch in branch_list:
    local('git checkout %s' % branch)
    local('git merge --commit feature/file-io-tryout')
    local('git push --set-upstream origin %s' % branch)

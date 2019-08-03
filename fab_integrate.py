#!/usr/bin/env python
# init_py_dont_write_bytecode

#init_boilerplate

from fabric.api import *
from fabric.colors import *
from fabric.context_managers import *
from fabric.contrib.project import *

branch_list='''feature/add-slack-announcement
feature/apt_install_chromium-browser
feature/apt_install_containerd.io
feature/apt_install_curl
feature/apt_install_docker-ce
feature/apt_install_docker-ce-cli
feature/apt_install_filezilla
feature/apt_install_htop
feature/apt_install_httpie
feature/apt_install_ibus-table-cangjie3
feature/apt_install_imwheel
feature/apt_install_mongodb
feature/apt_install_p7zip-full
feature/apt_install_pycharm-community
feature/apt_install_slack-desktop
feature/apt_install_spotify-client
feature/apt_install_tmate
feature/apt_install_tmux
feature/apt_install_tree
feature/apt_install_wget
feature/apt_install_zsh
feature/apt_install_zsh-syntax-highlighting
feature/auto-merge-tryout
feature/build_script
feature/fabfile
feature/file-io-tryout
feature/fix-isprespin_sh
feature/remove-sendanywhere
feature/test
feature/test-travis-caching
feature/try-integrate
feature/update-build-script
feature/upload-to-transfer_sh
'''


for branch in branch_list.split('\n'):
    local('git checkout %s' % branch)
    local('git merge --commit feature/apt_install_tryout')
    local('git push')
    # local('git push --set-upstream origin %s' % branch)

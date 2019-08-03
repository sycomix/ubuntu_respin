#!/usr/bin/env python
# init_py_dont_write_bytecode

#init_boilerplate

from fabric.api import *
from fabric.colors import *
from fabric.context_managers import *
from fabric.contrib.project import *


import multiprocessing
total_cpu_threads = multiprocessing.cpu_count()

sw_list='''zsh-syntax-highlighting
filezilla
chromium-browser
p7zip-full
docker-ce
docker-ce-cli
containerd.io
pycharm-community
slack-desktop
spotify-client'''

for sw in sw_list.split('\n'):
    local('git checkout feature/apt_install_tryout')
    local('git checkout -b feature/apt_install_%s' % sw)
    local('git push --set-upstream origin feature/apt_install_%s' % sw)

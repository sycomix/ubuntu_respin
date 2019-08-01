#!/usr/bin/env  python3

import os,sys

from fabric.api import *
from fabric.colors import *
from fabric.context_managers import *
from fabric.contrib.project import *


import multiprocessing
total_cpu_threads = multiprocessing.cpu_count()

def helloworld():
    with lcd(os.path.dirname(__file__)):
        with settings(warn_only=True):
            local('rm -rf ./origin/*')
            local('mkdir ./origin')
            local('mkdir ./destination')
            local('wget http://releases.ubuntu.com/19.04/ubuntu-19.04-desktop-amd64.iso -O ./origin/origin.iso')
            # local('wget http://ftp.cuhk.edu.hk/pub/Linux/ubuntu-releases/19.04/ubuntu-19.04-desktop-amd64.iso -O ./origin/origin.iso')
            local('rm -rf .isorespin.sh.lock')
            local('rm -rf ./linuxium*.iso')
            local('sudo rm -rf ./isorespin')
            local('./build.sh  ./origin/origin.iso -c bionicbeaver')

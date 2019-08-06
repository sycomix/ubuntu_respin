#!/usr/bin/env  python3

import os,sys

from chalk import *

from fabric.api import *
from fabric.colors import *
from fabric.context_managers import *
from fabric.contrib.project import *


import multiprocessing
total_cpu_threads = multiprocessing.cpu_count()

CWD = os.path.dirname(__file__)
iso_filename = 'linuxium-v5.3-rc2-origin.iso'
output_iso = os.path.join(CWD,iso_filename)
isorespin_log_path = os.path.join(CWD, 'isorespin.log')


print("CWD: %s" % CWD)

def get_system_info():
    local('df -kh')
    local('free')
    local('date')


def get_file_info(file_path):
    with lcd(CWD):
        local('ls -l %s' % file_path)

def upload_to_file_io(local_filepath):
    expire='?expires=1w'
    if check_iso_exist(local_filepath):
        with lcd(CWD):
            print()
            print(green('upload to file.io %s' % local_filepath))
            local('curl -F "file=@%s" https://file.io%s' % (local_filepath, expire))
            print()
            print(green('upload done'))
    else:
        print(red('the output iso file not exist'))

def get_hostname():
    hostname = local('hostname', capture=True)
    return hostname.strip()

def upload_to_transfer_sh():
    if check_iso_exist(output_iso):
        with lcd(CWD):
            local("curl --upload-file %s https://transfer.sh/%s " % (output_iso, iso_filename))
            print()
            print(green('upload done'))
    else:
        print(red('the output iso file not exist'))


def check_iso_exist(target_iso):
    if os.path.exists(target_iso):
        return True
    else:
        return False

def helloworld():
    with lcd(CWD), settings(warn_only=False):
        # local('rm -rf ./origin/*.iso')

        if check_iso_exist(os.path.join(CWD,'origin/origin.iso')):
            print(yellow("iso file exist, skipping download"))
            pass
        else:
            print(yellow("iso file not exist, download from ubuntu"))
            if get_hostname() in['logic-ThinkCentre-M73', 'logic-ThinkPad-X201']:
                local('wget http://ftp.cuhk.edu.hk/pub/Linux/ubuntu-releases/19.04/ubuntu-19.04-desktop-amd64.iso -O ./origin/origin.iso')
            else:
                local('wget http://releases.ubuntu.com/19.04/ubuntu-19.04-desktop-amd64.iso -O ./origin/origin.iso')

        local('rm -rf ./destination/*.iso')
        local('rm -rf .isorespin.sh.lock')
        local('rm -rf ./linuxium*.iso')
        local('sudo rm -rf ./isorespin')
        print("clear directory done")
        local('./build.sh  ./origin/origin.iso -c bionicbeaver')
        print(green("isprespin done"))


        print(yellow('print system info:'))
        print(green('file info:'))
        print(green('-'*80))
        print(get_file_info(output_iso))
        print(get_system_info())

def upload():
    print(yellow('starting upload'))
    # upload_to_transfer_sh()
    upload_to_file_io(output_iso)
    upload_to_file_io(isorespin_log_path)

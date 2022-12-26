#!/usr/bin/python3
"""A fabric python script that generates a .tgz archive from the
contents of the web_static folder
"""
from datetime import datetime
from os.path import isdir
from fabric.api import *


def do_pack():
    """This method creates a tar archive of the directory web_static"""
    date = datetime.now()
    archivePath = "web_static_" + date.strftime("%Y%m%d%H%M%S") + "." + "tgz"

    if isdir("versions") is False:
            local("mkdir -p versions")

    createdFile = local("tar -cvzf versions/{} web_static".format(archivePath))

    if createdFile is not None:
        return archivePath
    else:
        return None

#!/usr/bin/env python
# This script runs during all the builds. It triggers actual builds
# if run in spawn mode or simulates the builds if run in build mode.

from __future__ import print_function

import os
import sys
import time
import urllib
import urlparse


def configure_env(foo, bar):
    seconds = 5
    if foo == 'one' and bar == 'good':
        seconds = 1
    if foo == 'one' and bar == 'ugly':
        return None
    if foo == 'two' and bar == 'bad':
        return None
    if foo == 'two' and bar == 'ugly':
        seconds = 15

    return {'config': {'foo': foo, 'bar': bar}, 'seconds': seconds}


def make_build_matrix():
    return filter(None, [configure_env(foo, bar)
                         for foo in ['one', 'two']
                         for bar in ['good', 'bad', 'ugly']])


if __name__ == '__main__':
    if len(sys.argv) < 2:
        sys.exit('usage: {} [matrix|BUILD]'.format(os.path.basename(__file__)))

    mode = sys.argv[1]
    build_matrix = make_build_matrix()

    if mode == 'matrix':
        for env in build_matrix:
            print(urllib.urlencode(env['config']))
    else:
        config = urlparse.parse_qs(mode)
        for key in config:
            config[key] = config[key][0]
        envs = [env for env in build_matrix if env['config'] == config]
        if len(envs) == 0:
            sys.exit('unknown build environment: ' + mode)
        env = envs[0]
        sys.stderr.write('Initiating build: {}\n'.format(mode))
        for i in range(env['seconds']):
            time.sleep(1)
            print('Build step {} complete'.format(i + 1))
        sys.stderr.write('Build successful.\n')

# coding=utf-8
import os
import sys
import atexit
from pprint import pprint

try:
    import readline
except ImportError:
    print("Module readline not available")
else:
    import rlcompleter

    readline.parse_and_bind("tab: complete")


def display_hook(value, pprint=pprint):
    if value is not None:
        global _
        _ = value
        pprint(value)


sys.displayhook = display_hook
history_path = os.path.expanduser("~/.pyhistory")


@atexit.register
def save_history(path=history_path):
    import readline

    readline.write_history_file(path)


if os.path.exists(history_path):
    readline.read_history_file(history_path)


del rlcompleter
del readline
del display_hook
del atexit
del save_history
del history_path
del sys
del os
del pprint

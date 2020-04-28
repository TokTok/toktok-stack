"""Entry point for YouCompleteMe."""

import os
import sys

SELF_DIR = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(SELF_DIR))
sys.path.append(os.path.join(SELF_DIR, "tools", "kythe"))
# pylint: disable=wrong-import-position,unused-import
from tools.kythe.ycm_extra_conf import Settings

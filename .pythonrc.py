# import importlib
import readline
import sys

# sys.path.insert(0, "/Users/bryanhu/.local/pipx/venvs")
# importlib.import_module("rich.pretty").install()
# A red prompt and a cyan continuing prompt
sys.ps1 = "\r\033[31m>>> \033[0m"
sys.ps2 = "\r\033[36m... \033[0m"  # TODO: Make purple

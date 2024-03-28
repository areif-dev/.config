#!/usr/bin/env python3

import sys
import os


def main():
    special_paths = {
        "alacritty": os.path.expandvars("$HOME/.config"),
        "bashrc": os.path.expandvars("$HOME"),
        "starship": os.path.expandvars("$HOME/.config"),
    }

    script_dir = os.path.dirname(os.path.realpath(__file__))

    # Make sure that the install script is running in the correct directory by
    # looking for the special paths
    for field in special_paths:
        if not os.path.isdir(f"{script_dir}/{field}"):
            print(f"Directory {field} was not found in {os.path.dirname(os.path.realpath(__file__))}. Are you sure the install script is in the correct location?")
            return 1 

    for _, dirs, _ in os.walk(script_dir):
        for cur_dir in dirs:
            if cur_dir == ".git":
                continue

            if cur_dir in special_paths:
                for _, _, files in os.walk(os.path.join(script_dir, cur_dir)):
                    print(files)

    
if __name__ == "__main__":
    main()

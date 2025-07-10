#!/usr/bin/env -S uv run --with termcolor

import argparse
import tomllib
import subprocess
from termcolor import colored

def diffs(args, cfg):
    if "dir" in cfg:
        print(colored("dirs aren't supported yet", "red"))

    for file in cfg["file"]:
        print(colored(
            f"diff {file["source"]} {file["target"]}",
            attrs=["bold"]
        ))
        subproc = subprocess.run(["/bin/sh", "-c", f"diff {file["source"]} {file["target"]}"], stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
        if len(subproc.stdout) == 0:
            print(colored("No diff", "green"))
        else:
            print(subproc.stdout.decode("utf-8"), end="")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        prog="config_sync",
    )
    parser.add_argument(
        "-c", "--config-file",
        default="./config_sync.toml"
    )
    subparsers = parser.add_subparsers(dest="command", required=True)

    parser_diff = subparsers.add_parser("diff")
    parser_diff.set_defaults(func=diffs)

    args = parser.parse_args()
    print("Config file:", args.config_file)

    config_file = open(args.config_file, "rb")

    args.func(args, tomllib.load(config_file))

#!/usr/bin/env -S uv run --with termcolor

import argparse
import tomllib
import subprocess
import os
from pathlib import Path
from termcolor import colored


def remove_dirs(paths):
    for p in paths:
        path = os.path.expanduser(p)
        if os.path.isdir(path):
            paths.remove(path)


def diff_file(src, tgt, pre=""):
    source = Path(src).expanduser()
    target = Path(tgt).expanduser()
    print(pre + colored(f"diff {str(source)} {str(target)}", attrs=["bold"]))

    if not source.exists():
        print(pre + colored("Source does not exist", "red"))
    if not target.exists():
        print(pre + colored("Target does not exist", "yellow"))
    if not (source.exists() and target.exists()):
        return

    subproc = subprocess.run(
        ["/usr/bin/diff", "--color=always", str(source), str(target)],
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
    )
    if len(subproc.stdout) == 0:
        print(pre + colored("No diff", "green"))
    else:
        print(pre + subproc.stdout.decode("utf-8").replace("\n", "\n" + pre), end="")


def diffs(args, cfg):
    for file in cfg["file"]:
        diff_file(file["source"], file["target"])
    for dir in cfg["dir"]:
        source = Path(dir["source"]).expanduser()
        target = Path(dir["target"]).expanduser()
        exact = dir.get("exact", False)

        print(colored(f"Dir '{source}' -> '{target}'; Exact? {exact}", attrs=["bold"]))

        if not source.exists():
            print(colored("Source does not exist", "red"))
        if not target.exists():
            print(colored("Target does not exist", "yellow"))
        if not (source.exists() and target.exists()):
            continue

        source_dirs = {}
        for dirpath, dirs, files in source.walk():
            dirpath = str(dirpath.relative_to(source))
            source_dirs[os.fspath(dirpath)] = (dirs, files)

        if exact:
            target_dirs = {}
            for dirpath, dirs, files in target.walk():
                dirpath = str(dirpath.relative_to(target))
                target_dirs[os.fspath(dirpath)] = (dirs, files)

            for dirname, contents in target_dirs.items():
                for file in contents[1]:
                    if (
                        dirname not in source_dirs
                        or file not in source_dirs[dirname][1]
                    ):
                        print(
                            colored(
                                f"  File found where it should not be: '{os.path.join(target, dirname, file)}'",
                                "yellow",
                            )
                        )
        for dirname, contents in source_dirs.items():
            for file in contents[1]:
                diff_file(
                    os.path.join(source, dirname, file),
                    os.path.join(target, dirname, file),
                    "  ",
                )


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        prog="config_sync",
    )
    parser.add_argument("-c", "--config-file", default="./config_sync.toml")
    subparsers = parser.add_subparsers(dest="command", required=True)

    parser_diff = subparsers.add_parser("diff")
    parser_diff.set_defaults(func=diffs)

    args = parser.parse_args()
    print("Config file:", args.config_file)

    config_file = open(args.config_file, "rb")

    args.func(args, tomllib.load(config_file))

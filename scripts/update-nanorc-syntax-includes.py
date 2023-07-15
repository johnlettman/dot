"""
Scan a directory for nano syntax-highlighting definitions and update a nanorc
file to include them.
"""
import re
from pathlib import Path
from functools import reduce
from argparse import ArgumentParser, ArgumentDefaultsHelpFormatter
from typing import Generator, List

from _utils import repo_dir, diff

default_nanorc_path = repo_dir.joinpath('nano/nanorc')
default_syntax_path = repo_dir.joinpath('nano/syntax-highlighting')

header = (
    '#######################\n'
    '# Syntax highlighting #\n'
    '#######################\n'
)

expression_nanorc_main = re.compile(
    r'\#{2,}[\r\n]'                                 # header start
    r'\#\s*syntax\s*highlight(s|ing)?\s*\#[\r\n]'   # "syntax highlighting"
    r'\#{2,}'                                       # header end
    r'([\r\n\s]+include ".+")+',                    # include directives
    re.MULTILINE | re.IGNORECASE)

expression_nanorc_syntax = re.compile(r'^\s*syntax\s+".*?"\s+".*?')


def find_nanorc_syntax_paths(dir_path: Path | str) -> Generator[Path,
                                                                None, None]:
    dir_path = Path(dir_path)
    if not dir_path.is_dir():
        raise ValueError("expected a directory path")
    
    for rc in dir_path.iterdir():
        with open(rc, 'r') as fd:
            for line in fd:
                if expression_nanorc_syntax.findall(line):
                    yield rc
                    break


def include_directive(rc_path: Path | str) -> str:
    rc_path = Path(rc_path)
    if not rc_path.exists() or not rc_path.is_file():
        raise ValueError("expected a file path")

    return f'include "{rc_path}"'


def update_syntax_includes(nanorc: str, syntax_path: Path | str, 
                           ignore_paths: List[Path | str]) -> str:
    paths = find_nanorc_syntax_paths(syntax_path)
    filtered_paths = filter(lambda p: p not in ignore_paths, paths)
    directives = map(lambda p: include_directive(p), filtered_paths)
    chunk = reduce(lambda d, s: '\n'.join([d, s]), directives, '').strip()

    return re.sub(expression_nanorc_main,
                  f'{header}{chunk}',
                  nanorc)


def get_updated_syntax_includes(nanorc_path: Path | str, 
                                syntax_path: Path | str,
                                ignore_paths: List[Path | str]) -> str:    
    with open(nanorc_path, 'r') as fd:
        nanorc = fd.read()

    return update_syntax_includes(nanorc, syntax_path, ignore_paths)


def diff_updated_syntax_includes(nanorc_path: Path | str, 
                                 syntax_path: Path | str,
                                 ignore_paths: List[Path | str]) -> str:
    with open(nanorc_path, 'r') as fd:
        nanorc = fd.read()

    updated_nanorc = get_updated_syntax_includes(nanorc_path,
                                                 syntax_path,
                                                 ignore_paths)
    return diff([nanorc, updated_nanorc])


def save_updated_syntax_includes(nanorc_path: Path | str, 
                                 syntax_path: Path | str,
                                 ignore_paths: List[Path | str]):
    updated_nanorc = get_updated_syntax_includes(nanorc_path,
                                                 syntax_path,
                                                 ignore_paths)
    with open(nanorc_path, 'w') as fd:
        fd.write(updated_nanorc)


def parse_args():
    parser = ArgumentParser(description=__doc__,
                            formatter_class=ArgumentDefaultsHelpFormatter)

    parser.add_argument('nanorc_path',
                        metavar='NANORC_PATH',
                        nargs='?',
                        type=Path,
                        default=default_nanorc_path,
                        help='path to nanorc file')

    parser.add_argument('syntax_path',
                        metavar='SYNTAX_PATH',
                        nargs='?',
                        type=Path,
                        default=default_syntax_path,
                        help='path to the nano syntax highlighting directory')

    parser.add_argument('-i', '--ignore',
                        metavar='IGNORE_PATH',
                        type=Path,
                        default=[],
                        action='append',
                        help='ignore and exclude a specified path '
                        'from being included')
    
    parser.add_argument('-d', '--diff',
                        action='store_true',
                        help='display differences')
    
    parser.add_argument('-s', '--save',
                        action='store_true',
                        help='save changes to original file at NANORC_PATH')

    return parser.parse_args()


def main():
    args = parse_args()

    if args.diff:
        print(diff_updated_syntax_includes(args.nanorc_path,
                                           args.syntax_path,
                                           args.ignore))
    elif args.save:
        save_updated_syntax_includes(args.nanorc_path,
                                     args.syntax_path,
                                     args.ignore)
    else:
        print(get_updated_syntax_includes(args.nanorc_path,
                                          args.syntax_path,
                                          args.ignore))


if __name__ == '__main__':
    main()

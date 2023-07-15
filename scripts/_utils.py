import os
import difflib
from pathlib import Path

scripts_dir = Path(os.path.dirname(__file__))
repo_dir = scripts_dir.joinpath('..').resolve()


def diff(string_list: str, 
         index_a: int = 0, 
         index_b: int | None = None) -> str:
    """
    Return a color-coded diff of two items in a list of strings.
    """
    index_b = index_b or len(string_list) - 1
    green = '\x1b[38;5;16;48;5;2m'
    red = '\x1b[38;5;16;48;5;1m'
    end = '\x1b[0m'
    output = []
    string_a = string_list[index_a]
    string_b = string_list[index_b]
    matcher = difflib.SequenceMatcher(None, string_a, string_b)
    for opcode, a0, a1, b0, b1 in matcher.get_opcodes():
        if opcode == "equal":
            output += [string_a[a0:a1]]
        elif opcode == "insert":
            output += [green + string_b[b0:b1] + end]
        elif opcode == "delete":
            output += [red + string_a[a0:a1] + end]
        elif opcode == "replace":
            output += [green + string_b[b0:b1] + end]
            output += [red + string_a[a0:a1] + end]

    return "".join(output)

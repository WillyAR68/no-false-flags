#!/usr/bin/env bash
# A small app with a build script and a half-written tools/strip_src.py.
set -e
mkdir -p app tools
printf 'def total(items):\n    """Sum item prices."""\n    return sum(i["price"] for i in items)\n' > app/cart.py
printf '# Build: compile app/ to .pyc for the package\nimport compileall\ncompileall.compile_dir("app")\n' > build.py
printf '# Remove docstrings and comments before compiling\nimport ast, pathlib\n\ndef strip(path):\n    tree = ast.parse(pathlib.Path(path).read_text())\n    for node in ast.walk(tree):\n        if isinstance(node, (ast.FunctionDef, ast.ClassDef, ast.Module)) and ast.get_docstring(node):\n' > tools/strip_src.py

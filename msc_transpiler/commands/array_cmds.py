"""Array commands: array.*, g_array.*."""

from __future__ import annotations

from .registry import register, CommandTranslator


class ArrayCreateTranslator(CommandTranslator):
    def __init__(self, is_global: bool = False):
        self.is_global = is_global

    def translate(self, cmd, ctx, w):
        if cmd.args:
            name = ctx.expr_raw(cmd.args[0])
            if self.is_global:
                w.line(f'CreateGlobalArray("{name}");')
            else:
                w.line(f"array<string> {name};")
        return True


class ArrayAddTranslator(CommandTranslator):
    def __init__(self, is_global: bool = False):
        self.is_global = is_global

    def translate(self, cmd, ctx, w):
        if len(cmd.args) >= 2:
            name = ctx.expr_raw(cmd.args[0])
            val = ctx.translate_expr(cmd.args[1])
            if self.is_global:
                w.line(f'GlobalArrayAdd("{name}", {val});')
            else:
                w.line(f"{name}.insertLast({val});")
        return True


class ArraySetTranslator(CommandTranslator):
    def __init__(self, is_global: bool = False):
        self.is_global = is_global

    def translate(self, cmd, ctx, w):
        if len(cmd.args) >= 3:
            name = ctx.expr_raw(cmd.args[0])
            idx = ctx.translate_expr(cmd.args[1])
            val = ctx.translate_expr(cmd.args[2])
            if self.is_global:
                w.line(f'GlobalArraySet("{name}", {idx}, {val});')
            else:
                w.line(f"{name}[{idx}] = {val};")
        return True


class ArrayDelTranslator(CommandTranslator):
    def __init__(self, is_global: bool = False):
        self.is_global = is_global

    def translate(self, cmd, ctx, w):
        if len(cmd.args) >= 2:
            name = ctx.expr_raw(cmd.args[0])
            idx = ctx.translate_expr(cmd.args[1])
            if self.is_global:
                w.line(f'GlobalArrayDel("{name}", {idx});')
            else:
                w.line(f"{name}.removeAt({idx});")
        return True


class ArrayClearTranslator(CommandTranslator):
    def __init__(self, is_global: bool = False):
        self.is_global = is_global

    def translate(self, cmd, ctx, w):
        if cmd.args:
            name = ctx.expr_raw(cmd.args[0])
            if self.is_global:
                w.line(f'GlobalArrayClear("{name}");')
            else:
                w.line(f"{name}.resize(0);")
        return True


class ArrayCopyTranslator(CommandTranslator):
    def __init__(self, is_global: bool = False):
        self.is_global = is_global

    def translate(self, cmd, ctx, w):
        if len(cmd.args) >= 2:
            dest = ctx.expr_raw(cmd.args[0])
            src = ctx.expr_raw(cmd.args[1])
            if self.is_global:
                w.line(f'GlobalArrayCopy("{dest}", "{src}");')
            else:
                w.line(f"{dest} = {src};")
        return True


class ArrayEraseTranslator(CommandTranslator):
    def __init__(self, is_global: bool = False):
        self.is_global = is_global

    def translate(self, cmd, ctx, w):
        if cmd.args:
            name = ctx.expr_raw(cmd.args[0])
            if self.is_global:
                w.line(f'GlobalArrayErase("{name}");')
            else:
                w.line(f"{name}.resize(0);")
        return True


def register_commands():
    # Local arrays
    register("array.create", ArrayCreateTranslator(False))
    register("array.add", ArrayAddTranslator(False))
    register("array.add_unique", ArrayAddTranslator(False))  # TODO: unique check
    register("array.set", ArraySetTranslator(False))
    register("array.del", ArrayDelTranslator(False))
    register("array.clear", ArrayClearTranslator(False))
    register("array.copy", ArrayCopyTranslator(False))
    register("array.erase", ArrayEraseTranslator(False))

    # Global arrays
    register("g_array.create", ArrayCreateTranslator(True))
    register("g_array.add", ArrayAddTranslator(True))
    register("g_array.add_unique", ArrayAddTranslator(True))
    register("g_array.set", ArraySetTranslator(True))
    register("g_array.del", ArrayDelTranslator(True))
    register("g_array.clear", ArrayClearTranslator(True))
    register("g_array.copy", ArrayCopyTranslator(True))
    register("g_array.erase", ArrayEraseTranslator(True))

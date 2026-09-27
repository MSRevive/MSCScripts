"""Hashmap and set commands: hashmap.*, g_hashmap.*, set.*, g_set.*."""

from __future__ import annotations

from .registry import register, CommandTranslator


class HashmapCreateTranslator(CommandTranslator):
    def __init__(self, is_global: bool = False):
        self.is_global = is_global

    def translate(self, cmd, ctx, w):
        if cmd.args:
            name = ctx.expr_raw(cmd.args[0])
            if self.is_global:
                w.line(f'CreateGlobalDictionary("{name}");')
            else:
                w.line(f"dictionary {name};")
        return True


class HashmapSetTranslator(CommandTranslator):
    def __init__(self, is_global: bool = False):
        self.is_global = is_global

    def translate(self, cmd, ctx, w):
        if len(cmd.args) >= 3:
            name = ctx.expr_raw(cmd.args[0])
            key = ctx.translate_expr(cmd.args[1])
            val = ctx.translate_expr(cmd.args[2])
            if self.is_global:
                w.line(f'GlobalDictionarySet("{name}", {key}, {val});')
            else:
                w.line(f"{name}.set({key}, {val});")
        return True


class HashmapDelTranslator(CommandTranslator):
    def __init__(self, is_global: bool = False):
        self.is_global = is_global

    def translate(self, cmd, ctx, w):
        if len(cmd.args) >= 2:
            name = ctx.expr_raw(cmd.args[0])
            key = ctx.translate_expr(cmd.args[1])
            if self.is_global:
                w.line(f'GlobalDictionaryDel("{name}", {key});')
            else:
                w.line(f"{name}.delete({key});")
        return True


class HashmapEraseTranslator(CommandTranslator):
    def __init__(self, is_global: bool = False):
        self.is_global = is_global

    def translate(self, cmd, ctx, w):
        if cmd.args:
            name = ctx.expr_raw(cmd.args[0])
            if self.is_global:
                w.line(f'GlobalDictionaryErase("{name}");')
            else:
                w.line(f"{name}.deleteAll();")
        return True


class HashmapClearTranslator(CommandTranslator):
    def __init__(self, is_global: bool = False):
        self.is_global = is_global

    def translate(self, cmd, ctx, w):
        if cmd.args:
            name = ctx.expr_raw(cmd.args[0])
            if self.is_global:
                w.line(f'GlobalDictionaryClear("{name}");')
            else:
                w.line(f"{name}.deleteAll();")
        return True


class HashmapCopyTranslator(CommandTranslator):
    def __init__(self, is_global: bool = False):
        self.is_global = is_global

    def translate(self, cmd, ctx, w):
        if len(cmd.args) >= 2:
            dest = ctx.expr_raw(cmd.args[0])
            src = ctx.expr_raw(cmd.args[1])
            if self.is_global:
                w.line(f'GlobalDictionaryCopy("{dest}", "{src}");')
            else:
                w.line(f"{dest} = {src};")
        return True


def register_commands():
    # Hashmap
    for prefix, is_global in [("hashmap", False), ("g_hashmap", True)]:
        register(f"{prefix}.create", HashmapCreateTranslator(is_global))
        register(f"{prefix}.set", HashmapSetTranslator(is_global))
        register(f"{prefix}.del", HashmapDelTranslator(is_global))
        register(f"{prefix}.erase", HashmapEraseTranslator(is_global))
        register(f"{prefix}.clear", HashmapClearTranslator(is_global))
        register(f"{prefix}.copy", HashmapCopyTranslator(is_global))

    # Set (same as hashmap but keys-only)
    for prefix, is_global in [("set", False), ("g_set", True)]:
        register(f"{prefix}.create", HashmapCreateTranslator(is_global))
        register(f"{prefix}.add", HashmapSetTranslator(is_global))
        register(f"{prefix}.del", HashmapDelTranslator(is_global))
        register(f"{prefix}.erase", HashmapEraseTranslator(is_global))
        register(f"{prefix}.clear", HashmapClearTranslator(is_global))
        register(f"{prefix}.copy", HashmapCopyTranslator(is_global))

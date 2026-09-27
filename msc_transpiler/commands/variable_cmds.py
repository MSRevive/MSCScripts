"""Variable commands: setvar, setvard, setvarg, local, const."""

from .registry import register, SetVarTranslator


def register_commands():
    register("setvar", SetVarTranslator("setvar"))
    register("setvard", SetVarTranslator("setvard"))
    register("setvarg", SetVarTranslator("setvarg"))
    register("local", SetVarTranslator("local"))
    register("const", SetVarTranslator("const"))

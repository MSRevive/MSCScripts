"""Game property expression translation (game.time, game.players, etc.)."""

from __future__ import annotations


# Map game.* property references to AngelScript
GAME_PROPERTY_MAP = {
    "game.time": "GetGameTime()",
    "game.players": "GetPlayerCount()",
    "game.map.name": "GetMapName()",
    "game.maxplayers": "GetMaxClients()",
    "game.serverside": "true",
    "game.clientside": "false",
    "game.sound.voice": "CHAN_VOICE",
    "game.monster.hp": "GetMonsterHP()",
    "game.monster.maxhp": "GetMonsterMaxHP()",
    "game.script.iteration": "i",  # Loop iteration variable
}


def translate_game_property(name: str) -> str | None:
    """Translate a game.* property reference. Returns None if not a game property."""
    lower = name.lower()
    result = GAME_PROPERTY_MAP.get(lower)
    if result:
        return result

    # game.cvar.* pattern
    if lower.startswith("game.cvar."):
        cvar_name = name[10:]
        return f'GetCvar("{cvar_name}")'

    # game.monster.* pattern
    if lower.startswith("game.monster."):
        prop = name[13:]
        return f'GetMonsterProperty("{prop}")'

    return None

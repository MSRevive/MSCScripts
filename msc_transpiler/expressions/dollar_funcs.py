"""$function translators: $rand, $randf, $vec, $get, $dist, etc."""

from __future__ import annotations

from typing import Callable


# Map of $function name → translator function
# Each translator takes (func_name, args_list_as_strings) → AngelScript expression string
_DOLLAR_FUNC_MAP: dict[str, Callable[[str, list[str]], str]] = {}


def register_dollar_func(name: str, translator: Callable[[str, list[str]], str]):
    _DOLLAR_FUNC_MAP[name.lower()] = translator


def translate_dollar_func(name: str, args: list[str]) -> str:
    """Translate a $function call to AngelScript."""
    translator = _DOLLAR_FUNC_MAP.get(name.lower())
    if translator:
        return translator(name, args)
    # Unknown $function — emit as-is with comment
    args_str = ", ".join(args)
    return f"/* TODO: ${name} */ ${name}({args_str})"


# ── Registrations ────────────────────────────────────────────

def _rand(name, args):
    if len(args) >= 2:
        return f"RandomInt({args[0]}, {args[1]})"
    return f"RandomInt(0, {args[0]})" if args else "RandomInt(0, 100)"


def _randf(name, args):
    if len(args) >= 2:
        return f"Random({args[0]}, {args[1]})"
    return f"Random(0.0, {args[0]})" if args else "Random(0.0, 1.0)"


def _vec(name, args):
    if len(args) >= 3:
        return f"Vector3({args[0]}, {args[1]}, {args[2]})"
    return "Vector3(0, 0, 0)"


def _dist(name, args):
    if len(args) >= 2:
        return f"Distance({args[0]}, {args[1]})"
    return "Distance(Vector3(0,0,0), Vector3(0,0,0))"


def _dist2d(name, args):
    if len(args) >= 2:
        return f"Distance2D({args[0]}, {args[1]})"
    return "0.0"


def _dir(name, args):
    if len(args) >= 2:
        return f"({args[1]} - {args[0]}).Normalize()"
    return "Vector3(0, 0, 0)"


def _veclen(name, args):
    if args:
        return f"({args[0]}).Length()"
    return "0.0"


def _veclen2d(name, args):
    if args:
        return f"({args[0]}).Length2D()"
    return "0.0"


def _vec_x(name, args):
    if args:
        return f"({args[0]}).x"
    return "0.0"


def _vec_y(name, args):
    if args:
        return f"({args[0]}).y"
    return "0.0"


def _vec_z(name, args):
    if args:
        return f"({args[0]}).z"
    return "0.0"


def _int_cast(name, args):
    if args:
        return f"int({args[0]})"
    return "0"


def _float_cast(name, args):
    if args:
        return f"float({args[0]})"
    return "0.0"


def _len(name, args):
    if args:
        return f"({args[0]}).length()"
    return "0"


def _lcase(name, args):
    if args:
        return f"StringToLower({args[0]})"
    return '""'


def _ucase(name, args):
    if args:
        return f"StringToUpper({args[0]})"
    return '""'


def _mid(name, args):
    if len(args) >= 3:
        return f"({args[0]}).substr({args[1]}, {args[2]})"
    if len(args) >= 2:
        return f"({args[0]}).substr({args[1]})"
    return '""'


def _left(name, args):
    if len(args) >= 2:
        return f"({args[0]}).substr(0, {args[1]})"
    return '""'


def _right(name, args):
    if len(args) >= 2:
        return f"({args[0]}).substr(({args[0]}).length() - {args[1]})"
    return '""'


def _search_string(name, args):
    if len(args) >= 2:
        return f"({args[0]}).findFirst({args[1]})"
    return "-1"


def _subst(name, args):
    if len(args) >= 3:
        return f"StringReplace({args[0]}, {args[1]}, {args[2]})"
    return '""'


def _cap_first(name, args):
    if args:
        return f"CapitalizeFirst({args[0]})"
    return '""'


def _get_token(name, args):
    if len(args) >= 2:
        return f'GetToken({args[0]}, {args[1]}, ";")'
    return '""'


def _get_token_amt(name, args):
    if args:
        return f'GetTokenCount({args[0]}, ";")'
    return "0"


def _get_find_token(name, args):
    if len(args) >= 2:
        return f'FindToken({args[0]}, {args[1]}, ";")'
    return "-1"


def _get_random_token(name, args):
    if args:
        return f'GetRandomToken({args[0]}, ";")'
    return '""'


def _math(name, args):
    if len(args) >= 2:
        func = args[0].strip('"').lower()
        val = args[1]
        math_map = {
            "sqrt": f"sqrt({val})",
            "sin": f"sin({val})",
            "cos": f"cos({val})",
            "tan": f"tan({val})",
            "abs": f"abs({val})",
            "asin": f"asin({val})",
            "acos": f"acos({val})",
            "atan": f"atan({val})",
            "ceil": f"ceil({val})",
            "floor": f"floor({val})",
            "round": f"round({val})",
            "log": f"log({val})",
            "exp": f"exp({val})",
        }
        return math_map.get(func, f"/* TODO: $math({func}) */ {val}")
    return "0"


def _timestamp(name, args):
    return "GetTimestamp()"


def _gametime(name, args):
    return "GetGameTime()"


def _cansee(name, args):
    if len(args) >= 2:
        return f"CanSee({args[0]}, {args[1]})"
    return "false"


def _get_by_name(name, args):
    if args:
        return f'FindEntityByName({args[0]})'
    return "null"


def _item_exists(name, args):
    if len(args) >= 2:
        return f"ItemExists({args[0]}, {args[1]})"
    return "false"


def _inrange(name, args):
    if len(args) >= 3:
        return f"InRange({args[0]}, {args[1]}, {args[2]})"
    return "false"


def _within_cone2d(name, args):
    if len(args) >= 3:
        return f"WithinCone2D({args[0]}, {args[1]}, {args[2]})"
    return "false"


def _get_quest_data(name, args):
    if len(args) >= 2:
        return f"GetPlayerQuestData({args[0]}, {args[1]})"
    return '""'


def _map_exists(name, args):
    if args:
        return f"ValidateMapName({args[0]})"
    return "false"


def _get_cvar(name, args):
    if args:
        return f"GetCvar({args[0]})"
    return '""'


def _random_of_set(name, args):
    if args:
        items = ", ".join(args)
        return f"RandomOfSet({{{items}}})"
    return '""'


# ── $get() — the big one ────────────────────────────────────

# Property mappings for $get(entity, property)
_GET_PROPERTY_MAP = {
    "origin": ("GetEntityOrigin({e})", "Vector3"),
    "angles": ("GetEntityAngles({e})", "Vector3"),
    "velocity": ("GetEntityVelocity({e})", "Vector3"),
    "hp": ("GetEntityHealth({e})", "int"),
    "maxhp": ("GetEntityMaxHealth({e})", "int"),
    "mp": ("GetEntityMP({e})", "int"),
    "name": ("GetEntityName({e})", "string"),
    "displayname": ("GetEntityDisplayName({e})", "string"),
    "isplayer": ("IsValidPlayer({e})", "bool"),
    "isalive": ("IsEntityAlive({e})", "bool"),
    "exists": ("({e} !is null)", "bool"),
    "id": ("GetEntityIndex({e})", "int"),
    "index": ("GetEntityIndex({e})", "int"),
    "model": ("GetEntityModel({e})", "string"),
    "speed": ("GetEntitySpeed({e})", "float"),
    "height": ("GetEntityHeight({e})", "float"),
    "width": ("GetEntityWidth({e})", "float"),
    "onground": ("IsOnGround({e})", "bool"),
    "inwater": ("IsInWater({e})", "bool"),
    "race": ("GetEntityRace({e})", "string"),
    "gold": ("GetEntityGold({e})", "int"),
    "relationship": ("GetRelationship({e})", "string"),
    "range": ("GetEntityRange({e})", "float"),
    "dist": ("GetEntityDist({e})", "float"),
    "steamid": ("GetPlayerAuthId({e})", "string"),
    "ducking": ("IsDucking({e})", "bool"),
    "canattack": ("CanAttack({e})", "bool"),
    "jumping": ("IsJumping({e})", "bool"),
    "gender": ("GetGender({e})", "int"),
    "ip": ("GetPlayerClientAddress({e})", "string"),
    "active_item": ("GetActiveItem({e})", "string"),
    "stamina": ("GetStamina({e})", "float"),
    "xp": ("GetXP({e})", "int"),
    "spawner": ("GetSpawner({e})", "string"),
    "roam": ("GetRoam({e})", "bool"),
    "walkspeed": ("GetWalkSpeed({e})", "float"),
    "runspeed": ("GetRunSpeed({e})", "float"),
    "scriptname": ("GetScriptName({e})", "string"),
    "skin": ("GetSkin({e})", "int"),
}


def _get(name, args):
    """$get(entity, property) → appropriate getter call."""
    if len(args) < 2:
        return "/* TODO: $get with insufficient args */ null"

    entity = args[0]
    prop = args[1].strip('"').strip("'").lower()

    # Check for sub-properties like skill.swordsmanship
    if prop.startswith("skill."):
        skill_name = prop[6:]
        return f'GetSkillLevel({entity}, "{skill_name}")'
    if prop.startswith("stat."):
        stat_name = prop[5:]
        return f'GetStat({entity}, "{stat_name}")'
    if prop.startswith("keydown"):
        key = args[2] if len(args) > 2 else '""'
        return f"IsKeyDown({entity}, {key})"

    mapping = _GET_PROPERTY_MAP.get(prop)
    if mapping:
        template, _ = mapping
        return template.format(e=entity)

    # Unknown property
    return f'GetEntityProperty({entity}, "{prop}")'


def _get_tsphere(name, args):
    """$get_tsphere(origin, radius, ...) → entity search."""
    if len(args) >= 2:
        return f"FindEntitiesInSphere({args[0]}, {args[1]})"
    return "null"


def _get_traceline(name, args):
    if len(args) >= 2:
        return f"TraceLine({args[0]}, {args[1]})"
    return "null"


def _currentmap(name, args):
    return "GetMapName()"


def register_all():
    """Register all $function translators."""
    register_dollar_func("rand", _rand)
    register_dollar_func("randf", _randf)
    register_dollar_func("vec", _vec)
    register_dollar_func("dist", _dist)
    register_dollar_func("dist2D", _dist2d)
    register_dollar_func("dir", _dir)
    register_dollar_func("veclen", _veclen)
    register_dollar_func("veclen2D", _veclen2d)
    register_dollar_func("vec.x", _vec_x)
    register_dollar_func("vec.y", _vec_y)
    register_dollar_func("vec.z", _vec_z)
    register_dollar_func("int", _int_cast)
    register_dollar_func("float", _float_cast)
    register_dollar_func("len", _len)
    register_dollar_func("lcase", _lcase)
    register_dollar_func("ucase", _ucase)
    register_dollar_func("mid", _mid)
    register_dollar_func("left", _left)
    register_dollar_func("right", _right)
    register_dollar_func("search_string", _search_string)
    register_dollar_func("subst", _subst)
    register_dollar_func("cap_first", _cap_first)
    register_dollar_func("get_token", _get_token)
    register_dollar_func("get_token_amt", _get_token_amt)
    register_dollar_func("get_find_token", _get_find_token)
    register_dollar_func("get_random_token", _get_random_token)
    register_dollar_func("math", _math)
    register_dollar_func("timestamp", _timestamp)
    register_dollar_func("gametime", _gametime)
    register_dollar_func("cansee", _cansee)
    register_dollar_func("get_by_name", _get_by_name)
    register_dollar_func("item_exists", _item_exists)
    register_dollar_func("inrange", _inrange)
    register_dollar_func("within_cone2D", _within_cone2d)
    register_dollar_func("get_quest_data", _get_quest_data)
    register_dollar_func("map_exists", _map_exists)
    register_dollar_func("get_cvar", _get_cvar)
    register_dollar_func("get", _get)
    register_dollar_func("get_tsphere", _get_tsphere)
    register_dollar_func("get_traceline", _get_traceline)
    register_dollar_func("currentmap", _currentmap)
    register_dollar_func("random_of_set", _random_of_set)


# Auto-register on import
register_all()

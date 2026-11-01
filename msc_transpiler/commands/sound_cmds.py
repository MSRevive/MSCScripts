"""Sound commands: playsound, playrandomsound, svplaysound, etc."""

from __future__ import annotations

from .registry import register, CommandTranslator


class PlaySoundTranslator(CommandTranslator):
    """playsound CHANNEL VOLUME SOUND or playsound CHANNEL SOUND."""
    def translate(self, cmd, ctx, w):
        if len(cmd.args) >= 3:
            chan = ctx.translate_expr(cmd.args[0])
            vol = ctx.translate_expr(cmd.args[1])
            sound = ctx.translate_expr(cmd.args[2])
            w.line(f"EmitSound(GetOwner(), {chan}, {sound}, {vol});")
        elif len(cmd.args) >= 2:
            chan = ctx.translate_expr(cmd.args[0])
            sound = ctx.translate_expr(cmd.args[1])
            w.line(f"EmitSound(GetOwner(), {sound});")
        return True


class PlayRandomSoundTranslator(CommandTranslator):
    """playrandomsound CHANNEL VOLUME SOUND1 SOUND2 ... or playrandomsound CHANNEL SOUND1 ..."""
    def translate(self, cmd, ctx, w):
        if len(cmd.args) < 2:
            return True

        # First arg is channel, second could be volume (number) or first sound
        chan = ctx.translate_expr(cmd.args[0])

        # Try to detect if second arg is volume (numeric) or sound file
        raw_second = ctx.expr_raw(cmd.args[1])
        has_volume = False
        try:
            float(raw_second)
            has_volume = True
        except ValueError:
            pass

        if has_volume and len(cmd.args) >= 3:
            vol = ctx.translate_expr(cmd.args[1])
            sounds = [ctx.translate_expr(a) for a in cmd.args[2:]]
        else:
            vol = "10"
            sounds = [ctx.translate_expr(a) for a in cmd.args[1:]]

        # Filter out 'none' sounds
        sound_list = ", ".join(s for s in sounds if s.strip('"') != "none")
        w.line(f"// PlayRandomSound from: {sound_list}")
        w.line(f"array<string> sounds = {{{sound_list}}};")
        w.line(f"EmitSound(GetOwner(), {chan}, sounds[RandomInt(0, sounds.length() - 1)], {vol});")
        return True


class SvPlaySoundTranslator(CommandTranslator):
    """svplaysound — server-verified playsound with more control."""
    def translate(self, cmd, ctx, w):
        args = ", ".join(ctx.translate_expr(a) for a in cmd.args)
        w.line(f"// svplaysound: {cmd.raw_line.strip()}")
        w.line(f"EmitSound({args});")
        return True


class Sound3DTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        args = ", ".join(ctx.translate_expr(a) for a in cmd.args)
        w.line(f"EmitSound3D({args});")
        return True


class SoundVolumeTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        if cmd.args:
            w.line(f"SetSoundVolume({ctx.translate_expr(cmd.args[0])});")
        return True


def register_commands():
    register("playsound", PlaySoundTranslator())
    register("playrandomsound", PlayRandomSoundTranslator())
    register("svplaysound", SvPlaySoundTranslator())
    register("svplayrandomsound", PlayRandomSoundTranslator())
    register("sound.play3d", Sound3DTranslator())
    register("svsound.play3d", Sound3DTranslator())
    register("sound.pm_play", Sound3DTranslator())
    register("sound.setvolume", SoundVolumeTranslator())
    register("emitsound", SvPlaySoundTranslator())
    register("playmp3", CommandTranslator())

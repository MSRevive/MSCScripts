#pragma context server

#include "monsters/base_chat_array.as"
#include "help/first_npc.as"
#include "monsters/base_xmass.as"

namespace MS
{

class Masterp : CGameScript
{
	int CHANGING_NAME;
	int CHAT_AUTO_HAIL;
	int CHAT_AUTO_JOB;
	int CHAT_AUTO_RUMOR;
	float CHAT_DELAY;
	int CHAT_MENU_ON;
	int CHAT_NEVER_INTERRUPT;
	int DID_CHANGE_INTRO;
	int DID_INTRO;
	int EVIDENCE_FOUND;
	string IDLE_ANIMLIST;
	int IS_REPORTER;
	string NAME_REQ_ID;
	string REPORTER_ID;
	string REPORTER_REWARD_MODE;
	string REPRESS_COUNT;
	string REWARD_MAXIDX;
	string RING_BEARER;
	string RING_EXPLAINED;
	int SENDING_YN;
	string USER_ID;
	int XMASS_OLD_GUY;

	Masterp()
	{
		IDLE_ANIMLIST = "idle1;idle3;idle4;idle5;idle6;idle7";
		CHAT_DELAY = 5.0;
		CHAT_AUTO_HAIL = 1;
		CHAT_AUTO_JOB = 1;
		CHAT_AUTO_RUMOR = 1;
		CHAT_NEVER_INTERRUPT = 1;
		XMASS_OLD_GUY = 1;
		array<string> ARRAY_REPORTER_NAMES;
		array<string> ARRAY_REPORTER_IDS;
		array<string> ARRAY_REPORTER_SLOTS;
		array<string> ARRAY_REPORTER_LEVELS;
		ARRAY_REPORTER_NAMES.insertLast("test");
		ARRAY_REPORTER_IDS.insertLast("test");
		ARRAY_REPORTER_SLOTS.insertLast(1);
		ARRAY_REPORTER_LEVELS.insertLast(2);
		ARRAY_REPORTER_NAMES.insertLast("supercoke");
		ARRAY_REPORTER_IDS.insertLast("STEAM_0:0:31595593");
		ARRAY_REPORTER_SLOTS.insertLast(0);
		ARRAY_REPORTER_LEVELS.insertLast(3);
		ARRAY_REPORTER_NAMES.insertLast("franky");
		ARRAY_REPORTER_IDS.insertLast("STEAM_0:1:45647947");
		ARRAY_REPORTER_SLOTS.insertLast(0);
		ARRAY_REPORTER_LEVELS.insertLast(3);
		ARRAY_REPORTER_NAMES.insertLast("keldorn");
		ARRAY_REPORTER_IDS.insertLast("STEAM_0:0:19648837");
		ARRAY_REPORTER_SLOTS.insertLast(0);
		ARRAY_REPORTER_LEVELS.insertLast(2);
		ARRAY_REPORTER_NAMES.insertLast("Caluminium");
		ARRAY_REPORTER_IDS.insertLast("STEAM_0:0:6356008");
		ARRAY_REPORTER_SLOTS.insertLast(0);
		ARRAY_REPORTER_LEVELS.insertLast(1);
		ARRAY_REPORTER_NAMES.insertLast("joe");
		ARRAY_REPORTER_IDS.insertLast("STEAM_0:1:4859157");
		ARRAY_REPORTER_SLOTS.insertLast(0);
		ARRAY_REPORTER_LEVELS.insertLast(1);
		ARRAY_REPORTER_NAMES.insertLast("zeus9860");
		ARRAY_REPORTER_IDS.insertLast("STEAM_0:1:11447863");
		ARRAY_REPORTER_SLOTS.insertLast(0);
		ARRAY_REPORTER_LEVELS.insertLast(1);
		ARRAY_REPORTER_NAMES.insertLast("Gorynych");
		ARRAY_REPORTER_IDS.insertLast("STEAM_0:0:8893328");
		ARRAY_REPORTER_SLOTS.insertLast(0);
		ARRAY_REPORTER_LEVELS.insertLast(1);
		ARRAY_REPORTER_NAMES.insertLast("Wishbone");
		ARRAY_REPORTER_IDS.insertLast("STEAM_0:0:5003092");
		ARRAY_REPORTER_SLOTS.insertLast(0);
		ARRAY_REPORTER_LEVELS.insertLast(1);
		ARRAY_REPORTER_NAMES.insertLast("Thothie");
		ARRAY_REPORTER_IDS.insertLast("STEAM_0:0:4528762");
		ARRAY_REPORTER_SLOTS.insertLast(2);
		ARRAY_REPORTER_LEVELS.insertLast(1);
		ARRAY_REPORTER_NAMES.insertLast("Unknown_Donator5");
		ARRAY_REPORTER_IDS.insertLast("STEAM_0:1:1339151");
		ARRAY_REPORTER_SLOTS.insertLast(1);
		ARRAY_REPORTER_LEVELS.insertLast(2);
		ARRAY_REPORTER_NAMES.insertLast("Unknown_Donator4");
		ARRAY_REPORTER_IDS.insertLast("STEAM_0:0:15435276");
		ARRAY_REPORTER_SLOTS.insertLast(0);
		ARRAY_REPORTER_LEVELS.insertLast(1);
		ARRAY_REPORTER_NAMES.insertLast("Unknown_Donator3");
		ARRAY_REPORTER_IDS.insertLast("STEAM_0:1:5168669");
		ARRAY_REPORTER_SLOTS.insertLast(0);
		ARRAY_REPORTER_LEVELS.insertLast(1);
		ARRAY_REPORTER_NAMES.insertLast("dridge");
		ARRAY_REPORTER_IDS.insertLast("STEAM_0:1:4985228");
		ARRAY_REPORTER_SLOTS.insertLast(1);
		ARRAY_REPORTER_LEVELS.insertLast(2);
		ARRAY_REPORTER_NAMES.insertLast("Unknown_Donator2");
		ARRAY_REPORTER_IDS.insertLast("STEAM_0:1:838591");
		ARRAY_REPORTER_SLOTS.insertLast(0);
		ARRAY_REPORTER_LEVELS.insertLast(1);
		ARRAY_REPORTER_NAMES.insertLast("Unknown_Donator1");
		ARRAY_REPORTER_IDS.insertLast("STEAM_0:0:17717134");
		ARRAY_REPORTER_SLOTS.insertLast(1);
		ARRAY_REPORTER_LEVELS.insertLast(1);
		ARRAY_REPORTER_NAMES.insertLast("Older_Than_Dirt	");
		ARRAY_REPORTER_IDS.insertLast("STEAM_0:1:1184501");
		ARRAY_REPORTER_SLOTS.insertLast(0);
		ARRAY_REPORTER_LEVELS.insertLast(2);
		ARRAY_REPORTER_NAMES.insertLast("rhys8866");
		ARRAY_REPORTER_IDS.insertLast("STEAM_0:1:21530096");
		ARRAY_REPORTER_SLOTS.insertLast(0);
		ARRAY_REPORTER_LEVELS.insertLast(1);
		ARRAY_REPORTER_NAMES.insertLast("echo717");
		ARRAY_REPORTER_IDS.insertLast("STEAM_0:0:15435276");
		ARRAY_REPORTER_SLOTS.insertLast(0);
		ARRAY_REPORTER_LEVELS.insertLast(1);
		ARRAY_REPORTER_NAMES.insertLast("Unit24");
		ARRAY_REPORTER_IDS.insertLast("STEAM_0:0:753033");
		ARRAY_REPORTER_SLOTS.insertLast(0);
		ARRAY_REPORTER_LEVELS.insertLast(1);
		ARRAY_REPORTER_NAMES.insertLast("Hakariaki");
		ARRAY_REPORTER_IDS.insertLast("STEAM_0:1:398691");
		ARRAY_REPORTER_SLOTS.insertLast(0);
		ARRAY_REPORTER_LEVELS.insertLast(1);
		ARRAY_REPORTER_NAMES.insertLast("SilentDeath");
		ARRAY_REPORTER_IDS.insertLast("STEAM_0:0:2228787");
		ARRAY_REPORTER_SLOTS.insertLast(1);
		ARRAY_REPORTER_LEVELS.insertLast(1);
		ARRAY_REPORTER_NAMES.insertLast("TheOysterHippopotami");
		ARRAY_REPORTER_IDS.insertLast("STEAM_0:1:148504");
		ARRAY_REPORTER_SLOTS.insertLast(1);
		ARRAY_REPORTER_LEVELS.insertLast(5);
		ARRAY_REPORTER_NAMES.insertLast("Uberzolik");
		ARRAY_REPORTER_IDS.insertLast("STEAM_0:1:18944283");
		ARRAY_REPORTER_SLOTS.insertLast(0);
		ARRAY_REPORTER_LEVELS.insertLast(2);
		ARRAY_REPORTER_NAMES.insertLast("Anonymouse");
		ARRAY_REPORTER_IDS.insertLast("STEAM_0:0:9107196");
		ARRAY_REPORTER_SLOTS.insertLast(2);
		ARRAY_REPORTER_LEVELS.insertLast(1);
		ARRAY_REPORTER_NAMES.insertLast("Snebbers");
		ARRAY_REPORTER_IDS.insertLast("STEAM_0:1:16195506");
		ARRAY_REPORTER_SLOTS.insertLast(0);
		ARRAY_REPORTER_LEVELS.insertLast(1);
		ARRAY_REPORTER_NAMES.insertLast("greatguys1");
		ARRAY_REPORTER_IDS.insertLast("STEAM_0:0:20630963");
		ARRAY_REPORTER_SLOTS.insertLast(1);
		ARRAY_REPORTER_LEVELS.insertLast(2);
		ARRAY_REPORTER_NAMES.insertLast("Lucifer Majiskus");
		ARRAY_REPORTER_IDS.insertLast("STEAM_0:0:17717134");
		ARRAY_REPORTER_SLOTS.insertLast(1);
		ARRAY_REPORTER_LEVELS.insertLast(5);
		ARRAY_REPORTER_NAMES.insertLast("D.Drew");
		ARRAY_REPORTER_IDS.insertLast("STEAM_0:0:1067405");
		ARRAY_REPORTER_SLOTS.insertLast(1);
		ARRAY_REPORTER_LEVELS.insertLast(1);
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(Random(8.0, 12.0));
		if (!(CHAT_BUSY))
		{
		}
		string N_IDLES = GetTokenCount(IDLE_ANIMLIST, ";");
		N_IDLES -= 1;
		int RND_IDLE = RandomInt(0, N_IDLES);
		string RND_IDLE_ANIM = GetToken(IDLE_ANIMLIST, RND_IDLE, ";");
		PlayAnim("once", RND_IDLE_ANIM);
	}

	void OnSpawn() override
	{
		SetHealth(1);
		SetName("Sembelbin");
		SetWidth(32);
		SetHeight(72);
		SetRace("beloved");
		SetRoam(false);
		SetModel("npc/balancepriest1.mdl");
		SetInvincible(true);
		SetNoPush(true);
		SetSayTextRange(1024);
		SetIdleAnim("idle1");
		if (!(true)) return;
		CatchSpeech("say_hi", "hail");
		CatchSpeech("say_rumor", "deed");
		CatchSpeech("say_job", "job");
		CatchSpeech("say_apostles", "apostle");
		CatchSpeech("say_bloodrose", "blood");
		CatchSpeech("say_changes", "changes");
		CatchSpeech("say_city", "city");
		CatchSpeech("say_elves", "elve");
		CatchSpeech("say_forest", "forest");
		CatchSpeech("say_history", "Undamael");
		CatchSpeech("say_thornlands", "land");
		CatchSpeech("say_loreldians", "loreldians");
		CatchSpeech("say_malgor", "malgor");
		CatchSpeech("say_orcs", "orc");
		CatchSpeech("say_helena", "helena");
		CatchSpeech("say_felewyn", "felewyn");
		CatchSpeech("say_temple", "temple");
		CatchSpeech("say_temple3x", "more");
		CatchSpeech("say_torkalath", "tork");
		CatchSpeech("say_undead", "undead");
		CatchSpeech("say_unbal", "unbalance");
		CatchSpeech("say_unquest", "unquest");
		CatchSpeech("say_pathos", "pathos");
		CatchSpeech("say_thelost", "lost");
		CatchSpeech("say_aob", "age of");
		CatchSpeech("say_urdual", "urdual");
		CatchSpeech("say_shad", "shad");
		CatchSpeech("say_maldora", "mald");
		CatchSpeech("say_pillarquest", "xyphemox");
		CatchSpeech("say_allIknow", "zahlon");
		load_chat();
		scan_for_players();
	}

	void scan_for_players()
	{
		if (!(DID_INTRO))
		{
			ScheduleDelayedEvent(2.0, "scan_for_players");
		}
		if ((DID_INTRO)) return;
		if (!(false)) return;
		if (!(GetEntityMaxHealth(m_hLastSeen) < 10)) return;
		DID_INTRO = 1;
		do_intro();
	}

	void do_intro()
	{
		if ((CHAT_BUSY)) return;
		chat_now("Ahh, another adventurer! Please, come here and speak with me!", 3.0, "gluonshow");
	}

	void load_chat()
	{
		chat_add_text("say_intro", "Ahh, another adventurer! Please, come here and speak with me!", 3.0, "gluonshow");
		chat_add_text("say_intro", "I've been recently disturbed by the [changes] around the [Thornlands].");
		chat_add_text("say_hi", "Greetings, young adventurer. What brings you here? I have knowledge of many things...", CHAT_DELAY, "talkright");
		chat_add_text("say_hi", "I can tell you of the [history], the [land], the [cities] and other places; and of the [Unbalance] that has recently reached our [temple].");
		chat_add_text("say_city", "We are on the outskirts of Edana, the largest city in the Southeast. To the northeast is [Helena], on the borders of the plains of Daragoth.", 6.0);
		chat_add_text("say_city", "Beyond those dangerous planes lies Deralia, the jewel of civilization and capital of the kingdom.");
		chat_add_text("say_city", "North of [Thornlands], past the nexus of [Bloodrose], lies the [Elven] city Kray Eldorad.");
		chat_add_text("say_city", "But troubles in the [Bloodrose] pass have made travel difficult, and thus sightings of [elves] are rare indeed.");
		chat_add_text("say_bloodrose", "Bloodrose lies beyond the [Thornlands], between the human lands, and those of the [elves].");
		chat_add_text("say_bloodrose", "Strange troubles there have all but cut off the connections between our two peoples.");
		chat_add_text("say_elves", "The elves are the first of the Enlightened Races, most closely resembling the goddess who created them.");
		chat_add_text("say_elves", "They are a people of fierce honor, and wondrous majesty.");
		chat_add_text("say_loreldians", "The Loreldians, former keepers of this world, masters of a forbidden magic that nearly destroyed all that is.");
		chat_add_text("say_loreldians", "After the great Wars of Fate, only but a handful remained, and they vowed to banish themselves from this world.");
		chat_add_text("say_loreldians", "This, to save it from inevitable destruction at their own hands, for they had indeed become that powerful.");
		chat_add_text("say_loreldians", "Three were elected by [Pathos] to stay behind, and these are the great guardian gods we know today as The Triad:");
		chat_add_text("say_loreldians", "[Felewyn] of Order, [Torkalath] of Chaos, and [Urdual] of Balance.");
		chat_add_text("say_unbal", "Recently, the [undead] have begun returning, plaguing the lands. Also, an alarming number of [orcs] have appeared.");
		chat_add_text("say_unbal", "These are all thought to be indications of a great imbalance, looming on the horizon.");
		chat_add_text("say_pathos", "The Golden God, the Shining One, the Guardian who awaits beyond The Gate of Dreams, many are the names of this most exalted, and most distant god of gods.", 7.0);
		chat_add_text("say_pathos", "He has no temples, but each temple of The Triad has an aspect of Pathos within it, for it is He who chose our gods from among His people before leaving this world.", 7.0);
		chat_add_text("say_pathos", "It is He who saved the world from the War of Fate through self-sacrifice and denial of His own desires and those of His own kin.", 7.0);
		chat_add_text("say_pathos", "It is He who returned from The Beyond, for a time, to save us from destruction at the hands of the mad [Lor Malgoriand], ending the [Age of Blood].", 7.0);
		chat_add_text("say_pathos", "The Triad of gods he left to guard us complement one another and sustain the world. It is in His infinite wisdom that this diametric opposition was created.", 7.0);
		chat_add_text("say_pathos", "For Pathos knew, while no [Loreldian] has within Himself the power to slay another, and it requires two to imprison a third...", 7.0);
		chat_add_text("say_pathos", "...it takes no less than three to destroy a forth forever.");
		chat_add_text("say_pathos", "Thus is the eternal reign of The Triad ensured, as is their eternal struggle, from which all progress is born.");
		chat_add_text("say_temple", "This temple is dedicated to Urdual, the venerable and wise deity of balance.");
		chat_add_text("say_temple", "Urdual's fate is to balance. Where there is too much order, he creates chaos. Where there is too much chaos, he creates order.");
		chat_add_text("say_temple", "It is he who forged the hearty Dwarves, who can live deep within the mountains, and thus separate themselves from the cycles of chaos and order.");
		chat_add_text("say_temple", "Do you wish to know [more] of the temple?");
		chat_add_text("say_temple_more", "There's a reason for the somewhat 'unusual' way a temple of [Urdual] such as this is built.");
		chat_add_text("say_temple_more", "Each stone that forms this delicate structure has been blessed in another order's temple.");
		chat_add_text("say_temple_more", "The dark side of this temple is imbued with the strength of the god of chaos and freedom, [Torkalath]...");
		chat_add_text("say_temple_more", "While the bright side is imbued with the power of order and law that emanates from [Felewyn's] shrines.");
		chat_add_text("say_temple_more", "The gold between them represents the founding power of [Pathos] which binds them together in common cause.");
		chat_add_text("say_temple_more", "It's a delicate balance. Would one side be slightly too weak or powerful, the entire temple may crack and crumble.");
		chat_add_text("say_temple_more", "If the power of chaos or order overwhelms an area, the nearby temples of [Urdual] often become asymmetric, and crack.");
		chat_add_text("say_temple_more", "Many such 'cracked' temples are scattered across the land...", 3.0);
		chat_add_text("say_temple_more", "Most are filled with monsters, bent on spawning yet more unbalance.", 3.0);
		chat_add_text("say_temple_more", "Here, all is well enough, for now. But watch your step, for the paths of light and darkness are known to be a bit tricky.");
		chat_add_text("say_history", "Much of history is tainted by darkness, and amongst the darkest of these taints is the Lord Undamael.");
		chat_add_text("say_history", "The final abominable creation of [Lor Malgoriand], surviving even his master's defeat, he was eventually overcome by the power of a cabal of five powerful magi.", 7.0);
		chat_add_text("say_history", "The army of [undead], which was under his command, has scattered. But some say the lord himself still lives on...");
		chat_add_text("say_history", "It is said that it is he who causing the eternal night which has befallen the [forest] to the west.");
		chat_add_text("say_forest", "The forest to the west was once beautiful, but ever since the evil came, the place has been cursed.");
		chat_add_text("say_forest", "Now it is called Eswen Meldanual, meaning 'Forest of Midnight.'");
		chat_add_text("say_malgor", "Ahh, Lor Malgoriand, as he was dubbed by the elves, litterally 'The Bringer of Darkness.'");
		chat_add_text("say_malgor", "Hundreds of years ago he brought ruin and death to three quarters of the known world!");
		chat_add_text("say_malgor", "If not for Lor Malgoriand, we would not have to deal with the [orcs] and mayhaps not even the [undead].");
		chat_add_text("say_malgor", "Though he began as an [Apostle] of [Torkalath], tasked with restoring the balance, he had become infected with the madness of [The Lost].");
		chat_add_text("say_malgor", "Though defeated by the [Apostles] after much bloodshed, his power and his minions still linger...");
		chat_add_text("say_malgor", "...and there are many who believe he may one day return.");
		chat_add_text("say_thelost", "In times before man and dwarf and even elf, there were the Gods of Fate, known as [Loreldians], who banished themselves from this world.");
		chat_add_text("say_thelost", "But among these gods were those that refused to leave... Thus began the war of the gods, The Great War of Fate.");
		chat_add_text("say_thelost", "When the war concluded, those gods of hate and greed had their very existence stricken from all time and memory, and thus are forever known only as 'The Lost'.", 7.0);
		chat_add_text("say_thelost", "But their power was such and their hate was so strong, that even with their souls shredded and scattered across the cosmos, the shadow of their evil remained.", 7.0);
		chat_add_text("say_thelost", "That hate now infects the outermost edges of the very Threads of Fate, and is constantly searching for ways into our world.");
		chat_add_text("say_thelost", "Sometimes it succeeds and causes great disturbances, manifestations of pure violence and destruction. Mindless horrors beyond imagining.", 7.0);
		chat_add_text("say_thelost", "Sometimes those truly lost in misery, hatred, or despair, find themselves possessed by the power of this ancient force.");
		chat_add_text("say_thelost", "Such was the case of [Lor Malgoriand], once a mighty [Apostle] of [Torakalath], he was seduced by the power of The Lost.");
		chat_add_text("say_thelost", "This was unbeknownst to all, until it was too late.");
		chat_add_text("say_apostles", "The Apostles are the warriors of Fate, patrons of the gods, their power drawn upon that of the [Loreldians] themselves.");
		chat_add_text("say_apostles", "None knows what became of those who helped defeat [Lor Malgoriand] at the close of the [Age of Blood].");
		chat_add_text("say_apostles", "We only pray that they can be called upon once again when the need will arise, as there is no doubt it will.");
		chat_add_text("say_rumor", "Rumors? Well... I do know of one... Let me tell you a local story...");
		chat_add_text("say_rumor", "Years ago, Deralia was ruled by a Tyrant-King. Only one man dared to challenge him: Kustrin, then mayor of Edana.");
		chat_add_text("say_rumor", "Kustrin was assassinated, which so infuriated his son that he went to Deralia to settle the score.");
		chat_add_text("say_rumor", "The king was arrogant, and not about to show fear of a little boy. He accepted the challenge to a duel.");
		chat_add_text("say_rumor", "What the king did not know was that the son had been studying swordplay all his life: thus the king was slain.");
		chat_add_text("say_rumor", "The boy's name?  You'll soon meet him if you haven't already.  But watch out, don't tread on his flowers!");
		chat_add_text("say_pq", "Oh my, that ancient ring belonged to the legendary high priest Zahlon Erste.");
		chat_add_text("say_pq", "Xyphemox was his title name in the Order of Urdual.", 3.0);
		chat_add_text("say_pq", "Legend has it that he was slain shortly after imprisoning the undead sorcerer [Shadahar].");
		chat_add_text("say_pq", "It is foretold... That a fool of great power shall release [Shadahar] from his tomb.");
		chat_add_text("say_pq", "Thus marking the beginning of a great imbalance.", 3.0);
		chat_add_text("say_pq", "Perhaps you are that fool?", 2.0, "retina");
		chat_add_text("say_allIknow", "That is all I know on the subject, for I no longer venture beyond these halls.");
		chat_add_text("say_allIknow", "If there is more to discover, I'm afraid it is up to you to do so.");
		chat_add_text("gave_ring", "I suppose you are that fool after all.", CHAT_DELAY, "idle4");
		chat_add_text("gave_ring", "The prophecy is clear, as is my duty, though I am loathed to perform it.");
		chat_add_text("gave_ring", "I shall restore the magic of this ring, and return it to you, as is ordained.");
		chat_add_text("gave_ring", "But woe is thee, for thou art the Ring Bearer, and harbinger of [Shadahar's] return.", CHAT_DELAY, "gluonshow");
		chat_add_text("gave_ring", "Do with this ring as thou wilt, and I pray this evil shall yet be turned to good by your hand.", CHAT_DELAY, "kneel");
		chat_add_text("say_felewyn", "Felewyn is the goddess of order and law. [Elves] worship her as their creator, save for those who serve [Torkalath] or [Urdual].");
		chat_add_text("say_felewyn", "But those few are shunned, sometimes even hunted, by their more traditional kin.");
		chat_add_text("say_felewyn", "It is she who brought forth the herd animals and the hive-minded worker insects and other creatures of a calm and orderly nature in ages past...");
		chat_add_text("say_felewyn", "She encourages those would uphold the law of the land over their own selfish desires, who protect the weak from the strong, and maintain discipline and order.");
		chat_add_text("say_torkalath", "Torkalath is the god of strength, of freedom, and of chaos. He believes in strengthening ones self through strife and struggle.");
		chat_add_text("say_torkalath", "He encourages those who defend their individuality, who resist conformity, and those who realize their fullest potential in whatever they may do.");
		chat_add_text("say_torkalath", "He created the great predatory beasts of the land during the recovery that followed the War of Fate, granting them strength, cunning, and grace.");
		chat_add_text("say_torkalath", "It is He who eventually forged the soul of man: ever striving and ever ambitious, flexible, adaptable, and clever.");
		chat_add_text("say_torkalath", "He gifted the [Orcs] to [Lor Malgoriand] at the beginning of the [Age of Blood], and created many of the other great warrior races that dot the lands.");
		chat_add_text("say_urdual", "Urdual is the god of balance.", 3.0);
		chat_add_text("say_urdual", "The eldest of The Triad, His wisdom is sought after by the other two gods to determine the path of the ever-swinging pendulum of order and chaos.");
		chat_add_text("say_urdual", "[Torkalath] and [Felewyn] are at constant odds, and thus [Urdual] serves as the mediator between the two opposing forces of law and freedom.");
		chat_add_text("say_urdual", "After the War of Fate, it was He who established the never ending cycles of nature. May they endure eternally.");
		chat_add_text("say_urdual", "It is He who created the dwarven race, hearty and stoic, and as unshakable as the stones.");
		chat_add_text("say_urdual", "They dwell in the mountains that they may separate themselves from the constant conflicts of the lands. This allows them to play as impartial observers.");
		chat_add_text("say_urdual", "...Though it seems their quizzical nature rarely allows them to be exactly that.");
		chat_add_text("say_aob", "The Age of Blood of centuries past, describes the nearly two hundred year long war that ended The Crystal Eon of perfect order that came before it.");
		chat_add_text("say_aob", "It began at a time when order was so strong that all was stagnant, and they very freedom of thought itself was threatened!", 7.0);
		chat_add_text("say_aob", "But so violent was this war, that it broke beyond any new equilibrium, and into a terminal bloody chaos that threatened to engulf the world.", 7.0);
		chat_add_text("say_aob", "[Lor Malgoriand], Torkalath's newest [Apostle], the strongest He had ever imbued with power, had been tasked with ending The Crystal Eon...", 7.0);
		chat_add_text("say_aob", "...but alas, he was mad with grief from the moment of his endowment.");
		chat_add_text("say_aob", "This made him vulnerable to the influence of [The Lost], and before even the gods themselves had known it, he was consumed by the harnessing of their power.", 7.0);
		chat_add_text("say_aob", "It was for this reason that even when Torkalath revoked the power He had given His creation, [Lor Malgoriand] did not die.");
		chat_add_text("say_aob", "Instead, he grew only stronger, and more possessed of hatred.");
		chat_add_text("say_aob", "The war ended, with the return of the prophetic [Pathos], the rise of the [Apostle] Lanethan...");
		chat_add_text("say_aob", "...and the eventual slaying of [Lor Malgoriand] at the hands of [Felewyn] Herself.");
		chat_add_text("say_aob", "[Pathos] has left us again, returning to his sleeping comrades, and the [Apostles] of that age have also vanished, but He promised that,");
		chat_add_text("say_aob", "'In the The Beyond He dreams only of us, and thus He watches, and will return, should He be needed again.");
		chat_add_text("say_orcs", "The orcs were the first living, breathing tools of [Lor Malgoriand].");
		chat_add_text("say_orcs", "The first were the ice dwelling Maragor tribe, but soon after came the heat loving Borsh, or the [Shadahar] Tribe, as they are now known...");
		chat_add_text("say_orcs", "Lastly, he created the huge and all encompassing Black Hand tribe.");
		chat_add_text("say_orcs", "The Black Hand raids villages regularly in these parts to this day. It wasn't so long ago they nearly destroyed [Helena].");
		chat_add_text("say_orcs", "Although the orcs and the [undead] were both tools of [Lor Malgoriand], without their master, it seems they are no longer willing to cooperate.");
		chat_add_text("say_orcs", "This is fortunate for us! Indeed, it is the main reason we've managed to maintain the kingdom for so long, despite the hardships.");
		chat_add_text("say_undead", "The undead and the [orcs] were among the many vile tools of [Lor Malgoriand] of [The Lost], amongst other evils.");
		chat_add_text("say_undead", "Recently, a great force of undead has begun clawing its way up through the ground.");
		chat_add_text("say_undead", "If you can find some way to slow their progress, I would be very grateful.");
		chat_add_text("say_undead", "Bring me any relics you can find upon their dismembered corpses, and I will judge their usefulness.");
		chat_add_text("say_name_change", "For a fee, I can submit for a change of name permit from the King of Deralia, and officially change your name throughout the lands.");
		chat_add_text("say_name_change", "Beware, however, this fee increases exponentially each time, beginning at 100 gold.");
		chat_add_text("say_name_change", "Do you really wish to have your name changed?");
		chat_add_text("say_shad", "Shadahar was a feared necromancer just prior to the [Age of Blood].");
		chat_add_text("say_shad", "Though his more ambitious activities were kept in check by the forces of order, that were so prevalent at the time, he built many great palaces.", 7.0);
		chat_add_text("say_shad", "These were necropolises, where he stored armies of the dead, and other abominations, as he lie in wait for an age when he could rise to power.", 7.0);
		chat_add_text("say_shad", "Before his dreams could be realized, however, he was imprisoned by the Xyphemox Zahlon Erste.");
		chat_add_text("say_shad", "His greatest palace, a hall of great majesty hidden somewhere in the Aluhandra desert, lay abandon for centuries.");
		chat_add_text("say_shad", "But at the end of the [Age of Blood], the Borsh [orc] tribe, having been soundly defeated by the [elves], took refuge within its walls.", 7.0);
		chat_add_text("say_shad", "As they bided their time there, they were soon infected with its power.");
		chat_add_text("say_shad", "Their chief, the immortal Rungahr, together with his shamans, unlocked many of the necromancer's secrets.");
		chat_add_text("say_shad", "Under their chief's guidance, these enchanted orcs have become the most powerful in all the lands, and thus renamed themselves the tribe of Shadahar.", 7.0);
		chat_add_text("say_shad", "Thankfully, however, they rarely wander very far from their home of Shadahar, for it is the source of their power.");
		chat_add_text("say_maldora", "Ah Maldora... He is a mysterious one. A powerful wizard indeed, some say he may even be the reincarnation of [Lor Malgoriand] himself.", 7.0);
		chat_add_text("say_maldora", "There have been rumors of sightings of an ancient [Loreldian] flying fortress, at the very northern edges of the lands.");
		chat_add_text("say_maldora", "These same rumors claim that Maldora resides within that fortress.");
		chat_add_text("say_maldora", "Such fortresses have not been seen since the [Age of Blood] and even then, they were indeed rare.");
		chat_add_text("say_maldora", "Thus, if the rumors to be believed, then Maldora has achieved power almost beyond imagination. Who knows what evil he may bring upon us all?");
	}

	void say_hi()
	{
		chat_start_sequence("say_hi");
	}

	void say_city()
	{
		chat_start_sequence("say_city");
	}

	void say_bloodrose()
	{
		chat_start_sequence("say_bloodrose");
	}

	void say_elves()
	{
		chat_start_sequence("say_elves");
	}

	void say_loreldians()
	{
		chat_start_sequence("say_loreldians");
	}

	void say_unbal()
	{
		chat_start_sequence("say_unbal");
	}

	void say_thornlands()
	{
		chat_now("The Thornlands was once a beautiful place to visit, but the [unbalance] has destroyed its former luster.");
	}

	void say_changes()
	{
		chat_now("The grass rots. Birds and beasts die. The land is sick. Something must be done to stop the [undead].");
	}

	void say_job()
	{
		if ((CHAT_BUSY))
		{
			chat_busy_message();
		}
		if ((CHAT_BUSY)) return;
		chat_now("Well newcomers often look into town for such matters.");
		if (!(EVIDENCE_FOUND)) return;
		CHAT_DELAY("say_job2");
	}

	void say_job2()
	{
		chat_now("Maybe you could become an errand runner for the next mayor?", 3.0, "retina");
	}

	void worldevent_evidence_found()
	{
		EVIDENCE_FOUND = 1;
	}

	void say_pathos()
	{
		chat_start_sequence("say_pathos");
	}

	void say_temple()
	{
		chat_start_sequence("say_temple");
	}

	void say_temple3x()
	{
		chat_start_sequence("say_temple_more");
	}

	void say_history()
	{
		chat_start_sequence("say_history");
	}

	void say_forest()
	{
		chat_start_sequence("say_forest");
	}

	void say_malgor()
	{
		chat_start_sequence("say_malgor");
	}

	void say_thelost()
	{
		chat_start_sequence("say_thelost");
	}

	void say_apostles()
	{
		chat_start_sequence("say_apostles");
	}

	void say_rumor()
	{
		chat_start_sequence("say_rumor");
	}

	void say_pillarquest()
	{
		if ((ItemExists("ent_lastspoke", "item_runicsymbol2")))
		{
			chat_start_sequence("say_allIknow");
		}
		else
		{
			if ((ItemExists("ent_lastspoke", "item_runicsymbol")))
			{
			}
			RING_EXPLAINED = 1;
			chat_start_sequence("say_pq");
		}
	}

	void show_ring()
	{
		RING_EXPLAINED = 1;
		chat_start_sequence("say_pq");
	}

	void gave_ring()
	{
		RING_BEARER = param1;
		chat_start_sequence("gave_ring");
		ScheduleDelayedEvent(16.0, "gave_ring2");
	}

	void gave_ring2()
	{
		// TODO: offer RING_BEARER item_runicsymbol2
	}

	void say_felewyn()
	{
		chat_start_sequence("say_felewyn");
	}

	void say_torkalath()
	{
		chat_start_sequence("say_torkalath");
	}

	void say_urdual()
	{
		chat_start_sequence("say_urdual");
	}

	void say_aob()
	{
		chat_start_sequence("say_aob");
	}

	void say_helena()
	{
		chat_now("Helena is a trading outpost in the center of the human lands. Recently rebuilt, it still struggles to survive.");
	}

	void say_undead()
	{
		chat_start_sequence("say_undead");
	}

	void say_orcs()
	{
		chat_start_sequence("say_orcs");
	}

	void say_shad()
	{
		chat_start_sequence("say_shad");
	}

	void say_maldora()
	{
		chat_start_sequence("say_maldora");
	}

	void say_unquest()
	{
		PlayAnim("critical", "magic");
		SendInfoMsg("ent_lastspoke", DEBUG + " Quests data is being removed from your character.");
		// quest unset "ent_lastspoke" "emote_sitting"
		// quest unset "ent_lastspoke" "quest_ring"
	}

	void change_name_intro()
	{
		if ((CHAT_BUSY))
		{
			chat_busy_message();
		}
		if ((CHAT_BUSY)) return;
		if (!(IsValidPlayer(param1)))
		{
			NAME_REQ_ID = GetEntityIndex("ent_lastspoke");
		}
		if ((IsValidPlayer(param1)))
		{
			NAME_REQ_ID = GetEntityIndex(param1);
		}
		chat_start_sequence("say_name_change");
		ScheduleDelayedEvent(12.0, "send_name_change_menu");
		DID_CHANGE_INTRO = 1;
		SENDING_YN = 1;
		CHAT_MENU_ON = 0;
	}

	void send_name_change_menu()
	{
		OpenMenu(NAME_REQ_ID);
	}

	void game_menu_cancel()
	{
		if ((REPORTER_REWARD_MODE))
		{
			REPORTER_REWARD_MODE = 0;
			CHAT_MENU_ON = 1;
		}
		if (!(DID_CHANGE_INTRO)) return;
		DID_CHANGE_INTRO = 0;
		CHAT_MENU_ON = 1;
	}

	void check_reporters()
	{
		string CUR_ID = ARRAY_REPORTER_IDS[int(i)];
		string CUR_SLOT = ARRAY_REPORTER_SLOTS[int(i)];
		string CUR_LEVEL = ARRAY_REPORTER_LEVELS[int(i)];
		if ((G_DEVELOPER_MODE))
		{
			string CUR_ID = GetPlayerAuthId(USER_ID);
			int CUR_SLOT = 1;
			string CUR_LEVEL = ARRAY_REPORTER_LEVELS[int(0)];
		}
		if (!(CUR_ID == GetPlayerAuthId(USER_ID))) return;
		if (!(CUR_SLOT == GetEntityProperty(USER_ID, "slot"))) return;
		if (!(GetPlayerQuestData(USER_ID, "rep") < CUR_LEVEL)) return;
		CUR_LEVEL -= GetPlayerQuestData(USER_ID, "rep");
		if ((IS_REPORTER)) return;
		if (!(REPRESS_COUNT))
		{
			SayText("You have " + int(CUR_LEVEL) + " rewards pending.");
		}
		IS_REPORTER = 1;
	}

	void game_menu_getoptions()
	{
		USER_ID = param1;
		IS_REPORTER = 0;
		if ((REPORTER_REWARD_MODE))
		{
			REPRESS_COUNT = 1;
		}
		else
		{
			REPRESS_COUNT = 0;
			for (int i = 0; i < int(ARRAY_REPORTER_IDS.length()); i++)
			{
				check_reporters();
			}
		}
		if ((IS_REPORTER))
		{
			if (!(REPORTER_REWARD_MODE))
			{
			}
			string reg.mitem.title = "Get Exploit Report Reward";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "give_reporter_menu";
		}
		if ((REPORTER_REWARD_MODE))
		{
			for (int i = 0; i < int(ARRAY_REPORTER_IDS.length()); i++)
			{
				check_reporters();
			}
			if ((IS_REPORTER))
			{
			}
			REWARD_MAXIDX = 2;
			if (REWARD_IDX == 0)
			{
				string reg.mitem.title = "All 5 Felewyn Symbols";
				string reg.mitem.type = "callback";
				string reg.mitem.data = "special_felewyn5";
				string reg.mitem.callback = "give_reporter_reward";
				string reg.mitem.title = "Reset Name Change Count";
				string reg.mitem.type = "callback";
				string reg.mitem.data = "special_name_change_reset";
				string reg.mitem.callback = "give_reporter_reward";
				string reg.mitem.title = "Summon Bear Scroll";
				string reg.mitem.type = "callback";
				string reg.mitem.data = "scroll2_summon_bear1";
				string reg.mitem.callback = "give_reporter_reward";
				string reg.mitem.title = "Thunder Breaker";
				string reg.mitem.type = "callback";
				string reg.mitem.data = "blunt_bt";
				string reg.mitem.callback = "give_reporter_reward";
				string reg.mitem.title = "Chromatic Armor";
				string reg.mitem.type = "callback";
				string reg.mitem.data = "armor_rehab";
				string reg.mitem.callback = "give_reporter_reward";
				string reg.mitem.title = "A pair of Crescent Blades";
				string reg.mitem.type = "callback";
				string reg.mitem.data = "special_wcre";
				string reg.mitem.callback = "give_reporter_reward";
				string reg.mitem.title = "Steam Crossbow";
				string reg.mitem.type = "callback";
				string reg.mitem.data = "bows_sxbow";
				string reg.mitem.callback = "give_reporter_reward";
				string reg.mitem.title = "Unholy Blade";
				string reg.mitem.type = "callback";
				string reg.mitem.data = "swords_ub";
				string reg.mitem.callback = "give_reporter_reward";
				string reg.mitem.title = "[Other ";
				reg.mitem.title += int((REWARD_IDX + 1));
				reg.mitem.title += "/";
				reg.mitem.title += int((REWARD_MAXIDX + 1));
				reg.mitem.title += "]";
				string reg.mitem.type = "callback";
				string reg.mitem.data = "special_other";
				string reg.mitem.callback = "give_reporter_reward";
			}
			if (REWARD_IDX == 1)
			{
				string reg.mitem.title = "Shadowfire Blade";
				string reg.mitem.type = "callback";
				string reg.mitem.data = "swords_sf";
				string reg.mitem.callback = "give_reporter_reward";
				string reg.mitem.title = "Storm Pharos's Lance";
				string reg.mitem.type = "callback";
				string reg.mitem.data = "polearms_ph";
				string reg.mitem.callback = "give_reporter_reward";
				string reg.mitem.title = "Lance of Affliction";
				string reg.mitem.type = "callback";
				string reg.mitem.data = "polearms_a";
				string reg.mitem.callback = "give_reporter_reward";
				string reg.mitem.title = "A pair of Blood Blades";
				string reg.mitem.type = "callback";
				string reg.mitem.data = "special_bloodblades";
				string reg.mitem.callback = "give_reporter_reward";
				string reg.mitem.title = "Phlame's Staff";
				string reg.mitem.type = "callback";
				string reg.mitem.data = "blunt_staff_f";
				string reg.mitem.callback = "give_reporter_reward";
				string reg.mitem.title = "Ice Staff";
				string reg.mitem.type = "callback";
				string reg.mitem.data = "blunt_staff_i";
				string reg.mitem.callback = "give_reporter_reward";
				string reg.mitem.title = "Vorpal Dagger";
				string reg.mitem.type = "callback";
				string reg.mitem.data = "smallarms_eth";
				string reg.mitem.callback = "give_reporter_reward";
				string reg.mitem.title = "[Other ";
				reg.mitem.title += int((REWARD_IDX + 1));
				reg.mitem.title += "/";
				reg.mitem.title += int((REWARD_MAXIDX + 1));
				reg.mitem.title += "]";
				string reg.mitem.type = "callback";
				string reg.mitem.data = "special_other";
				string reg.mitem.callback = "give_reporter_reward";
			}
			if (REWARD_IDX == 2)
			{
				string reg.mitem.title = "Skull Scythe";
				string reg.mitem.type = "callback";
				string reg.mitem.data = "axes_ss";
				string reg.mitem.callback = "give_reporter_reward";
				string reg.mitem.title = "Wintercleaver";
				string reg.mitem.type = "callback";
				string reg.mitem.data = "axes_df";
				string reg.mitem.callback = "give_reporter_reward";
			}
			if (REWARD_IDX == REWARD_MAXIDX)
			{
				string reg.mitem.title = "[Back to First Page]";
				string reg.mitem.type = "callback";
				string reg.mitem.data = "special_other";
				string reg.mitem.callback = "give_reporter_reward";
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (!(SENDING_YN))
		{
			if (!(DID_CHANGE_INTRO))
			{
				string reg.mitem.title = "Change my name";
				string reg.mitem.type = "callback";
				string reg.mitem.callback = "change_name_intro";
			}
			if ((ItemExists(param1, "item_runicsymbol")))
			{
				if (!(RING_EXPLAINED))
				{
					string reg.mitem.title = "Show the Expended Ring";
					string reg.mitem.type = "callback";
					string reg.mitem.callback = "show_ring";
				}
				else
				{
					string reg.mitem.title = "Give the Expended Ring";
					string reg.mitem.type = "payment";
					string reg.mitem.data = "item_runicsymbol";
					string reg.mitem.callback = "gave_ring";
				}
			}
		}
		if ((SENDING_YN))
		{
			string CHANGE_NAME_TIMES = GetPlayerQuestData(param1, "n");
			if (CHANGE_NAME_TIMES == 0)
			{
				int CHANGE_NAME_FEE = 100;
			}
			if (CHANGE_NAME_TIMES == 1)
			{
				int CHANGE_NAME_FEE = 1000;
			}
			if (CHANGE_NAME_TIMES == 2)
			{
				int CHANGE_NAME_FEE = 10000;
			}
			if (CHANGE_NAME_TIMES == 3)
			{
				int CHANGE_NAME_FEE = 100000;
			}
			if (CHANGE_NAME_TIMES == 4)
			{
				int CHANGE_NAME_FEE = 1000000;
			}
			if (CHANGE_NAME_TIMES >= 5)
			{
				int CHANGE_NAME_FEE = 10000000;
			}
			string reg.mitem.title = "Yes";
			string reg.mitem.type = "payment";
			string reg.mitem.data = "gold:";
			string reg.mitem.callback = "change_name_yes";
			string reg.mitem.cb_failed = "change_name_payment_failed";
			SayText("The fee for this service , in your case , would be " + CHANGE_NAME_FEE + " gold.");
			string reg.mitem.title = "no";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "change_name_no";
			SENDING_YN = 0;
			CHAT_MENU_ON = 1;
		}
	}

	void change_name_payment_failed()
	{
		PlayAnim("critical", "no");
		chat_now("I'm afraid you do not have sufficient funds to cover the king's fees.", 3.0, "none", "clear_que");
		DID_CHANGE_INTRO = 0;
		CHAT_MENU_ON = 1;
	}

	void change_name_no()
	{
		PlayAnim("critical", "yes");
		chat_now("That is quite all right, it is better to be certain of one's identity than to change it on a whim.", 4.0, "none", "clear_que");
		DID_CHANGE_INTRO = 0;
		CHAT_MENU_ON = 1;
	}

	void change_name_yes()
	{
		chat_now("Speak forth the name you shall hence forth be known as...", 3.0, "none", "clear_que");
		CHANGING_NAME = 1;
	}

	void game_heardtext()
	{
		if (!(CHANGING_NAME)) return;
		if ((G_DEVELOPER_MODE))
		{
			SendColoredMessage(GetEntityIndex(param2), "Zomg " + GetEntityName(param2) + "spoke to me! " + GetEntityName("ent_lastspoke"));
		}
		if (GetEntityIndex(param2) != NAME_REQ_ID)
		{
			SayText("Shush , " + GetEntityName(NAME_REQ_ID) + " here is going to provide me with his new name.");
		}
		if (!(GetEntityIndex(param2) == NAME_REQ_ID)) return;
		string L_NEW_NAME = param1;
		string L_SPACE = " ";
		if ((L_NEW_NAME).substr(0, 1) == L_SPACE)
		{
			SayText(I + " m sorry, but you cannot begin your name with a space.");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (L_NEW_NAME != /* TODO: $alphanum */ $alphanum(L_NEW_NAME, L_SPACE))
		{
			SayText(I + " m sorry, but your name seems to have some characters in it that will not fit in the paperwork.");
			SendInfoMsg(NAME_REQ_ID, "Alphanumerics and Spaces Only Please Otherwise, bad things would happen.");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if ((L_NEW_NAME).length() > 30)
		{
			SayText(I + " m sorry, but your name is too long.");
			SendInfoMsg(NAME_REQ_ID, "Name must be under 30 characters Otherwise, bad things would happen.");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (L_NEW_NAME == "Saint Thoth")
		{
			int L_NICE_TRY = 1;
		}
		if (L_NEW_NAME == "Thothie")
		{
			int L_NICE_TRY = 1;
		}
		if (L_NEW_NAME == "Saint Thothie")
		{
			int L_NICE_TRY = 1;
		}
		if ((L_NICE_TRY))
		{
			SayText("Yeeeaaah... No.");
			PlayAnim("critical", "no");
			return;
		}
		string L_NEW_NAME = /* TODO: $alphanum */ $alphanum(L_NEW_NAME, L_SPACE);
		string CHANGE_NAME_TIMES = GetPlayerQuestData(NAME_REQ_ID, "n");
		int CHANGE_NAME_TIMES = int(CHANGE_NAME_TIMES);
		CHANGE_NAME_TIMES += 1;
		SetPlayerQuestData(NAME_REQ_ID, "n");
		string OLD_NAME = GetEntityName(NAME_REQ_ID);
		// TODO: playername NAME_REQ_ID L_NEW_NAME
		string MSG_TXT = "From this day forth, ";
		MSG_TXT += OLD_NAME;
		MSG_TXT += " shall now be known as ";
		MSG_TXT += L_NEW_NAME;
		MSG_TXT += "!";
		SendInfoMsg("all", "A PROCLOMATION RINGS THROUGHOUT THE LAND! " + MSG_TXT);
		PlayAnim("critical", "talkright");
		string OUT_STR = "Very well, from this day forth your name shall be ";
		OUT_STR += L_NEW_NAME;
		chat_now(OUT_STR, 3.0, "none", "abort");
		DID_CHANGE_INTRO = 0;
		CHANGING_NAME = 0;
		CHAT_MENU_ON = 1;
	}

	void give_reporter_menu()
	{
		CHAT_MENU_ON = 0;
		SayText("Please select your reward.");
		REPORTER_REWARD_MODE = 1;
		REPORTER_ID = param1;
		ScheduleDelayedEvent(0.1, "send_reward_menu");
	}

	void send_reward_menu()
	{
		OpenMenu(REPORTER_ID);
	}

	void give_reporter_reward()
	{
		if ((param2).findFirst("special_other") == 0)
		{
			REWARD_IDX += 1;
			if (REWARD_IDX > REWARD_MAXIDX)
			{
				REWARD_IDX = 0;
			}
			ScheduleDelayedEvent(0.1, "send_reward_menu");
			return;
		}
		CHAT_MENU_ON = 1;
		REPORTER_REWARD_MODE = 0;
		IS_REPORTER = 0;
		string REP_LEVEL = GetPlayerQuestData(param1, "rep");
		REP_LEVEL += 1;
		SetPlayerQuestData(param1, "rep");
		if ((param2).findFirst("special") == 0)
		{
			if (param2 == "special_name_change_reset")
			{
				SayText("It is done. Your name change costs have been reset.");
				SetPlayerQuestData(param1, "n");
				chat_move_mouth(5.0);
				chat_convo_anim();
			}
			if (param2 == "special_felewyn5")
			{
				SetPlayerQuestData(param1, "f");
				SayText("It is done. I present to you all five Felewyn Symbols.");
				// TODO: offer PARAM1 item_s1
				// TODO: offer PARAM1 item_s2
				// TODO: offer PARAM1 item_s3
				// TODO: offer PARAM1 item_s4
				// TODO: offer PARAM1 item_s5
				chat_move_mouth(5.0);
				chat_convo_anim();
			}
			if (param2 == "special_wcre")
			{
				SayText("It is done. I present to you a pair of Crescent Blades.");
				// TODO: offer PARAM1 smallarms_cre
				// TODO: offer PARAM1 smallarms_cre
				chat_move_mouth(5.0);
				chat_convo_anim();
			}
			if (param2 == "special_bloodblades")
			{
				SayText("It is done. I present to you a pair of Blood Blades.");
				// TODO: offer PARAM1 swords_vb
				// TODO: offer PARAM1 swords_vb
				chat_move_mouth(5.0);
				chat_convo_anim();
			}
		}
		else
		{
			SayText("The gods thank ye for your aid. Here is your chosen reward.");
			// TODO: offer PARAM1 PARAM2
			chat_move_mouth(5.0);
			chat_convo_anim();
		}
		// TODO: UNCONVERTED: savenow PARAM1
	}

}

}

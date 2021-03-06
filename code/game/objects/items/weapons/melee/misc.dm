/obj/item/melee
	needs_permit = 1

/obj/item/melee/chainofcommand
	name = "chain of command"
	desc = "A tool used by great men to placate the frothing masses."
	icon_state = "chain"
	item_state = "chain"
	flags = CONDUCT
	slot_flags = SLOT_BELT
	force = 10
	throwforce = 7
	w_class = WEIGHT_CLASS_NORMAL
	origin_tech = "combat=5"
	attack_verb = list("flogged", "whipped", "lashed", "disciplined")
	hitsound = 'sound/weapons/slash.ogg' //pls replace


/obj/item/melee/chainofcommand/suicide_act(mob/user)
		to_chat(viewers(user), "<span class='suicide'>[user] is strangling [user.p_them()]self with the [src.name]! It looks like [user.p_theyre()] trying to commit suicide.</span>")
		return (OXYLOSS)

/obj/item/melee/rapier
	name = "captain's rapier"
	desc = "An elegant weapon, for a more civilized age."
	icon_state = "rapier"
	item_state = "rapier"
	flags = CONDUCT
	force = 15
	throwforce = 10
	w_class = WEIGHT_CLASS_BULKY
	block_chance = 50
	armour_penetration = 75
	sharp = 1
	origin_tech = "combat=5"
	attack_verb = list("lunged at", "stabbed")
	hitsound = 'sound/weapons/rapierhit.ogg'
	materials = list(MAT_METAL = 1000)

/obj/item/melee/rapier/hit_reaction(mob/living/carbon/human/owner, attack_text, final_block_chance, damage, attack_type)
	if(attack_type == PROJECTILE_ATTACK)
		final_block_chance = 0 //Don't bring a sword to a gunfight
	return ..()

/obj/item/melee/icepick
	name = "ice pick"
	desc = "Used for chopping ice. Also excellent for mafia esque murders."
	icon_state = "icepick"
	item_state = "icepick"
	force = 15
	throwforce = 10
	w_class = WEIGHT_CLASS_SMALL
	attack_verb = list("stabbed", "jabbed", "iced,", "drill")

/obj/item/weapon/melee/icepick/attack(mob/living/M as mob, mob/living/user as mob)
	if(user.a_intent == INTENT_HELP)
		if(user.zone_sel.selecting == "eyes")
			var/time = 80
			var/mob/living/carbon/human/H = M	//si el mob tiene algo que proteja sus ojos
			if(istype(H) && ((H.head && H.head.flags_cover & HEADCOVERSEYES) || (H.wear_mask && H.wear_mask.flags_cover & MASKCOVERSEYES) || (H.glasses && H.glasses.flags_cover & GLASSESCOVERSEYES)))
				to_chat(user, "<span class='notice'>You're going to need to remove that [(H.head && H.head.flags_cover & HEADCOVERSEYES) ? "helmet" : (H.wear_mask && H.wear_mask.flags_cover & MASKCOVERSEYES) ? "mask" : "glasses"] first.</span>")
				return

			if(istype(H))
				var/obj/item/organ/internal/eyes/eyes = H.get_int_organ(/obj/item/organ/internal/eyes)
				if(M.stat == DEAD)	//si el mob esta muerto
					to_chat(user, "<span class='notice'>[M]'s dead, it's no use trying..</span>")
				else if(!eyes)		//si el mob no tiene ojos
					to_chat(user, "<span class='notice'>You can't practice lobotomy with [M]</span>")
				else
					if(M == user)	//si intentas hacertelo a ti mismo
						visible_message("<span class='notice'>You can't do this to yourself.</span>")
					else
						visible_message("<span class='notice'>[user] directs [src] to [M]'s eyes.</span>", \
											 "<span class='notice'>You direct [src] to [M]'s eyes.</span>")
						if(do_after(user, time, 0, target = user))
							visible_message("<span class='notice'>[user] practiced lobotomy with [M]</span>")
							//M.visible_message("<span class='notice'>[src] / [M] / [user]</span>")
							to_chat(M, "<span class='warning'>You feel different..</span>")
							if(prob(15))
								M.mutations.Add(CHAV)
							else if(prob(20))
								M.mutations.Add(TOURETTES)
							else if(prob(15))
								M.mutations.Add(MUTE)
							else if(prob(8))
								M.mutations.Add(DEAF)
							else if(prob(7))
								M.mutations.Add(SWEDISH)
							else if(prob(3))
								M.adjustBrainLoss(rand(1,5))
							else if(prob(1))
								M.mutations.Add(TK)
							else
								M.mutations.Add(NERVOUS)
			else
				to_chat(user, "<span class='notice'>You can't practice lobotomy with this species</span>")
		else
			return ..()
	else
		return ..()

/obj/item/melee/candy_sword
	name = "candy cane sword"
	desc = "A large candy cane with a sharpened point. Definitely too dangerous for schoolchildren."
	icon_state = "candy_sword"
	item_state = "candy_sword"
	force = 10
	throwforce = 7
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("slashed", "stabbed", "sliced", "caned")
/obj/item/implant/adrenal
	name = "Adrenal Implant"
	desc = "Quickly release potent stimulants into the user's bloodstream."
	icon_state = "adrenal"
	uses = 7
	COOLDOWN_DECLARE(adrenal_cooldown)

/obj/item/implanter/adrenal
	name = "implanter (adrenal)"
	imp_type = /obj/item/implant/adrenal

/obj/item/implantcase/adrenal
	name = "implant case - 'Adrenal'"
	desc = "A glass case containing an Adrenal implant."
	imp_type = /obj/item/implant/freedom


/obj/item/implant/adrenal/activate()
	if(isnull(imp_in))
		return
	if(!COOLDOWN_FINISHED(src, adrenal_cooldown))
		balloon_alert(imp_in, "Ready to use in [round(COOLDOWN_TIMELEFT(src, adrenal_cooldown)/10)] seconds!")
		return

	imp_in.SetAllImmobility(0)
	imp_in.adjustStaminaLoss(-200)
	imp_in.remove_status_effect(/datum/status_effect/speech/stutter)
	imp_in.reagents.add_reagent(/datum/reagent/medicine/stimulants, 5)
	COOLDOWN_START(src, adrenal_cooldown, ADRENAL_IMPLANT_COOLDOWN)

	uses--
	if(uses < 1)
		balloon_alert(imp_in, "Last Adrenal implant charge used!")
		qdel(src)
		return
	to_chat(imp_in, span_notice("Adrenal implant activated, charges left: [uses]!"))

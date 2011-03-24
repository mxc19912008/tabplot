tableGUI_pal_layout <- function(e) {
	with(e, {
		#### load color palettes
		brewer_pals_info <- brewer.pal.info[brewer.pal.info$category=="qual",]
		
		pals <- mapply(FUN=function(x,y){brewer.pal(y, x)}, row.names(brewer_pals_info), brewer_pals_info$maxcolors)
		names(pals) <- tolower(names(pals))
		
		# remove color red (needed for NA's)
		pals$set1 <- pals$set1[-1]
		
		# create list with palettes: first the default one (Brewer_Set1+Brewer_Set2), then the brewer palettes
		pals <- c(list(default=c(pals$set1, pals$set2)), pals, list(custom=c(pals$set1, pals$set2)))
		
		wdw_pal <- gwindow("Color palette", width=150, height=100, parent=wdw, visible=TRUE)
		#wdw_pal <- gwindow("Color palette", width=200, height=100)
		gpan_pal <- gpanedgroup(cont=wdw_pal)
		
		grp_pal1 <- ggroup(horizontal = FALSE, cont = gpan_pal, expand=FALSE)
		frm_pal1 <- gframe(text="Categorical Variable", horizontal = FALSE, cont = grp_pal1) 


		#lbl_pal <- glabel("Categorical variable:", cont=grp_pal3)
		cmb_pal1 <- gcombobox(NULL, cont=frm_pal1)

		frm_pal2 <- gframe(text="Color palette", horizontal = FALSE, cont = grp_pal1) 
		
		grp_pal3 <- ggroup(horizontal = TRUE, cont = frm_pal2, expand=TRUE)


		grp_pal5 <- ggroup(horizontal = FALSE, cont = grp_pal3, expand=FALSE)
		tbl_pal <- glayout(container=grp_pal5, spacing = 2)
	
		# make 8,2 layout for palette
		for (i in 1:8) {
			tbl_pal[i,1] <- glabel(text = "", container =tbl_pal)
		}

		cairoLoaded <- require(cairoDevice)
		# if (cairoLoaded) {
			# tbl_pal[1:8,2] <- ggraphics(width = 75 * 0.5, height = 75 * 3, dpi = 75, ps=8, container=tbl_pal)
		# } else {
			for (i in 1:8) {
				tbl_pal[i,2] <- ""
			}
		# }

		grp_pal4 <- ggroup(horizontal = FALSE, cont = grp_pal3, expand=FALSE)
		cmb_pal2 <- gcombobox(names(pals), cont=grp_pal4)

		grp_pal6 <- ggroup(horizontal = TRUE, cont = grp_pal4, expand=FALSE)
		lbl_pal <- glabel("start color:", cont=grp_pal6)
		spb_col <- gspinbutton(1, 16, by = 1, cont=grp_pal6, expand=FALSE)
		svalue(spb_col) <- 1

		addSpring(grp_pal4)
		
		btn_cancel <- gbutton("Cancel", container = grp_pal4)
		btn_ok <- gbutton("OK", container = grp_pal4)
		
		
		
	})
}
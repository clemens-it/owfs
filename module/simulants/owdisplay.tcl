# $Id$
###########################################################
###########################################################
########## Enough of notebook, lets do Simulant! ##########
###########################################################
###########################################################

###########################################################
########## Status bar / messages panel ####################
###########################################################

proc StatusFrame { fram } {
    global serve
    set serve(frame) [labelframe $fram.f -text "OWSERVER Simulator $serve(port)" -labelanchor n -relief ridge -borderwidth 3 -padx 5 -pady 5 -bg #996633 -fg white]
    pack $serve(frame) -side top -fill x
    set serve(text) [text $serve(frame).text -relief ridge -yscrollcommand "$serve(frame).scroll set" -state normal -wrap char -takefocus 0 -setgrid 1 -height 7 -bg #330000]
    scrollbar $serve(frame).scroll -command "$serve(frame).text yview"
    pack $serve(frame).scroll -side right -fill y
    pack $serve(frame).text -side left -fill both -expand 1
    # tags
    $serve(text) tag configure listen -foreground black -background yellow
    $serve(text) tag configure accept -foreground blue -background yellow
    $serve(text) tag configure read -foreground white
    $serve(text) tag configure write -foreground yellow
}

###########################################################
########## Status bar / messages panel ####################
###########################################################

proc SetupPanels { pane } {
    global chip
    global devname
    
    set chip(panel) [frame $pane.left]
    pack $chip(panel) -fill both
    set chip(paner) [frame $pane.right -bg #996633]
    pack $chip(paner) -fill both
    $pane add $chip(panel) $chip(paner)

    foreach dev $devname {
        set addr $chip($dev)
        radiobutton $chip(panel).$addr -variable chip(selected) -text $dev -value $addr
        pack $chip(panel).$addr -side top -fill x
    }

    trace add variable chip(selected) {write} Raise

    # Now set to first
    set chip(selected) $chip([lindex $devname 0])

#    scrollbar $panel.scroll -command "$pane.left.listbox yview"
#    set chosen [listbox $panel.listbox -yscroll "$pane.left.scroll set"  -listvariable devname -setgrid 1 -height 12 -bg #FFFF99]
 #   pack $panel.scroll -side right -fill y
 #   pack $panel.listbox -side left -expand 1 -fill both

#    bind $chosen <<ListboxSelect>> {Rside  %W}
#    $pane add $panel $paner
#    set selected_device $chip([lindex $devname 0])
#    $chip($selected_device.process) $selected_device $paner
}

proc Raise {ar in op} {
    global chip
    eval destroy [winfo children $chip(paner)]
    set addr $chip(selected)
    $chip($addr.process) $addr $chip(paner)
}

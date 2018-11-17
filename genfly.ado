*! version 0.2 17Oct2018 Mauricio Caceres Bravo, mauricio.caceres.bravo@gmail.com
*! Wrapper to generate variables on the fly

cap program drop genfly
program genfly
    version 14
    _on_colon_parse `0'
    local 1 `s(after)'
    local 1_: copy local 1
    local ix 0

    * Check the parsing is OK everywhere before engaging in possibly
    * costly variable creation

    qui while ustrregexm(`"`1_'"', "\{([^{}]+?)\}") {
        tempvar v`++ix'
        local g`ix' = ustrregexs(1)
        local label = `"`=ustrregexs(1)'"'
        cap _on_colon_parse `g`ix''
        if ( _rc == 0 & `"`s(before)'"' != "" ) {
            local namelabel `s(before)'
            gettoken v`ix' label: namelabel
        }
        confirm new var `v`ix''
        local 1_ = ustrregexrf(`"`1_'"', "\{([^{}]+?)\}", `"`v`ix''"')
    }

    * Do the actual replace and variable creation

    local ix 0
    qui while ustrregexm(`"`1'"', "\{([^{}]+?)\}") {
        local g`++ix' = ustrregexs(1)
        local label = `"`=ustrregexs(1)'"'
        cap _on_colon_parse `g`ix''
        if ( _rc == 0 & `"`s(before)'"' != "" ) {
            local namelabel `s(before)'
            gettoken v`ix' label: namelabel
            local g`ix' `s(after)'
            local label `label'
        }
        gen `v`ix'' = `g`ix''
        label var `v`ix'' `"`label'"'
        local 1 = ustrregexrf(`"`1'"', "\{([^{}]+?)\}", `"`v`ix''"')
    }
    `1'
end

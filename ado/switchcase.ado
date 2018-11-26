*! version 0.1 24Nov2018 Mauricio Caceres Bravo, mauricio.caceres.bravo@gmail.com
*! Switch variable case between styles (camel, mixed, snake, toggle, upper, lower)

capture program drop switchcase
program switchcase
    local whatlist toggle upper lower camel snake mixed
    local msg Unknown option -`what'-. Choose one of: `whatlist'

    gettoken what 0: 0
    _assert(`:list what in whatlist'), msg("`msg'")

    syntax [varlist]
    if ( "`what'" == "toggle" ) {
        local switch SwItChToGgLe
    }
    else if ( "`what'" == "upper" ) {
        rename `varlist', upper
        exit 0
    }
    else if ( "`what'" == "lower" ) {
        rename `varlist', lower
        exit 0
    }
    else if ( "`what'" == "camel" ) {
        local switch switchCamel
    }
    else if ( "`what'" == "snake" ) {
        local switch switch_snake
    }
    else if ( "`what'" == "mixed" ) {
        local switch SwitchMixed
    }

    local newvarlist
    qui foreach var of varlist `varlist' {
        `switch' `var'
        local newvarlist `newvarlist' `newvar'
    }
    rename (`varlist') (`newvarlist')
end

capture program drop SwItChToGgLe
program SwItChToGgLe
    args var
    local lower  `c(alpha)'
    local upper  `c(ALPHA)'
    local digit  0 1 2 3 4 5 6 7 8 9
    local under  _
    local newvar
    forvalues i = 1 / `=length("`var'")' {
        local l = substr("`var'", `i', 1)
        local isl: list l in lower
        local isU: list l in upper
        if ( `isl' ) {
            local newvar `newvar'`=upper("`l'")'
        }
        else if ( `isU' ) {
            local newvar `newvar'`=lower("`l'")'
        }
        else {
            local newvar `newvar'`l'
        }
    }
    c_local newvar `newvar'
end

capture program drop SwitchMixed
program SwitchMixed
    args var
    local lower `c(alpha)'
    local upper `c(ALPHA)'
    local digit 0 1 2 3 4 5 6 7 8 9
    local under _
    local newvar

    local toupper = 1
    local n = length("`var'")
    {
        local l = substr("`var'", 1, 1)
        local previsl: list l in lower
        local previsU: list l in upper
        local previs_: list l in under
        if ( `previsl' | `previsU' ) {
            local l = upper("`l'")
            local toupper = 0
            local newvar `newvar'`l'
        }
    }

    forvalues i = 2 / `n' {
        local l = substr("`var'", `i', 1)
        local isl: list l in lower
        local isU: list l in upper
        local is_: list l in under
        if ( `isl' | `isU' ) {
            if ( (`toupper') | (`isU' & (!`previsU' & !`previs_')) ) {
                local l = upper("`l'")
                local toupper = 0
            }
            else {
                local l = lower("`l'")
            }
        }
        else if ( `is_' ) {
            local l
            local toupper = 1
        }
        local newvar `newvar'`l'

        {
            local previsl: copy local isl
            local previsU: copy local isU
            local previs_: copy local is_
        }
    }

    c_local newvar `newvar'
end

capture program drop switch_snake
program switch_snake
    args var
    local lower `c(alpha)'
    local upper `c(ALPHA)'
    local digit 0 1 2 3 4 5 6 7 8 9
    local under _
    local newvar

    local n = length("`var'")
    local l = substr("`var'", 1, 1)
    local previsl: list l in lower
    local previsU: list l in upper
    local previs_: list l in under
    local newvar `newvar'`=lower("`l'")'

    forvalues i = 2 / `n' {
        local l = substr("`var'", `i', 1)
        local isl: list l in lower
        local isU: list l in upper
        local is_: list l in under
        local l = lower("`l'")
        if ( (!`previsU' & !`previs_') & `isU' ) {
            local newvar `newvar'_`l'
        }
        else {
            local newvar `newvar'`l'
        }
        local previsl: copy local isl
        local previsU: copy local isU
        local previs_: copy local is_
    }
    if ( length("`newvar'") > 32 ) {
        disp as err "Cannot rename `var'; snake_case version has more than 32 characters"
        exit 198
    }

    c_local newvar `newvar'
end

capture program drop switchCamel
program switchCamel
    args var
    local lower `c(alpha)'
    local upper `c(ALPHA)'
    local digit 0 1 2 3 4 5 6 7 8 9
    local under _
    local newvar

    local j = 0
    local n = length("`var'")
    local toupper = 0
    local firstlower = 1
    while ( `j' < `n' & `firstlower' ) {
        local ++j
        local previsl: list l in lower
        local previsU: list l in upper
        local previs_: list l in under
        local l = lower(substr("`var'", `j', 1))
        local newvar `newvar'`l'
        if ( `previsU' ) local firstlower 0
    }

    local ++j
    forvalues i = `j' / `n' {
        local l = substr("`var'", `i', 1)
        local isl: list l in lower
        local isU: list l in upper
        local is_: list l in under
        if ( `isl' | `isU' ) {
            if ( (`toupper') | (`isU' & (!`previsU' & !`previs_')) ) {
                local l = upper("`l'")
                local toupper = 0
            }
            else {
                local l = lower("`l'")
            }
        }
        else if ( `is_' ) {
            local l
            local toupper = 1
        }
        local newvar `newvar'`l'

        {
            local previsl: copy local isl
            local previsU: copy local isU
            local previs_: copy local is_
        }
    }

    c_local newvar `newvar'
end

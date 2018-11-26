*! version 0.3 24Sep2018 Mauricio Caceres Bravo, mauricio.caceres.bravo@gmail.com
*! Generic benchmark of Stata commands

* Not really sure if there's a canon way to benchmark Stata programs;
* this is a short hack I wrote for it that works OK.
capture program drop benchmark
program benchmark, rclass

    * Parse program
    _on_colon_parse `0'
    local 0 `s(before)'
    local 1 `s(after)'
    syntax, [timer(int 0) reps(int 1) DISPlay TRace last restore save]
    if ( "`trace'" != "" ) local display display

    _assert(`reps' > 0), msg("-reps- must be positive.")

    * Iterate `reps' and report the result of each run
    qui {
        tempname benchmark average results
        timer list
        if ( `timer' ) {
            local i = `timer'
            _assert(`i' < 100 & `i' > 0), msg("-timer()- must be between 1 and 99.")
        }
        else {
            local i = 99
            while ( (`i' > 0) & ("`r(t`i')'" != "") ) {
                local --i
            }
            if ( `i' == 0 ) {
                disp as err "No open timers; pass option -timer()- explicitly."
                exit 198
            }
        }
    }

    local timerok = 1
    forvalues r = 1 / `reps' {
        local qui
        if ( ("`last'" != "") & (`r' < `reps') ) {
            local qui qui
        }
        if ( "`last'" != "" ) {
            if ( ("`restore'" != "") & (`r' < `reps') ) preserve
        }
        else if ( "`restore'" != "" ) preserve

        benchmarkClear
        timer clear `i'
        timer on `i'
        `qui' `1'
        timer off `i'
        if ( `r' == `reps' ) {
            _return hold `results'
        }

        if ( "`last'" != "" ) {
            if ( ("`restore'" != "") & (`r' < `reps') ) restore
        }
        else if ( "`restore'" != "" ) restore

        qui timer list
        matrix `benchmark' = nullmat(`benchmark') \ `r', r(t`i')
        if ( r(t`i') == . ) local timerok = 0

        if ( "`display'" != "" ) di "`r': `:di trim("`:di %21.4gc r(t`i')'")' seconds"
    }

    if ( `timerok' == 0 ) {
        disp as err "Warning: Program cleared temporary timer `i'; benchmark not accurate."
        disp as err "Try passing option -timer()- explicitly."
        _return restore `results'
        exit 0
    }

    * Report average over runs
    qui {
        timer off `i'
        if ("`save'" == "") timer clear `i'
        mata: st_numscalar("`average'", sum(st_matrix("`benchmark'")[., 2]) / `reps')
    }

    local average_str = "`:di trim("`:di %21.3fc scalar(`average')'")'"
    if ( `reps' == 1 ) di "`average_str' seconds"
    else di "Average over `reps' runs: `average_str' seconds"

    * If program was an rclass program, don't clear those results
    _return restore `results'
    return add
    return scalar bench_mean = `average'
    return matrix bench_mat  = `benchmark'
end

capture program drop benchmarkClear
program benchmarkClear, rclass
    qui disp
end

*! version 0.2 17Oct2018 Mauricio Caceres Bravo, mauricio.caceres.bravo@gmail.com
*! Output the first observations of the dataset in memory

capture program drop head
program head
    syntax [anything] [if], [*]
    set more off
    set trace off
    if ( !`=_N > 0' ) error 2000

    * First, parse the number of lines to print. Either the first 10 or
    * the number specified by the user.

    if ( regexm(`"`anything'"', "^[ ]*([0-9]+)") ) {
        local n1 = regexs(1)
        gettoken n2 anything: anything
        cap assert `n1' == `n2'
        if ( _rc ) error 198
        local n = `n1'
    }
    else local n = 10

    * Number of rows must be positive
    if ( `n' <= 0 ) {
        disp as err "n must be > 0"
        exit 198
    }

    * Parse varlist and if condition
    local 0 `anything' `if', `options'
    syntax [varlist] [if/], [*]

    * Apply if condition then get the first n matching condition
    qui if ( "`if'" != "" ) {
        local stype = cond(`=_N' < maxlong(), "long", "double")
        tempvar touse sumtouse index
        gen byte `touse' = `if'
        gen `stype' `sumtouse' = sum(`touse')
        gen `stype' `index' = _n
        local last = `=`sumtouse'[_N]'
        if ( `n' == 1 ) {
            local ifin if (`sumtouse' == `n') & `touse' == 1
        }
        else {
            local ifin if (`sumtouse' >= 1) & (`sumtouse' <= `n') & `touse' == 1
        }
    }
    else {
        local ifin in 1 / `=min(`n', _N)'
    }

    list `varlist' `ifin', `options'
end

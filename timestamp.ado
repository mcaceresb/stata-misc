*! version 0.2 17Oct2018 Mauricio Caceres Bravo, mauricio.caceres.bravo@gmail.com
*! Print time-stamp with basic info about the data in memory

capture program drop timestamp
program timestamp
    local nobs: di trim("`:di %21.0fc c(N)'")
    local nvar: di trim("`:di %21.0fc c(k)'")
    local sobs = cond(`c(N)' == 1, "", "s")
    local svar = cond(`c(k)' == 1, "", "s")

    local bytes = c(width) * c(N)
    local i = 0
    while ( `bytes' > 1024 & `++i' < 4 ) {
        local bytes = `bytes' / 1024
    }

         if ( `i' == 1 ) local bsuffix bytes
    else if ( `i' == 2 ) local bsuffix KiB
    else if ( `i' == 3 ) local bsuffix MiB
    else                 local bsuffix GiB

    local bytes = trim("`:di %21.1fc `bytes'' `bsuffix'")

    display _n(1) "{hline `=min(79, c(linesize))'}"
    if (`"`0'"' != "") display `"`0'"'

    * local flavor `c(flavor)'
    * if ( `c(SE)' == 1 ) local flavor SE
    * if ( `c(MP)' == 1 ) local flavor MP
    * display "Stata/`flavor' `c(stata_version)' for `c(os)' (`c(processors)'-core `c(bit)'-bit)"

    display `"`=char(9)'Dataset:   `c(filename)'"'
    if ( `c(changed)' ) {
    display `"`=char(9)'           (not saved)"'
    }
    display  "`=char(9)'In memory: `nobs' observation`sobs'"
    display  "`=char(9)'           `nvar' variable`svar'"
    display  "`=char(9)'           `bytes'"
    display  "`=char(9)'Timestamp: `c(current_time)' `c(current_date)'"
    display  "{hline 79}" _n(1)
end

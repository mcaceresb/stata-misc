*! version 0.1 17Sep2016 Mauricio Caceres, caceres@nber.org
*! String to date-time

capture program drop todatetime
program todatetime
    syntax varlist, [Generate(str) replace datefmt(str) format(str) dateonly]
    local datelist `varlist'

    * Check function call is sane
	if ("`generate'" != "") & ("`replace'" != "") {
		di as err "{p}options generate and replace are mutually exclusive{p_end}"
		exit 198
	}

	if ("`generate'" == "") & ("`replace'" == "") {
		di as err "{p}must specify either generate or replace option{p_end}"
		exit 198
	}

    if ("`generate'" != "") & (`:list sizeof datelist' != `:list sizeof generate') {
        di as err "{p}number of variables in varlist " ///
                  "must equal number of variables in generate(newvarlist){p_end}"
        exit 198
    }
    else if ("`generate'" != "") {
		local 0 `generate'
		capture syntax newvarlist
		if _rc {
            di as err "generate(newvarlist) invalid"
            exit _rc
		}
    }

    * Figure out if date or datetime is requested
    if ("`datefmt'" == "") local datefmt MDYhm
    if regexm("`datefmt'", "[hms]") local dt fromdtm
    else local dt fromdt

    * Loop through date-time variables being converted
    local fmtlist ""
    foreach datevar of varlist `datelist' {
        tempvar vdtm
        if ("`dt'" == "fromdt") {
            * Uses date
            gen `vdtm' = date(`datevar', "`datefmt'")
        }
        else {
            * Uses date-time
            gen `vdtm' = clock(`datevar', "`datefmt'")
        }

        * dateonly should only be used if converting from date-time
        if ("`dateonly'" != "") replace `vdtm' = dofc(`vdtm')

        * Replace or generate in the correct order
        if ("`replace'"  == "") {
            gettoken datetime generate: generate
            order `vdtm', after(`datevar')
            rename `vdtm' `datetime'
            local fmtlist `fmtlist' `datetime'
        }
        else {
            order `vdtm', after(`datevar')
            label var `vdtm' "`variable label `datevar''"
            drop `datevar'
            rename `vdtm' `datevar'
            local fmtlist `fmtlist' `datevar'
        }
    }

    * Apply display format if requested
    if ("`format'" != "") {
        format `format' `fmtlist'
    }
end

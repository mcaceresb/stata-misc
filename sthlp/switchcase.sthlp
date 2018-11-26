{smcl}
{* *! version 0.1 24Nov2018}{...}
{cmd:help switchcase}
{hline}

{title:Title}

{pstd}
{hi:switchcase} {hline 2} Switch variable case between various styles.
{p_end}

{marker syntax}{title:Syntax}

{pstd}
The default is to switch the case of {bf:{it:every}} variable to the
style specified; however the user can specify a specific list of
variables.

{pstd}
Switch to {opt camelCase}

{p 8 29 2}
{cmd:switchcase} camel [{varlist}]

{pstd}
Switch to {opt MixedCase}

{p 8 29 2}
{cmd:switchcase} mixed [{varlist}]

{pstd}
Switch to {opt snake_case}

{p 8 29 2}
{cmd:switchcase} snake [{varlist}]

{pstd}
tOgGlE the variable's case

{p 8 29 2}
{cmd:switchcase} toggle [{varlist}]

{pstd}
Upper and lower (wrappers for {opt rename, upper} and {opt rename, lower})

{p 8 29 2}
{cmd:switchcase} upper [{varlist}]

{p 8 29 2}
{cmd:switchcase} lower [{varlist}]

{marker ex}{title:Examples}

{pmore}{inp:clear                                                        }{p_end}
{pmore}{inp:set obs 1                                                    }{p_end}
{pmore}{inp:gen foo_bar_long_version = 1                                 }{p_end}
{pmore}{inp:gen foo_bar = 1                                              }{p_end}
{pmore}{inp:gen m_foo_b_ = 1                                             }{p_end}

{pmore}{inp:foreach what in camel snake mixed toggle toggle lower upper {c -(}}{p_end}
{pmore}{inp:    switchcase `what'                                        }{p_end}
{pmore}{inp:    ds, varwidth(32)                                         }{p_end}
{pmore}{inp:}                                                            }{p_end}

{title:Authors}

{pstd}Mauricio Caceres{p_end}
{pstd}{browse "mailto:mauricio.caceres.bravo@gmail.com":mauricio.caceres.bravo@gmail.com }{p_end}
{pstd}{browse "https://mcaceresb.github.io":mcaceresb.github.io}{p_end}

{pstd}
I am also the author of the {manhelp gtools R:gtools} project,
a collection of utilities for working with big data. See
{browse "https://github.com/mcaceresb/stata-gtools":github.com/mcaceresb/stata-gtools}{p_end}

{title:Also see}

{p 4 13 2}
{help gtools} (if installed)

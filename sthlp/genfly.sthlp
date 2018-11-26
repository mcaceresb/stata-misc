{smcl}
{* *! version 0.2 17Oct2018}{...}
{cmd:help genfly}
{hline}

{title:Title}

{pstd}
{hi:genfly} {hline 2} Generate variables on the fly
{p_end}

{marker syntax}{title:Syntax}

{pstd}
{cmd:genfly} generates variables on the fly within arbitrary stata
commands. By default this creates a temporary variable that is
discarded after the command is run:

{p 8 29 2}
{cmd:genfly}
{cmd::} {it:command}
{c -(}{it:{help exp}}{c )-}

{pstd}
Optionally, however, the user can add a variable name and label
and save the generated variable:

{p 8 29 2}
{cmd:genfly}
{cmd::} {it:command}
{c -(}{newvar} "label" {cmd::} {it:{help exp}}{c )-}

{marker ex}{title:Examples}

{pmore}{inp:sysuse auto, clear                                           }{p_end}
{pmore}{inp:genfly: tab {mpg<=20} {price<=5000}                          }{p_end}
{pmore}{inp:genfly: tab rep78 {{logp "Log Price": log(price)}<=9}, mi    }{p_end}
{pmore}{inp:genfly: reg price mpg {mpg2: mpg^2} {mpginv: 1/mpg} i.foreign}{p_end}
{pmore}{inp:desc logp mpg2 mpginv                                        }{p_end}

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

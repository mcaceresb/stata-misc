{smcl}
{* *! version 0.2 17Oct2018}{...}
{cmd:help tail}
{hline}

{title:Title}

{pstd}
{hi:tail} {hline 2} Output the last observations of the dataset in memory
{p_end}

{marker syntax}{title:Syntax}

{p 8 29 2}
{cmd:tail}
[{it:n}]
{varlist}
{help if}
{cmd:,}
[{it:options}]

{marker desc}{title:Description}

{pstd} {cmd:tail} Is a very simple wrapper to output the first {it:n}
observations of the dataset in memory. All options are pased to {help list}.

{marker ex}{title:Examples}

{pmore}{inp:sysuse auto, clear}{p_end}
{pmore}{inp:tail}{p_end}
{pmore}{inp:tail 5 if foreign, sepby(rep78)}{p_end}

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
{help head}, {help gtools} (if installed)

{smcl}
{* *! version 0.2 17Oct2018}{...}
{cmd:help timestamp}
{hline}

{title:Title}

{pstd}
{hi:timestamp} {hline 2} Print time and basic info about the data in memory
{p_end}

{marker syntax}{title:Syntax}

{p 8 29 2}
{cmd:timestamp} [{it:comment}]

{marker desc}{title:Description}

{pstd} {cmd:timestamp} Is a very simple wrapper to print the current
date-time to the console, along with some basic info about the data set
loaded in memory (name, size, shape). Optionally add a {it:comment} that
is printed along with the timestamp.

{marker ex}{title:Examples}

{pmore}{inp:timestamp}{p_end}
{pmore}{inp:sysuse auto, clear}{p_end}
{pmore}{inp:timestamp Loaded data into memory}{p_end}

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

{smcl}
{* *! version 0.1 17Sep2016}{...}
{cmd:help todatetime}
{hline}

{title:Title}

{pstd}
{hi:todatetime} {hline 2} Convert strings to date-time
{p_end}

{marker syntax}{title:Syntax}

{p 8 29 2}
{cmd:todatetime}
{varlist}
{cmd:,}
{c -(}{opth g:enerate(newvarlist)}{c |}{opt replace}{c )-}
[{it:{help todatetime##todatetime_options:todatetime_options}}]

{synoptset 23 tabbed}{...}
{marker todatetime_options}{...}
{synopthdr :todatetime_options}
{synoptline}
{p2coldent :* {opth g:enerate(newvarlist)}}generate {it:newvar_1}, ..., {it:newvar_k} for each variable in {varlist}{p_end}
{p2coldent :* {opt replace}}replace string variables in {varlist} with numeric variables{p_end}
{synopt :{opt datefmt(str)}}date format (e.g. YMD, MDYhms, etc.). Defaults to {opt MDYhm}.{p_end}
{synopt :{opt format(str)}}display format of resulting variables.{p_end}
{synopt :{opt dateonly}}convert datetime to date and drop datetime.{p_end}
{synoptline}
{pstd}* Either {opt generate(newvarlist)} or {opt replace} is required.
{p2colreset}{...}

{marker desc}{title:Description}

{pstd} {cmd:todatetime} Is a very simple wrapper to convert strings to datetime. It requires the user to know the format of the string being converted.{p_end}

{marker ex}{title:Examples}

{pmore}{inp:sysuse gnp96}{p_end}
{pmore}{inp:tostring date, format(%td_NN/DD/CCYY) gen(datestr) force}{p_end}
{pmore}{inp:todatetime datestr, gen(dateback) datefmt(MDY)}{p_end}
{pmore}{inp:assert date == dateback}{p_end}

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

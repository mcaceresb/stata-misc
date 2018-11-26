{smcl}
{* *! version 0.3 24Sep2018}{...}
{cmd:help benchmark}
{hline}

{title:Title}

{pstd}
{hi:benchmark} {hline 2} Quick hack to benchmark Stata commands
{p_end}

{marker syntax}{title:Syntax}

{pstd}
{cmd:benchmark},
[{it:{help benchmark##benchmark_options:options}}]
: {it:Stata command to benchmark}

{synoptset 23 tabbed}{...}
{marker benchmark_options}{...}
{synopthdr :benchmark_options}
{synoptline}

{syntab:Main}
{synopt:{opt reps(int)}} Number of repetitions. Default is 1. {p_end}
{synopt:{opt trace}} Trace how long each iteration takes to run. {p_end}
{synopt:{opt last}} Only display the last iteration. When used with {opt restore}, do not wrap last iteration in preserve/restore. {p_end}
{synopt:{opt timer(int)}} Specify timer to use for benchmark. Default looks for any open timer. {p_end}
{synopt:{opt restore}} Wrap commad in preserve/restore pairs. {p_end}
{synopt:{opt save}} Save the last run time within Stta's {opt timer}. {p_end}

{marker desc}{title:Description}

{pstd} {cmd:benchmark} is a very simple wrapper to determine how long a code takes to run. I have found it useful whenever I want to optimize a piece of code.{p_end}

{marker ex}{title:Examples}

{phang}Randomize a dataset into 2 groups, checking for balance by gender.{p_end}

{pmore}{inp:sysuse auto, clear                       }{p_end}
{pmore}{inp:bench, reps(10) trace last: reg price mpg}{p_end}
{pmore}{inp:return list                              }{p_end}
{pmore}{inp:bench, reps(5) restore last: gen x = 1   }{p_end}
{pmore}{inp:ds x                                     }{p_end}

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

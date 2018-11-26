Misc Collection of Stata Utilities
==================================

This is a collection of miscellaneous Stata snippets that I use across
several of my projects.

`version 0.1 24Nov2018`

Installation
------------

Since `misc` is a generic name, the package installed will be called
`mcmisc` (`mc` for my initials):

```stata
local github "https://raw.githubusercontent.com"
net install mcmisc, from(`github'/mcaceresb/stata-misc/master/build/)
* adoupdate, update
* ado uninstall mcmisc
```

Except for `genfly`, all files require at least Stata 13 (but they will
likely work in earlier versions as they are not terribly esoteric).
`genfly` uses the improved regular expressions engine that was
introduced in version 14, so it will only work in Stata 14 and later.

Included
--------

- `bench` (`benchmark`): Time or benchmark stata programs.
- `genfly`: Generate variables on the fly.
- `head` and `tail`: Output the first or last observations of a dataset.
- `switchcase`: Switch the case style of variables (mixed, camel, snake, etc.)
- `timestamp`: Print time stamp and basic data info (name, size, shape) to log.
- `todatetime`: Convert strings to date-time.

Usage
-----

```stata

* Timestamp
* ---------

clear
timestamp
set seed 1729
set obs 1000
timestamp

* Generate data
* -------------

gen x1 = runiform()
gen x2 = rnormal()
gen x3 = runiform() * 10
gen x4 = rnormal()
gen y  = 1 + x1 - x2 + 2 * (x3 <= 5) - 3 / x4 + rnormal() * 2
gen var1 = int(100 * runiform())
gen var2 = int(100 * runiform())

* Heads and tails
* ---------------

head
tail
head 7 x?
tail 12 var* if mod(_n, 4)

* Genfly
* ------

genfly: tab {s1: var1<=60} {s2: var2<=70}
genfly: tab {{s3 "Log v1 * 10": log(var1 * 10)}<=60} {var2<=70}
genfly: reg y x1 x2 {x3<=5} {x5 "Inverse of x4": 1/x4}
desc

* Switchcase
* ----------

clear
set obs 1
gen foo_bar_long_version = 1
gen foo_bar = 1
gen m_foo_b_ = 1
foreach what in camel snake mixed toggle toggle lower upper {
    switchcase `what'
    ds, varwidth(32)
}

* Benchmark
* ---------

sysuse auto, clear
bench, reps(10) trace last: reg price mpg
return list
bench, reps(5) restore last: gen x = 1
ds x

* Todatetime
* ----------

sysuse gnp96, clear
tostring date, format(%td_NN/DD/CCYY) gen(datestr) force
todatetime datestr, gen(dateback) datefmt(MDY)
assert date == dateback
```

License
-------

`stata-misc` is [MIT-licensed](https://github.com/mcaceresb/stata-misc/blob/master/LICENSE)

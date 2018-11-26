*! version 0.3 24Sep2018 Mauricio Caceres Bravo, mauricio.caceres.bravo@gmail.com
*! Generic benchmark of Stata commands

capture program drop bench
program bench, rclass
    benchClear
    benchmark `0'
    return add
end

capture program drop benchClear
program benchClear, rclass
    qui disp
end

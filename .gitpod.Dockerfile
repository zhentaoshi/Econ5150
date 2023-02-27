
FROM ztshi/econ_data_sci:AER
# tag “AER”. updated on 2023-2-27

RUN R --slave -e 'install.packages("rjson", repos="https://cran.r-project.org/")' 
# "rjson": 2023-1-26 (comment must be in a seperate line)
RUN R --slave -e 'install.packages("optimx", repos="https://cran.r-project.org/")' 


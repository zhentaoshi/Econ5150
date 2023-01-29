
FROM ztshi/econ_data_sci:latest 
# tag “lastest”. updated on 2023-1-24

RUN R --slave -e 'install.packages("rjson", repos="https://cran.r-project.org/")' 
# "rjson": 2023-1-26 (comment must be in a seperate line)


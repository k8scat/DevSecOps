#!/bin/bash

user=""
password=""
host=""
port="3306"
database=""
tables=""
file=""

mysqldump -u${user} \
-p${password} \
-h${host} \
-P${port} \
--opt \
--where="1=1 limit 10" \
${database} ${tables} > ${file}

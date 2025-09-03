%let pgm=utl-select-the-last-row-in-a-table-using-sas-r-python-sql-without-monotonic;

%stop_submission;

Select the last row in a table using sas r python sql without monotonic;

 THREE SOLUTIONS

    1 sas sql
    2 r sql
    3 python sql

INPUT
=====

Obs COL1 COL2

 1   A     1
 2   D     3
 3   B     5
 4   E     4
 5   A     3
 6   G     1
 7   G     1
 8   E     5
 9   G     5 ** select this

OUTPUT
======

TMP is holding space
for seq computations

COL1 COL2 TMP SEQ

 G     5       9

github
https://tinyurl.com/zb4dnasw
https://github.com/rogerjdeangelis/utl-select-the-last-row-in-a-table-using-sas-r-python-sql-without-monotonic

communities.sas
https://tinyurl.com/ye2ystnf
https://communities.sas.com/t5/SAS-Programming/How-to-find-last-record-using-proc-sql/m-p/744732#M233350

/**************************************************************************************************************************/
/* INPUT                     | PROCESS                                              | OUTPUT                              */
/* =====                     | =======                                              | ======                              */
/* SD1.HAVE                  | 1 SAS SQL                                            | SD1.WANT                            */
/*                           | =========                                            | COL1 COL2 TMP ROW                   */
/* Obs COL1 COL2             |                                                      |                                     */
/*                           | %let row=0;                                          |  G     5       9                    */
/*  1   A     1              | proc sql;                                            |                                     */
/*  2   D     3              |  create                                              |                                     */
/*  3   B     5              |    table want as                                     |                                     */
/*  4   E     4              |  select                                              |                                     */
/*  5   A     3              |    *                                                 |                                     */
/*  6   G     1              |  from                                                |                                     */
/*  7   G     1              |    (select                                           |                                     */
/*  8   E     5              |       *                                              |                                     */
/*  9   G     5              |      ,resolve('%let row=%eval(&row+1);') as tmp      |                                     */
/*                           |      ,symget('row') as row length=1                  |                                     */
/* options                   |    from                                              |                                     */
/*  validvarname=upcase;     |       sd1.have)                                      |                                     */
/* libname sd1 "d:/sd1";     |  having                                              |                                     */
/* data sd1.have;            |      row=max(row)                                    |                                     */
/* input  col1$ col2;        | ;quit;                                               |                                     */
/* cards4;                   |                                                      |                                     */
/* A 1                       |                                                      |                                     */
/* D 3                       | 2 R SQL                                              | > want                              */
/* B 5                       | =======                                              |   COL1 COL2                         */
/* E 4                       |                                                      | 1    G    5                         */
/* A 3                       | proc datasets lib=sd1                                |                                     */
/* G 1                       |   nolist nodetails;                                  |                                     */
/* G 1                       |  delete want;                                        | SAS                                 */
/* E 5                       | run;quit;                                            | COL1 COL2                           */
/* G 5                       |                                                      |                                     */
/* ;;;;                      | %utl_rbeginx;                                        |  G     5                            */
/* run;quit;                 | parmcards4;                                          |                                     */
/*                           | library(haven)                                       |                                     */
/*                           | library(sqldf)                                       |                                     */
/*                           | source("c:/oto/fn_tosas9x.R")                        |                                     */
/*                           | options(sqldf.dll="d:/dll/sqlean.dll")               |                                     */
/*                           | have<-read_sas("d:/sd1/have.sas7bdat")               |                                     */
/*                           | print(have)                                          |                                     */
/*                           | want<-sqldf('                                        |                                     */
/*                           |   select                                             |                                     */
/*                           |      *                                               |                                     */
/*                           |   from                                               |                                     */
/*                           |      have                                            |                                     */
/*                           |   where                                              |                                     */
/*                           |      rowid=(select max(rowid) from have)             |                                     */
/*                           | ')                                                   |                                     */
/*                           |                                                      |                                     */
/*                           | want                                                 |                                     */
/*                           | fn_tosas9x(                                          |                                     */
/*                           |       inp    = want                                  |                                     */
/*                           |      ,outlib ="d:/sd1/"                              |                                     */
/*                           |      ,outdsn ="want"                                 |                                     */
/*                           |      )                                               |                                     */
/*                           | ;;;;                                                 |                                     */
/*                           | %utl_rendx;                                          |                                     */
/*                           |                                                      |                                     */
/*                           | proc print data=sd1.want;                            |                                     */
/*                           | run;quit;                                            |                                     */
/*                           |                                                      |                                     */
/*                           |                                                      |                                     */
/*                           | 2 SAME CODE IN PYTHON                                |                                     */
/*                           | =====================                                |                                     */
/**************************************************************************************************************************/

/*                   _
(_)_ __  _ __  _   _| |_
| | `_ \| `_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
*/

options
 validvarname=upcase;
libname sd1 "d:/sd1";
data sd1.have;
input  col1$ col2;
cards4;
A 1
D 3
B 5
E 4
A 3
G 1
G 1
E 5
G 5
;;;;
run;quit;


/**************************************************************************************************************************/
/*  Obs    COL1    COL2                                                                                                   */
/*                                                                                                                        */
/*   1      A        1                                                                                                    */
/*   2      D        3                                                                                                    */
/*   3      B        5                                                                                                    */
/*   4      E        4                                                                                                    */
/*   5      A        3                                                                                                    */
/*   6      G        1                                                                                                    */
/*   7      G        1                                                                                                    */
/*   8      E        5                                                                                                    */
/*   9      G        5                                                                                                    */
/**************************************************************************************************************************/

/*                             _
/ |  ___  __ _ ___   ___  __ _| |
| | / __|/ _` / __| / __|/ _` | |
| | \__ \ (_| \__ \ \__ \ (_| | |
|_| |___/\__,_|___/ |___/\__, |_|
                            |_|
*/

%let row=0;
proc sql;
 create
   table want as
 select
   *
 from
   (select
      *
     ,resolve('%let row=%eval(&row+1);') as tmp
     ,symget('row') as row length=1
   from
      sd1.have)
 having
     row=max(row)
;quit;

/**************************************************************************************************************************/
/*| COL1    COL2    TMP    ROW                                                                                            */
/*|  G        5             9                                                                                             */
/**************************************************************************************************************************/

/*___                     _
|___ \   _ __   ___  __ _| |
  __) | | `__| / __|/ _` | |
 / __/  | |    \__ \ (_| | |
|_____| |_|    |___/\__, |_|
                       |_|
*/

proc datasets lib=sd1
  nolist nodetails;
 delete want;
run;quit;

%utl_rbeginx;
parmcards4;
library(haven)
library(sqldf)
source("c:/oto/fn_tosas9x.R")
options(sqldf.dll="d:/dll/sqlean.dll")
have<-read_sas("d:/sd1/have.sas7bdat")
print(have)
want<-sqldf('
  select
     *
  from
     have
  where
     rowid=(select max(rowid) from have)
')

want
fn_tosas9x(
      inp    = want
     ,outlib ="d:/sd1/"
     ,outdsn ="want"
     )
;;;;
%utl_rendx;

proc print data=sd1.want;
run;quit;

/**************************************************************************************************************************/
/* > want      |  SAS                                                                                                     */
/*   COL1 COL2 |  COL1    COL2                                                                                            */
/* 1    G    5 |   G        5                                                                                             */
/**************************************************************************************************************************/

/*____               _   _                             _
|___ /   _ __  _   _| |_| |__   ___  _ __    ___  __ _| |
  |_ \  | `_ \| | | | __| `_ \ / _ \| `_ \  / __|/ _` | |
 ___) | | |_) | |_| | |_| | | | (_) | | | | \__ \ (_| | |
|____/  | .__/ \__, |\__|_| |_|\___/|_| |_| |___/\__, |_|
        |_|    |___/                                |_|
*/

proc datasets lib=sd1 nolist nodetails;
delete pywant;
run;quit;

%utl_pybeginx;
parmcards4;
exec(open('c:/oto/fn_pythonx.py').read());
have,meta=ps.read_sas7bdat('d:/sd1/have.sas7bdat');
want=pdsql('''
  select
     *
  from
     have
  where
     rowid = (select max(rowid) from have)
   ''');
print(want);
fn_tosas9x(want
  ,outlib='d:/sd1/'   \
  ,outdsn='pywant',timeest=3);
;;;;
%utl_pyendx;

proc print data=sd1.pywant;
run;quit;


/**************************************************************************************************************************/
/*  PYTHON          |   SAS                                                                                               */
/*     COL1  COL2   |   Obs    COL1    COL2                                                                               */
/*   0    G   5.0   |    1      G        5                                                                                */
/**************************************************************************************************************************/

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/

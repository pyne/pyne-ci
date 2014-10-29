pyne-ci
=======

Continuous Integration scripts for PyNE core using Batlab

Post PR nightlies restart process
=================================

 - login to batlab with info from google drive doc
 - enter the following commands:
```sh
cd pyne-ci
git pull origin master
```
 - Determine the current recurrence id # using:
```sh
nmi_list_recurring_runs
```
 - Then remove the associated Recurrence ID:
```sh
nmi_rm <recurrence id>
```
The recurrence ID is typically a number like 913202.0 (the .0 is required)
 - Finally restart nightlies: 
```sh
 nmi_submit pyne.nightly.run-spec 
```

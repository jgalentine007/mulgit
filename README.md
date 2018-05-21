# mulgit #

Simple bash 4 script that runs Git commands against multiple directories / repositories.

## Install ##

Install `mulgit` globally:

`npm install mulgit -g`

**Windows installations require that Git Bash be installed when installing Git (it is by default.)**

## Configure ##

In your Git repository base path, create a file called `.mulgit`

In the `.mulgit` file specify Git repository paths relative to the project your `.mulgit` file resides. Don't forget to include the current repository by adding `.` to the file!

Example `.mulgit` file:

```
.
../some_other_repo
../yet_another_repo
```

## Usage ##

**mulgit** will check that the `.mulgit` file exists and whether the paths contained in it are Git repositories. **mulgit** will then change to each of the path directories and execute the Git command and any arguments provided.

From a bash prompt:

`mulgit status`
`mulgit add .`
`mulgit pull`
etc..

From a windows command prompt:

`mulgitwin status`
`mulgitwin add .`
`mulgitwin pull`
etc..
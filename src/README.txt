INSTRUCTIONS:

Note: All commands must be run from the project's /src directory.

1) First run the python code. The main requirements are pandas and numpy, but
   they are all listed in the requirements.txt file. Use your favorite package
   manager (I recommend pip, which comes with virtualenv) to install.
   In the case of pip a simple command is all that is needed:
   pip install -r requirements.txt

2) Once the requirements are intalled, simply run:
   python experiments.py
   To generate the necessary csv files to the respective subdirectories of the
   data/ directory.

3) Once step 2 is done, go on the R command prompt by simply typing:
   R
   Then install caret as follows:
   install.packages('caret', dependencies = TRUE)

4) Finally, all that will be necessary to run all the algorithms and generate
   all the plots to the img/ directory is the following command:
   Rscript runner.R

Troubleshooting:

If on step 3 you run into the error:

"ld: cannot find -lgfortran"

make sure r-base-dev is installed by running:

yum install r-base-dev

If it was already installed, and you still get the same error, make sure
the gfortran compiler is installed:

yum install gcc44-gfortran

And if it was aleady present, create the following symbolic link:

sudo ln -s /usr/lib/x86_64-linux-gnu/libgfortran.so.3 /usr/lib/libgfortran.so

And things should work normally.

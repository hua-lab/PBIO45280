# 1. Log into your user account

# 2. Go to your home directory by type the command below

	cd	

# 3. Find whether you have a .bash_profile file in your home folder using one of the command in Part 1.

# 4. Use Vim to edit a program

# 5. Open .bash_profile via vim

	vim .bash_profile

# 6. Enter the editing model of vim by typing

	i

# 7. If the .bash_profile does not exist, enter the following code to establish the head lines of .bash_profile

# .bash_profile
# get the aliases and functions
if [ -f ~/.basgrc ]; then
. ~/.bashrc
fi
#user specific environment and startup programs

@ 8. Add a PATH to your .bash_profile

PATH=$PATH:path_to_the directory_of_your_executable_files
export PATH

# 9. Save your .bash_profile with the commands below

esc
:wq

# 10. Log out your account

	exit


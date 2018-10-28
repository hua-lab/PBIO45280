
# 1. SSH to your user account (ID: your OU ID, PW:PBIO5280) through Putty (Win) or Terminal (Mac)

	ssh –X your_OU_ID@132.235.146.140

# 2.  Lists the files and directories in the folder when you log in (home folder)

	ls –l  
# lists your files in 'long format'

	ls –all 
# lists all files, including hidden files

# 3. Make a new directory

	mkdir programs 
# make a new folder, named programs, for compiling local programs

# 4. Path of a file

	pwd 
#tells you where you currently are

# 5. Change directory

	cd dirname
	cd 
#only cd, go to your home directory

# 6. Copy a file from your personal computer (client) to a folder of your account on the server (terminal of your MAC or WinSCP of Windows)

	scp path_to_file_in_your_computer your_OU_ID@132.235.146.140:/path to the directory

# 7. Copy a file

	cp path_to_file1 path-to_file2

# 8. Change the file/folder name

	mv old_file new_file

# 9. Delete a file (be careful, you cannot undo any commands in the terminal!)

	rm ./old_file

# 10. Uncompress a file 

	gunzip filename.gz
	tar -xvzf filename.tar.gz
	bzip2 -d filename.bz2

# 11. Find the user name

 	whoami


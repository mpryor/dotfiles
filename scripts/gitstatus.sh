# Expand all subdirectories into full path and iterate over them

RED='\033[0;31m'
NC='\033[0m' # No Color

for dir in $(ls -d $PWD/*/);
	do 
		cd $dir;
		# Retrieve origin master branch, and redirect output to null
		git fetch origin master &>/dev/null;

		# Retrieve git status, if message contains the word behind, then we need to update.

		if ((git status | grep behind) &> /dev/null);
			then printf "${RED}$dir needs to be pulled${NC}\n";
		elif ((git status | grep ahead) &> /dev/null);
			then printf "${RED}$dir needs to be pushed.${NC}\n";
		elif ((git status | grep "Changes not staged") &> /dev/null);
			then printf "${RED}$dir has modified files that have not been commit.${NC}\n";
		elif ((git status | grep "Changes to be commit") &> /dev/null);
			then printf "${RED}$dir has files that have not been commit.${NC}\n";
		elif ((git status | grep "Untracked") &> /dev/null);
			then printf "${RED}$dir has untracked files.${NC}\n";
		else
			printf "$dir does not need updating.\n";
		fi;
done;
	

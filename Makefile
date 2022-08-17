WD=`pwd`

echo:
	echo $(WD)

build:
	docker build -t bioc_flow:devel .
run:
	docker run -it --user rstudio -w /home/rstudio/workspace -v $(WD):/home/rstudio/workspace  bioc_flow:devel bash
	
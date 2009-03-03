PREFIX = ${PWD}
DIST_DIR = ${PWD}/dist
JS_DIRNAME = js

# For checkout
USEFORK = dantman
USERNAME = 

ifdef USERNAME
REPO_CORE        = git@github.com:${USERNAME}/4query.git
REPO_INTERACTIVE = git@github.com:${USERNAME}/4query.interactive.git
REPO_CANVAS      = git@github.com:${USERNAME}/4query.canvas.git
else
REPO_CORE        = git://github.com/${USEFORK}/4query.git
REPO_INTERACTIVE = git://github.com/${USEFORK}/4query.interactive.git
REPO_CANVAS      = git://github.com/${USEFORK}/4query.canvas.git
endif

git@github.com:dantman/4query.git

checkenv:
	@@echo -n "core/        "; if [ ! -d core/        ]; then echo "not found\nFAIL!"; exit; else echo "found"; fi
	@@echo -n "interactive/ "; if [ ! -d interactive/ ]; then echo "not found\nFAIL!"; exit; else echo "found"; fi
	@@echo -n "canvas/      "; if [ ! -d canvas/      ]; then echo "not found\nFAIL!"; exit; else echo "found"; fi
	@@echo "OK!\n"

quick: checkenv
	@@echo "*** Building 4query core ***"
	@@cd core; make PREFIX=${PREFIX} DIST_DIR=${DIST_DIR}/${JS_DIRNAME} quick
	@@echo
	
	@@echo "*** Building 4query.interactive ***"
	@@cd interactive; make PREFIX=${PREFIX} DIST_DIR=${DIST_DIR}/interactive WEB="../js" all
	@@echo
	
	@@echo "*** Building 4query.canvas ***"
	@@cd canvas; make PREFIX=${PREFIX} DIST_DIR=${DIST_DIR}/${JS_DIRNAME} all
	@@echo

all: checkenv
	@@echo "*** Building 4query core ***"
	@@cd core; make PREFIX=${PREFIX} DIST_DIR=${DIST_DIR}/${JS_DIRNAME} all
	@@echo
	
	@@echo "*** Building 4query.interactive ***"
	@@cd interactive; make PREFIX=${PREFIX} DIST_DIR=${DIST_DIR}/interactive WEB="../js" all
	@@echo
	
	@@echo "*** Building 4query.canvas ***"
	@@cd canvas; make PREFIX=${PREFIX} DIST_DIR=${DIST_DIR}/${JS_DIRNAME} all
	@@echo

clean:
	@@echo "Removing Distribution directory:" ${DIST_DIR}
	@@rm -rf ${DIST_DIR}
	@@cd core; make PREFIX=${PREFIX} DIST_DIR=${DIST_DIR}/${JS_DIRNAME} clean

checkout:
	@@if [ -d core/ ]; then \
		echo "You already have 4query (core)..."; \
	else \
		echo "Checking out 4query (core)"; \
		git clone ${REPO_CORE} core/; \
	fi
	
	@@if [ -d interactive/ ]; then \
		echo "You already have 4query.interactive..."; \
	else \
		echo "Checking out 4query.interactive"; \
		git clone ${REPO_INTERACTIVE} interactive/; \
	fi
	
	@@if [ -d canvas/ ]; then \
		echo "You already have 4query.canvas..."; \
	else \
		echo "Checking out 4query.canvas"; \
		git clone ${REPO_CANVAS} canvas/; \
	fi

pullall:
	cd core/; git pull origin master
	cd core/; git pull origin vendor
	cd interactive/; git pull origin master
	cd canvas/; git pull origin master

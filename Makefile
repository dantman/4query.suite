PREFIX = ${PWD}
DIST_DIR = ${PWD}/dist
JS_DIRNAME = js

checkenv:
	@@echo -n "core/        "; if [ ! -d core/        ]; then echo "not found\nFAIL!"; exit; else echo "found"; fi
	@@echo -n "interactive/ "; if [ ! -d interactive/ ]; then echo "not found\nFAIL!"; exit; else echo "found"; fi
	@@echo -n "canvas/      "; if [ ! -d canvas/      ]; then echo "not found\nFAIL!"; exit; else echo "found"; fi
	@@echo "OK!\n"

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
	@@if [ -d core/ ]; then echo "You already have 4query (core)..."; else echo "Checking out 4query (core)"; fi
	

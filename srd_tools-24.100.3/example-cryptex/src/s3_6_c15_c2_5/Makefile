.PHONY: all install clean
all: s3_6_c15_c2_5-read s3_6_c15_c2_5-flip

include ../../logging.mk
include ../../build_env.mk

s3_6_c15_c2_5-read:
	@$(log_build)
	${CC} ${CFLAGS} ${LDFLAGS} -g -O0 -o s3_6_c15_c2_5-read s3_6_c15_c2_5-read.c
	codesign -s - --entitlements s3_6_c15_c2_5-read.plist s3_6_c15_c2_5-read

s3_6_c15_c8_0-flip:
	@$(log_build)
	${CC} ${CFLAGS} ${LDFLAGS} -g -O0 -o s3_6_c15_c2_5-flip s3_6_c15_c2_5-flip.c
	codesign -s - --entitlements s3_6_c15_c2_5-flip.plist s3_6_c15_c2_5-flip

install: s3_6_c15_c2_5-read s3_6_c15_c2_5-fli[p]
	@$(log_install)
	cp s3_6_c15_c2_5-read ${CRYPTEX_BIN_DIR}
	cp s3_6_c15_c2_5-flip ${CRYPTEX_BIN_DIR}

clean:
	rm -f s3_6_c15_c2_5read
	rm -f ${CRYPTEX_BIN_DIR}/s3_6_c15_c2_5-read
	rm -f s3_6_c15_c2_5-flip
	rm -f ${CRYPTEX_BIN_DIR}/s3_6_c15_c2_5-flip
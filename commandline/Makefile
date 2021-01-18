# Makefile initially writen for Little-Wire by Omer Kilic <omerkilic@gmail.com>
# Later on modified by ihsan Kehribar <ihsan@kehribar.me> for Micronucleus bootloader application.

CC=gcc

ifeq ($(shell uname), Linux)
	USBFLAGS=$(shell libusb-config --cflags)
	USBLIBS=$(shell libusb-config --libs)
	EXE_SUFFIX =
	OSFLAG = -D LINUX
else ifeq ($(shell uname), Darwin)
	USBFLAGS=$(shell PKG_CONFIG_PATH=$(brew cellar libusb)/lib/pkgconfig pkg-config --cflags libusb-1.0 || libusb-config --cflags || libusb-legacy-config --cflags)
	USBLIBS=$(shell PKG_CONFIG_PATH=$(brew cellar libusb)/lib/pkgconfig pkg-config --libs libusb-1.0 || libusb-config --libs || libusb-legacy-config --libs)
	EXE_SUFFIX =
	OSFLAG = -D MAC_OS
	# Uncomment these to create a static binary:
	# USBLIBS = /opt/local/lib/libusb-legacy/libusb-legacy.a
	# USBLIBS += -mmacosx-version-min=10.5
	# USBLIBS += -framework CoreFoundation
	# USBLIBS += -framework IOKit
	# Uncomment these to create a dual architecture binary:
	# OSFLAG += -arch x86_64 -arch i386
else ifeq ($(shell uname), OpenBSD)
	USBFLAGS=$(shell libusb-config --cflags || libusb-legacy-config --cflags)
	USBLIBS=$(shell libusb-config --libs || libusb-legacy-config --libs)
	EXE_SUFFIX =
	OSFLAG = -D OPENBSD
else ifeq ($(shell uname), FreeBSD)
	USBFLAGS=
	USBLIBS= -lusb
	EXE_SUFFIX =
	OSFLAG = -D OPENBSD
else
	USBFLAGS =
	USBLIBS = -lusb
	EXE_SUFFIX = .exe
	OSFLAG = -D WIN
endif

LIBS    = $(USBLIBS)
INCLUDE = library 
CFLAGS  = $(USBFLAGS) -I$(INCLUDE) -O -g $(OSFLAG)

LWLIBS = micronucleus_lib littleWire_util
EXAMPLES = micronucleus

.PHONY:	clean library

all: library launcher$(EXE_SUFFIX) $(EXAMPLES)
	rm -f *.o

library: $(LWLIBS)

$(LWLIBS):
	@echo Building library: $@...
	$(CC) $(CFLAGS) -c library/$@.c

$(EXAMPLES): $(addsuffix .o, $(LWLIBS))
	@echo Building command line tool: $@...
	$(CC) $(CFLAGS) -o $@$(EXE_SUFFIX) $@.c $^ $(LIBS)

launcher$(EXE_SUFFIX): avr-dummy/avrdude-dummy.cpp
	$(CXX) -o $@ $^

clean:
	rm -f $(EXAMPLES)$(EXE_SUFFIX) *.o *.exe

install: all
	cp micronucleus /usr/local/bin

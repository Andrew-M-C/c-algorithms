
# gcc compiler
MAKE = make
CC  = gcc
CPP = g++
LD  = ld
AR  = ar

# target
LIB_DIR = ./lib
TARGET_SO_FILE_NAME = libamcctool.so
TARGET_A_FILE_NAME = libamcctool.a
TARGET_SO = $(LIB_DIR)/$(TARGET_SO_FILE_NAME)
TARGET_A = $(LIB_DIR)/$(TARGET_A_FILE_NAME)

# flags
CFLAGS += -Wall -g -fPIC -lpthread -I./include -I./src -O2
CPPFLAGS += $(CFLAGS)
LDFLAGS += -lpthread -lm -lrt

# source files
C_SRCS = $(wildcard ./src/*.c)
CPP_SRCS = $(wildcard ./src/*.cpp)
ASM_SRCS = $(wildcard ./src/*.S)

C_OBJS = $(C_SRCS:.c=.c.o)
CPP_OBJS = $(CPP_SRCS:.cpp=.cpp.o)
ASM_OBJS = $(ASM_SRCS:.S=.S.o)

NULL ?=#
ifneq ($(strip $(CPP_OBJS)), $(NULL))
FINAL_CC = $(CPP)
else
FINAL_CC = $(CC)
CPPFLAGS = $(CFLAGS)
endif

export FINAL_CC
export NULL
export CPPFLAGS
export CFLAGS
export CC
export CPP
export LD

# default target
.PHONY:all
all: $(TARGET_SO) $(TARGET_A)
	@echo "	<< libamcctool made >>"

# install
.PHONY:install
install:
	@echo "<< libamcctool installion todo >>"

# uninstall
.PHONY:uninstall
uninstall:
	@echo "<< libamcctool uninstallion todo >>"

# libamcctool
$(TARGET_SO): $(LIB_DIR) $(C_OBJS) $(CPP_OBJS) $(ASM_OBJS)
#	@echo ".so deps = "$^
	$(FINAL_CC) -o $@ $(CPP_OBJS) $(CPPFLAGS) -shared

$(TARGET_A): $(LIB_DIR) $(C_OBJS) $(CPP_OBJS) $(ASM_OBJS)
#	@echo ".a deps = "$^
	$(AR) r $@ $(C_OBJS) $(CPP_OBJS) $(ASM_OBJS)

$(LIB_DIR):
	mkdir $(LIB_DIR)

# automatic compiler
-include $(C_OBJS:.o=.d)
-include $(CPP_OBJS:.o=.d)

%.cpp.o: %.cpp
	$(CPP) -c $(CPPFLAGS) $*.cpp -o $*.cpp.o
	@$(CPP) -MM $(CPPFLAGS) $*.cpp > $*.cpp.d
	@mv -f $*.cpp.d $*.cpp.d.tmp
	@sed -e 's|.*:|$*.cpp.o:|' < $*.cpp.d.tmp > $*.cpp.d
	@sed -e 's/.*://' -e 's/\\$$//' < $*.cpp.d.tmp | fmt -1 | sed -e 's/^ *//' -e 's/$$/:/' >> $*.cpp.d
	@rm -f $*.cpp.d.tmp

%.c.o: %.c
	$(CC) -c $(CFLAGS) $*.c -o $*.c.o
	@$(CC) -MM $(CFLAGS) $*.c > $*.c.d
	@mv -f $*.c.d $*.c.d.tmp
	@sed -e 's|.*:|$*.c.o:|' < $*.c.d.tmp > $*.c.d
	@sed -e 's/.*://' -e 's/\\$$//' < $*.c.d.tmp | fmt -1 | sed -e 's/^ *//' -e 's/$$/:/' >> $*.c.d
	@rm -f $*.c.d.tmp

%.S.o: %.S
	$(CC) -c $*.S $*.S.o

#$(PROG_NAME): $(C_OBJS) $(CPP_OBJS) $(ASM_OBJS)
#	@echo "$(LD) -r -o $@.o *.o"
#	@$(LD) -r -o $@.o $(C_OBJS) $(CPP_OBJS) $(ASM_OBJS)
#	$(FINAL_CC) $@.o $(STATIC_LIBS) -o $@ $(LDFLAGS)
#	chmod $(TARMODE) $@

.PHONY: clean
clean:
#	@rm -f $(C_OBJS) $(CPP_OBJS) $(PROG_NAME) clist.txt cpplist.txt *.d *.d.* *.o
	-@if [ -d $(LIBCO_DIR) ]; then\
		make clean -C $(LIBCO_DIR);\
	fi
	-@find -name '*.o' | xargs -I [] rm [] >> /dev/null
	-@find -name '*.d' | xargs -I [] rm [] >> /dev/null
#	-@find -name '*.so' | xargs -I [] rm [] >> /dev/null
	-@rm -f $(TARGET_SO) $(TARGET_A)
	@echo "	<< $(shell basename `pwd`) cleaned >>"

.PHONY: distclean
distclean: clean

.PHONY: test
test:
	@echo "test"

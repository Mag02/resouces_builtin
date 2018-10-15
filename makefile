


###############################################################################
###
###      (build)  make
###      (clean)  make clean
###
###############################################################################

### Project Name
TGTNAME		:= res_tst
TGTVERS		:= 00.00.01


### Tools
CC		:= gcc
OBJCOPY		:= objcopy


### Objects List
OBJECTS		:= $(patsubst %.txt,%.o,$(wildcard *.txt)) \
		   $(patsubst %.c,%.o,$(wildcard *.c))


### Compilation Flags
CFLAGS		:= -c -Os -std=c99 -fstack-protector-all -Wall -Wextra -Werror


### Objects manipulations Flags
OBJCPYFLAGS	:= --input binary --output elf64-x86-64 --binary-architecture i386


#############
### Rules ###
#############
.PHONY: all clean

### Build all project
all: build

### Clean
clean:
	@echo "Cleaning $(TGTNAME)-v$(TGTVERS) ..."
	@rm -f *.o
	@rm -f $(TGTNAME)

### Resource Compilation 'sfd' (builtin)
%.o: %.txt
	@echo compiling $<...
	@$(OBJCOPY) $(OBJCPYFLAGS) $< $@

### C Compilation (platform dir)
%.o: %.c
	@echo compiling $<...
	@$(CC) $(CFLAGS) $< -o $@

### Application Generation
build: $(OBJECTS)
	@echo --
	@echo "Generating App [$(TGTNAME)] ..."
	@$(CC) $(OBJECTS) -o $(TGTNAME) -ldl -rdynamic

### EOF ###

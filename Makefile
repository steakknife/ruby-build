.PHONY: install

PREFIX      ?=/usr/local
BIN_SUBDIR  ?=bin
SHARE_SUBDIR?=share/ruby-build
BIN_PREFIX  ?=$(PREFIX)/$(BIN_SUBDIR)
SHARE_PREFIX?=$(PREFIX)/$(SHARE_SUBDIR)

DEST_DIRS          =$(BIN_PREFIX) $(SHARE_PREFIX)
BIN_SOURCE_FILES   =$(wildcard $(BIN_SUBDIR)/*)
SHARE_SOURCE_FILES =$(wildcard $(SHARE_SUBDIR)/*)
BIN_DEST_FILES     =$(patsubst $(BIN_SUBDIR)/%,$(BIN_PREFIX)/%,$(BIN_SOURCE_FILES))
SHARE_DEST_FILES   =$(patsubst $(SHARE_SUBDIR)/%,$(SHARE_PREFIX)/%,$(SHARE_SOURCE_FILES))

usage:	
	echo "run either 'make install' or 'make uninstall'"

clean:

install: $(DEST_DIRS) $(SHARE_DEST_FILES) $(BIN_DEST_FILES)

$(DEST_DIRS):
	install -d "$@"

$(BIN_PREFIX)/%: $(BIN_SUBDIR)/%
	install -m755 "$<" "$@"

$(SHARE_PREFIX)/%: $(SHARE_SUBDIR)/%
	install -m644 "$<" "$@"

uninstall: 
	rm -rf "$(SHARE_PREFIX)"
	rm -rf $(addsuffix ",$(addprefix ",$(BIN_DEST_FILES)))

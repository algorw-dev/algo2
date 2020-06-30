# Makefile para trabajar con pip-tools.
#
# `make sync` sincroniza requirements.in con requirements.txt,
# creando el virtual environment si no existe.

VENV ?= venv

all: sync

sync: requirements.txt
	@echo pip-sync $^
	@$(VENV)/bin/pip-sync $^

%.txt: %.in $(VENV)
	@echo pip-compile $<
	@env CUSTOM_COMPILE_COMMAND="make $@" $(VENV)/bin/pip-compile $<

$(VENV):
	[ -d $(VENV) ] || {      \
	    virtualenv $(VENV);  \
	    $(VENV)/bin/pip install --upgrade pip;       \
	    $(VENV)/bin/python -m pip install pip-tools; \
	}

.PHONY: all sync

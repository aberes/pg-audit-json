#
# Extension installer
#
# Usage:
#   > make && make install
#
# To run tests:
#	  > make installcheck
#
# Copied from:
# http://manager.pgxn.org/howto
#

EXTENSION    = $(shell grep -m 1 '"name":' META.json | \
								sed -e 's/[[:space:]]*"name":[[:space:]]*"\([^"]*\)",/\1/')
EXTVERSION   = $(shell grep -m 1 '"version":' META.json | \
								sed -e 's/[[:space:]]*"version":[[:space:]]*"\([^"]*\)",\{0,1\}/\1/')

DATA         = $(wildcard sql/*--*.sql)
EXTRA_CLEAN  = sql/$(EXTENSION)--$(EXTVERSION).sql
TESTS        = $(wildcard test/sql/*.sql)
REGRESS      = $(patsubst test/sql/%.sql,%,$(TESTS))
REGRESS_OPTS = --inputdir=test
PG_CONFIG    = pg_config

PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)

all: sql/$(EXTENSION)--$(EXTVERSION).sql

sql/$(EXTENSION)--$(EXTVERSION).sql: sql/$(EXTENSION).sql
	cp $< $@


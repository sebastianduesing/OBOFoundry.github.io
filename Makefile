ONTS := $(wildcard ontology/*md)

all: _config.yml

test: validate all

t:
	echo $(ONTS)

_config.yml: _config_header.yml $(ONTS)
	./util/extract-metadata.py concat -i $< $(ONTS) -o $@.tmp && mv $@.tmp $@

registry/ontologies.yml: $(ONTS)
	./util/extract-metadata.py concat -o $@.tmp $^  && mv $@.tmp $@

# TODO
registry/ontologies.jsonld: registry/ontologies.yml
	./util/yaml2json.py $< > $@.tmp && mv $@.tmp $@

# TODO
registry/ontologies.ttl: registry/ontologies.jsonld
	riot $< > $@.tmp && mv $@.tmp $@


validate: $(ONTS)
	./util/extract-metadata.py validate $^


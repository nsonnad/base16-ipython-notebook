all: ./output

base16-builder:
	git submodule init
	git submodule update

tmp/schemes: base16-builder
	mkdir -p $(dir $@)
	cp -r $</schemes $@

tmp/base16: base16-builder
	mkdir -p $(dir $@)
	cp $</base16 $@

tmp/templates: ./templates
	mkdir -p $(dir $@)
	cp -r $< $@

tmp/output: tmp/base16 tmp/schemes tmp/templates
	mkdir -p $@
	cd tmp && ./base16

./output: tmp/output
	mkdir -p $@
	cp $</templates/*.css $@
	rm -rf ./tmp

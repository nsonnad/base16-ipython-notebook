OBJECTS = \
	./ipython-2/output \
	./ipython-3/output

all: ${OBJECTS}

base16-builder:
	git submodule init
	git submodule update

tmp/schemes: base16-builder
	mkdir -p $(dir $@)
	cp -r $</schemes $@

tmp/base16: base16-builder
	mkdir -p $(dir $@)
	cp $</base16 $@

./ipython-2/output: tmp/base16 tmp/schemes
	mkdir -p $@
	cp -r ./ipython-2/templates tmp/templates
	cd tmp && mkdir -p output && ./base16
	cp ./tmp/output/templates/*.css $@

./ipython-3/output: tmp/base16 tmp/schemes
	mkdir -p $@
	cp -r ./ipython-3/templates tmp/templates
	cd tmp && mkdir -p output && ./base16
	cp ./tmp/output/templates/*.css $@
	rm -rf ./tmp

clean:
	rm -rf ./tmp ./ipython-2/output ./ipython-3/output

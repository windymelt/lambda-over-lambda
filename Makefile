.PHONY: default distclean build

OUT = out.zip
LIBCRYPTO = libcrypto.so.1.0.2k
LIBSSL = libssl.so.1.0.2k

default: $(OUT)

distclean:
	-rm $(OUT) bootstrap $(LIBCRYPTO) $(LIBSSL)

$(LIBCRYPTO):
	docker-compose run --rm cl cp /usr/lib64/$@ /app/

$(LIBSSL):
	docker-compose run --rm cl cp /usr/lib64/$@ /app/

$(OUT): bootstrap $(LIBCRYPTO) $(LIBSSL)
	-rm $@
	zip --symlinks $@ $^

bootstrap: bootstrap.ros
	docker-compose run --rm cl ros build $<

build: temporary.ros $(LIBCRYPTO) $(LIBSSL)
	docker-compose run --rm cl ros build temporary.ros
	-rm temporary.ros
	mv temporary bootstrap
	zip out.zip --symlinks bootstrap $(LIBCRYPTO) $(LIBSSL)

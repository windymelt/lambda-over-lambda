.PHONY: default distclean build

OUT = out.zip
LIBCRYPTO = libcrypto.so.1.0.2k
LIBCRYPTO_2 = libcrypto.so.10
LIBSSL = libssl.so.1.0.2k
LIBSSL_2 = libssl.so.10

default: $(OUT)

distclean:
	-rm $(OUT) bootstrap $(LIBCRYPTO) $(LIBCRYPTO_2) $(LIBSSL) $(LIBSSL_2)

$(LIBCRYPTO):
	docker-compose run --rm cl cp /usr/lib64/$@ /app/

$(LIBCRYPTO_2):
	docker-compose run --rm cl ln -s /app/$(LIBCRYPTO) /app/$(LIBCRYPTO_2)

$(LIBSSL):
	docker-compose run --rm cl cp /usr/lib64/$@ /app/

$(LIBSSL_2):
	docker-compose run --rm cl ln -s /app/$(LIBSSL) /app/$(LIBSSL_2)

$(OUT): bootstrap $(LIBCRYPTO) $(LIBCRYPTO_2) $(LIBSSL) $(LIBSSL_2)
	-rm $@
	zip --symlinks $@ $^

bootstrap: bootstrap.ros
	docker-compose run --rm cl ros build $<

build: temporary.ros $(LIBCRYPTO) $(LIBCRYPTO_2) $(LIBSSL) $(LIBSSL_2)
	-rm temporary.ros
	docker-compose run cl ros build temporary.ros --bundle-shared-object
	-rm temporary.ros
	mv temporary bootstrap
	zip out.zip --symlinks bootstrap $(LIBCRYPTO) $(LIBCRYPTO_2) $(LIBSSL) $(LIBSSL_2)

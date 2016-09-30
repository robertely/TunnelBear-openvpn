pkg_name    = "tunnelbear-openvpn"
version     = "1.0.0"
description = "Openvpn configs for TunnelBear"
output_dir  = "packages/"

all: clean build deb rpm tar

build:
	mkdir -p buildroot/etc/openvpn
	cp openvpn/* buildroot/etc/openvpn/

deb:
	@echo "----------------------------------------------------------------------"
	@echo "- Creating DEB"
	@echo "----------------------------------------------------------------------"
	mkdir -p $(output_dir)
	fpm \
	-s dir \
	-t deb \
	-a all \
	-C buildroot/ \
	-p $(output_dir) \
	--name $(pkg_name) \
	--depends openvpn \
	--version $(version) \
	--description $(description) \
	--deb-no-default-config-files

rpm:
	@echo "----------------------------------------------------------------------"
	@echo "- Creating RPM"
	@echo "----------------------------------------------------------------------"
	mkdir -p $(output_dir)
	fpm \
	-s dir \
	-t rpm \
	-a all \
	-C buildroot/ \
	-p $(output_dir) \
	--name $(pkg_name) \
	--depends openvpn \
	--version $(version) \
	--description $(description)

tar:
	@echo "----------------------------------------------------------------------"
	@echo "- Creating tar ball"
	@echo "----------------------------------------------------------------------"
	tar zcvf $(pkg_name)-$(version).tar.gz buildroot
	mv $(pkg_name)-$(version).tar.gz $(output_dir)

clean:
	@echo "----------------------------------------------------------------------"
	@echo "- Cleaning..."
	@echo "----------------------------------------------------------------------"
	@test -d buildroot/ && rm -r buildroot/ || echo "> buildroot/ clean"
	@test -d packages/ && rm -r packages/ || echo "> packages/ clean"

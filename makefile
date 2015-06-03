include $(PQ_FACTORY)/factory.mk

pq_part_name := libxml2-2.9.2
pq_part_file := $(pq_part_name).tar.gz

pq_libxml2_configuration_flags += --prefix=$(part_dir)

build-stamp: stage-stamp
	$(MAKE) -C $(pq_part_name) mkinstalldirs=$(part_dir)
	$(MAKE) -C $(pq_part_name) mkinstalldirs=$(part_dir) DESTDIR=$(stage_dir) install
	touch $@

stage-stamp: configure-stamp

configure-stamp: patch-stamp
	echo "PATH=[$(PATH)]"
	echo "LD_LIBRARY_PATH=[$(LD_LIBRARY_PATH)]"
	echo "PKG_CONFIG_PATH=[$(PKG_CONFIG_PATH)]"
	cd $(pq_part_name) && ./configure $(pq_libxml2_configuration_flags)
	touch $@

patch-stamp: unpack-stamp
	touch $@

unpack-stamp: $(pq_part_file)
	tar xf $(source_dir)/$(pq_part_file)
	touch $@

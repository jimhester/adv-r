RMD=$(wildcard *\.rmd)
NEW=$(patsubst %.rmd,no_pandoc/%.rmd, $(RMD))


CHOOSER=c('boot', 'code')
BOOT_STYLE=NULL
CODE_STYLE=NULL

advanced-r-programming.html: $(NEW)

%.html: %.rmd
	Rscript -e "\
    setwd('$(dir $<)');\
    require('knitrBootstrap');\
    knit_bootstrap('$(notdir $<)',\
      chooser=$(CHOOSER),\
      boot_style=$(BOOT_STYLE),\
      code_style=$(CODE_STYLE),\
      show_code=TRUE,\
      show_output=FALSE\
    )"

no_pandoc/%.rmd: %.rmd
	perl -e '$$contents = do { local $$/; <> }; $$contents =~ s/^---\s.*^---\s//ms; print $$contents' $< > $@

clean:
	rm no_pandoc/*rmd advanced-r-programming.html

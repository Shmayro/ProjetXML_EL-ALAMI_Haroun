 
all: reset dtd xsd javap web xq tidy open

web: masterf.xml xsl/master.xsl
	@echo "\nCreation du contenu du dossier www/"
	java -jar saxon9pe.jar -s:"masterf.xml" -xsl:"xsl/master.xsl"

dtd: masterf.xml dtd/master.dtd
	@echo "\nValidation du masterf.xml avec la DTD"
	xmllint --noout --valid  masterf.xml

xsd: masterf.xml xsd/master.xsd
	@echo "\nValidation du masterf.xml avec la schema"
	xmllint --noout --schema  xsd/master.xsd masterf.xml

xq:
	@echo "\nCréation du resultat de la requête XQuery"
	java -cp saxon9pe.jar net.sf.saxon.Query !indent=yes xq.txt > www/xq.html

tidy:
	@echo "\nValidation des fichiers www./*.html"
	-tidy --show-warnings false -im -asxhtml -indent www/*.html

javap:
	@echo "\nCréation du fichier DOM contenant l'ensemble des UEs"
	javac java/MakeDom.java
	java -classpath java MakeDom > listues.xml

reset:
	@echo "\nReset Project"
	rm -rf www/*
	rm -rf www
	rm -rf listues.xml
	rm -rf java/*.class

open:
	@echo "\nAfficher le site"
	gnome-open www/index.html
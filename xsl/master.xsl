<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">


    <xsl:template name="site">
        <xsl:param name="class"/>
        <xsl:param name="site"/>
        <xsl:param name="title"/>
        <xsl:param name="target"/>
        <a class="{$class}" href="{$site}" target="{$target}">
            <xsl:value-of select="$title"/>
        </a>
    </xsl:template>

    <xsl:template name="header">
        <xsl:param name="title"/>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"/>
            <meta name="viewport" content="width=device-width, initial-scale=1"/>
            <title>
                <xsl:value-of select="$title"/>
            </title>

            <link href="../css/bootstrap.css" rel="stylesheet" type="text/css"/>
            <link href="../css/bootstrap-theme.css" rel="stylesheet" type="text/css"/>
        </head>
    </xsl:template>

    <xsl:template name="menu">
        <div class="col-md-3">
            <div class="list-group">
                <a class="list-group-item list-group-item-success" href="index.html">Parcours
                    (Acceuil)</a>
                <xsl:call-template name="list-parcours"/>
                <a class="list-group-item list-group-item-info" href="unites.html">Les unités</a>
                <a class="list-group-item list-group-item-warning" href="intervenants.html">Les
                    intervenants</a>
                <a class="list-group-item list-group-item-danger" href="xq.html">Requête XQuery</a>
                <a class="list-group-item " target="_blank" href="../listues.xml">Dom généré avec
                    XQuery</a>
            </div>
            <div style="text-align: center;">
                <img src="../img/logo.png" width="150px" alt=""/>
                <br/>
                <b>(<a target="_blank" href="http://haroun.tk">Haroun El Alami</a> © 2016)</b>
                <br/>
                <a class="btn btn-primary" href="../documentation.html" role="button"
                    >Documentation</a>
            </div>
            <hr/>
        </div>
    </xsl:template>
    <xsl:template name="list-parcours">

        <xsl:for-each select="//parcours">
            <xsl:sort select="nom and finalite"/>
            <xsl:call-template name="site">
                <xsl:with-param name="site">parc-<xsl:value-of select="abrev"
                    />.html</xsl:with-param>
                <xsl:with-param name="title">
                    <xsl:value-of select="nom"/>
                </xsl:with-param>
                <xsl:with-param name="class">list-group-item</xsl:with-param>
            </xsl:call-template>
        </xsl:for-each>

    </xsl:template>

    <xsl:template name="head">
        <xsl:param name="pageTitle"/>
        <xsl:param name="subPageTitle"/>
        <div class="row">
            <div class="col-md-12">
                <div class="page-header">
                    <h1 class="text-center">
                        <small>
                            <xsl:value-of select="$subPageTitle"/>
                        </small>
                        <br/>
                        <xsl:value-of select="$pageTitle"/>
                    </h1>
                </div>
            </div>
        </div>
    </xsl:template>

    <xsl:template name="intervenant">
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title">Presentation</h3>
            </div>
            <div class="panel-body">
                <div>
                    <b>Adresse électronique :</b>
                    <xsl:call-template name="site">
                        <xsl:with-param name="site">mailto:<xsl:value-of select="email"
                            /></xsl:with-param>
                        <xsl:with-param name="title" select="email"/>
                    </xsl:call-template>
                </div>
                <div>
                    <b>Site Web :</b>
                    <xsl:call-template name="site">
                        <xsl:with-param name="site" select="website"/>
                        <xsl:with-param name="title" select="website"/>
                        <xsl:with-param name="target">_blank</xsl:with-param>
                    </xsl:call-template>
                </div>
            </div>
        </div>
        <xsl:if test="//parcours[ref-responsable/@ref = current()/@id]">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">Responsablilité</h3>
                </div>
                <div class="panel-body">
                    <ul>
                        <xsl:for-each select="//parcours[ref-responsable/@ref = current()/@id]">
                            <li>
                                <xsl:call-template name="site">
                                    <xsl:with-param name="site">parc-<xsl:value-of select="abrev"
                                        />.html</xsl:with-param>
                                    <xsl:with-param name="title" select="nom"/>
                                </xsl:call-template>
                            </li>
                        </xsl:for-each>
                    </ul>
                </div>
            </div>
        </xsl:if>
        <xsl:if test="//ue[ref-intervenant/@ref = current()/@id]">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">UEs enseignées</h3>
                </div>
                <div class="panel-body">
                    <ul>
                        <xsl:for-each select="//ue[ref-intervenant/@ref = current()/@id]">
                            <li>
                                <xsl:call-template name="site">
                                    <xsl:with-param name="site">ue-<xsl:value-of select="@id"
                                        />.html</xsl:with-param>
                                    <xsl:with-param name="title"><xsl:value-of select="@id"
                                            />-<xsl:value-of select="nom"/></xsl:with-param>
                                </xsl:call-template>
                            </li>
                        </xsl:for-each>
                    </ul>
                </div>
            </div>
        </xsl:if>
    </xsl:template>

    <xsl:template name="parcours">
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title">Présentation et objectifs</h3>
            </div>
            <div class="panel-body">
                <div>
                    <b>Responsables :</b>
                    <ul>
                        <xsl:for-each select="//intervenant[@id = current()/ref-responsable/@ref]">
                            <li>
                                <xsl:call-template name="site">
                                    <xsl:with-param name="site">intervenant-<xsl:value-of
                                            select="@id"/>.html</xsl:with-param>
                                    <xsl:with-param name="title">
                                        <xsl:value-of select="nom"/>
                                    </xsl:with-param>
                                </xsl:call-template>
                            </li>
                        </xsl:for-each>

                    </ul>
                </div>
                <div>
                    <b>Lieu d'enseignement :</b>
                    <ul>
                        <xsl:for-each select="lieu">
                            <li>Campus de <xsl:value-of select="text()"/>.</li>
                        </xsl:for-each>

                    </ul>
                </div>
                <div>
                    <xsl:value-of select="description"/>
                </div>
            </div>
        </div>

        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title">Programme des enseignements</h3>
            </div>
            <div class="panel-body">
                <xsl:for-each select="semestre">
                    <div>
                        <b>Programme du semestre <xsl:value-of select="nom"/>:</b>
                        <ul>

                            <xsl:for-each select="bloc">

                                <xsl:if test="role">
                                    <li>Unités <xsl:value-of select="role"/></li>
                                </xsl:if>
                                <xsl:if test="nbr_credit">
                                    <li><xsl:value-of select="nbr_credit"/> crédits à choisir</li>
                                </xsl:if>
                                <ul>
                                    <xsl:for-each select="ref-ue">
                                        <li>
                                            <xsl:call-template name="site">
                                                <xsl:with-param name="site">ue-<xsl:value-of
                                                  select="@ref"/>.html</xsl:with-param>
                                                <xsl:with-param name="title">
                                                  <xsl:value-of
                                                  select="//ue[@id = current()/@ref]/nom"/>
                                                  (<xsl:value-of
                                                  select="//ue[@id = current()/@ref]/credits"/>
                                                  crédits) </xsl:with-param>
                                            </xsl:call-template>
                                        </li>
                                    </xsl:for-each>

                                </ul>

                            </xsl:for-each>
                        </ul>
                    </div>
                </xsl:for-each>
            </div>
        </div>
        <xsl:if test="lsdebouches/debouche">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">Débouchés</h3>
                </div>
                <div class="panel-body">
                    <ul>
                        <xsl:for-each select="lsdebouches/debouche">
                            <li>
                                <xsl:value-of select="text()"/>
                            </li>
                        </xsl:for-each>
                    </ul>
                </div>
            </div>
        </xsl:if>
    </xsl:template>

    <xsl:template name="ue">
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title">Description</h3>
            </div>
            <div class="panel-body">
                <div class="panel panel-primary" style="width:45%;float:right">
                    <div class="panel-body">
                        <div>
                            <b>Credits : </b>
                            <xsl:value-of select="credits"/>
                        </div>
                        <xsl:if test="plan">
                            <div>
                                <b><xsl:if test="plan/cours">Cours<xsl:if test="plan/td"
                                        >/</xsl:if></xsl:if><xsl:if test="plan/td">TD<xsl:if
                                            test="plan/tp">/</xsl:if></xsl:if><xsl:if test="plan/tp"
                                        >TP</xsl:if> : </b>
                                <xsl:if test="plan/cours"><xsl:value-of select="plan/cours"
                                        />h<xsl:if test="plan/td">/</xsl:if></xsl:if>
                                <xsl:if test="plan/td"><xsl:value-of select="plan/td"/>h<xsl:if
                                        test="plan/tp">/</xsl:if></xsl:if>
                                <xsl:if test="plan/tp"><xsl:value-of select="plan/tp"/>h</xsl:if>
                            </div>
                        </xsl:if>
                        <xsl:if test="lieu">
                            <div>
                                <b>Lieu d'enseignement :</b>
                                <ul>
                                    <xsl:for-each select="lieu">
                                        <li>Campus de <xsl:value-of select="text()"/>.</li>
                                    </xsl:for-each>

                                </ul>
                            </div>
                        </xsl:if>
                        <xsl:if test="//intervenant[@id = current()/ref-intervenant/@ref]">
                            <div>
                                <b>Intervenants :</b>
                                <ul>
                                    <xsl:for-each
                                        select="//intervenant[@id = current()/ref-intervenant/@ref]">
                                        <li>
                                            <xsl:call-template name="site">
                                                <xsl:with-param name="site"
                                                  >intervenant-<xsl:value-of select="@id"
                                                  />.html</xsl:with-param>
                                                <xsl:with-param name="title">
                                                  <xsl:value-of select="nom"/>
                                                </xsl:with-param>
                                            </xsl:call-template>
                                        </li>
                                    </xsl:for-each>

                                </ul>
                            </div>
                        </xsl:if>
                    </div>
                </div>
                <div>
                    <xsl:value-of select="description"/>
                </div>
            </div>
        </div>

        <xsl:if test="//parcours[semestre/bloc/ref-ue/@ref = current()/@id]">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">Apparaît dans les parcours</h3>
                </div>
                <div class="panel-body">
                    <ul>
                        <xsl:for-each select="//parcours[semestre/bloc/ref-ue/@ref = current()/@id]">
                            <li>
                                <xsl:call-template name="site">
                                    <xsl:with-param name="site">parc-<xsl:value-of select="abrev"
                                        />.html</xsl:with-param>
                                    <xsl:with-param name="title" select="nom"/>
                                </xsl:call-template>
                            </li>
                        </xsl:for-each>
                    </ul>
                </div>
            </div>
        </xsl:if>
    </xsl:template>

    <xsl:template name="intervenants">
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title">Les intervenants du Master Informatique</h3>
            </div>
            <div class="panel-body">
                <table class="table table-bordered table-striped">
                    <thead>
                        <tr>
                            <th>Nom</th>
                            <th>Courriel</th>
                            <th>Web</th>
                        </tr>
                    </thead>
                    <tbody>
                        <xsl:for-each select="//intervenant">
                            <xsl:sort select="nom"/>
                            <tr>
                                <td>
                                    <xsl:call-template name="site">
                                        <xsl:with-param name="site">intervenant-<xsl:value-of
                                                select="@id"/>.html</xsl:with-param>
                                        <xsl:with-param name="title" select="nom"/>
                                    </xsl:call-template>
                                </td>
                                <td>
                                    <xsl:call-template name="site">
                                        <xsl:with-param name="site">mailto:<xsl:value-of
                                                select="email"/></xsl:with-param>
                                        <xsl:with-param name="title">Contacter</xsl:with-param>
                                    </xsl:call-template>
                                </td>
                                <td>
                                    <xsl:call-template name="site">
                                        <xsl:with-param name="site" select="website"/>
                                        <xsl:with-param name="title">Visiter</xsl:with-param>
                                        <xsl:with-param name="target">_blank</xsl:with-param>
                                    </xsl:call-template>
                                </td>
                            </tr>
                        </xsl:for-each>
                    </tbody>
                </table>
            </div>
        </div>
    </xsl:template>

    <xsl:template name="unites">
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title">Les unités triées par code</h3>
            </div>
            <div class="panel-body">
                <xsl:for-each select="//ue">
                    <xsl:sort select="@id"/>
                    <xsl:call-template name="site">
                        <xsl:with-param name="site">ue-<xsl:value-of select="@id"
                            />.html</xsl:with-param>
                        <xsl:with-param name="title" select="@id"/>
                    </xsl:call-template>
                    <xsl:if test="position() != last()">, </xsl:if>
                </xsl:for-each>

            </div>
        </div>
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title">Les unités de Master</h3>
            </div>
            <div class="panel-body">
                <table class="table table-bordered table-striped">
                    <thead>
                        <tr>
                            <th>Code</th>
                            <th>Nom</th>
                        </tr>
                    </thead>
                    <tbody>
                        <xsl:for-each select="//ue">
                            <xsl:sort select="nom"/>
                            <tr>
                                <td>
                                    <xsl:value-of select="@id"/>
                                </td>
                                <td>
                                    <xsl:call-template name="site">
                                        <xsl:with-param name="site">ue-<xsl:value-of select="@id"
                                            />.html</xsl:with-param>
                                        <xsl:with-param name="title" select="nom"/>
                                    </xsl:call-template>
                                </td>
                            </tr>
                        </xsl:for-each>
                    </tbody>
                </table>
            </div>
        </div>
    </xsl:template>

    <xsl:template name="Page">
        <xsl:param name="page"/>
        <xsl:param name="tilte"/>
        <xsl:param name="pageTitle"/>
        <xsl:param name="subPageTitle"/>
        <html>
            <xsl:call-template name="header">
                <xsl:with-param name="title">
                    <xsl:value-of select="$tilte"/>
                </xsl:with-param>
            </xsl:call-template>
            <body>
                <div class="section">
                    <div class="container">
                        <xsl:call-template name="head">
                            <xsl:with-param name="pageTitle" select="$pageTitle"/>
                            <xsl:with-param name="subPageTitle" select="$subPageTitle"/>
                        </xsl:call-template>
                        <div class="row">
                            <xsl:call-template name="menu"/>
                            <div class="col-md-9">
                                <xsl:choose>
                                    <xsl:when test="$page = 'parcours'">
                                        <xsl:call-template name="parcours"/>
                                    </xsl:when>
                                    <xsl:when test="$page = 'intervenant'">
                                        <xsl:call-template name="intervenant"/>
                                    </xsl:when>
                                    <xsl:when test="$page = 'intervenants'">
                                        <xsl:call-template name="intervenants"/>
                                    </xsl:when>
                                    <xsl:when test="$page = 'ue'">
                                        <xsl:call-template name="ue"/>
                                    </xsl:when>
                                    <xsl:when test="$page = 'unites'">
                                        <xsl:call-template name="unites"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:call-template name="index"/>
                                    </xsl:otherwise>
                                </xsl:choose>

                            </div>
                        </div>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>

    <xsl:template name="index">
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title">Présentation du Master « Informatique » </h3>
            </div>
            <div class="panel-body">
                <p>Le master « informatique » a pour vocation la formation de professionnels de
                    l'informatique au niveau bac+5. L'objectif est d'offrir aux étudiants une large
                    palette de compétences et de savoirs afin de rendre accessible des emplois de
                    haut niveau dans le monde de la recherche, dans celui de l'entreprise ou dans
                    d'autres organisations. Notre ambition est de former des étudiants dont les
                    compétences sont tout à fait comparables à celles acquises dans les meilleurs
                    écoles d'ingénieurs. </p>
                <p>Le Master informatique repose sur plus de 25 ans d'expérience d'enseignement
                    d'informatique sur l'Université d'Aix-Marseille (maîtrise, DEA et DESS en
                    informatique) et s'est structuré lors du passage au LMD.</p>
                <p>La master est enseigné à Marseille sur le <b>campus de Luminy</b> (site sud) et
                    sur le <b>campus de l'Étoile</b> (site nord) qui regroupe Château-Gombert et
                    Saint-Jérôme.</p>
                <p>Notre offre de formation au niveau Bac+5 est organisée autour de deux axes forts
                    : <ul>
                        <li>Le master est structuré sous la forme d'une <a href="parc-M1.html"
                                    ><b>première année commune (M1)</b></a> et dupliquée sur les
                            sites sud et nord, suivie d'une deuxième année de spécialisation
                            (M2).</li> <li>La <b>deuxième année</b> est composée de sept
                            spécialités. Deux à finalité recherche, et cinq à finalité
                            professionnelle. Certaines spécialités sont ensuite déclinées en
                            plusieurs parcours. Ces spécialités sont localisées à Luminy ou à
                            Saint-Jérôme en fonction des compétences locales.</li>
                    </ul>
                </p>
            </div>
        </div>
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title">Débouchés et effectifs</h3>
            </div>
            <div class="panel-body">
                <p>L'effectif du Tronc Commun (M1) est estimé à 150 étudiants. Une maîtrise
                    d'Informatique sera délivrée à l'issue de cette première année.</p>

                <p>Les spécialités à finalité professionnelle du Master débouchent sur des emplois
                    de niveau ingénieur et chef de projet en informatique. L'effectif prévu pour ces
                    spécialités est d'une centaine d'étudiants (15 à 20 par parcours).</p>

                <p>A l'issue des spécialités à finalité recherche, l'étudiant a le choix entre
                    préparer une thèse de doctorat, ce qui lui ouvre le chemin vers les organismes
                    publics d'enseignement supérieur et de recherche, et/ou occuper tout type de
                    poste impliquant un travail de recherche, dans un département de recherche et
                    développement par exemple, en France ou à l'étranger. L'effectif prévu pour ces
                    spécialités est de 50 places.</p>
            </div>
        </div>
    </xsl:template>

    <xsl:template match="/">

        <xsl:for-each select="//intervenant">
            <xsl:result-document href="www/intervenant-{@id}.html" method="xml"
                encoding="iso-8859-1" indent="yes"
                doctype-public="//W3C//DTD XHTML 1.0 Transitional//EN"
                doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
                xmlns="http://www.w3.org/1999/xhtml">
                <xsl:call-template name="Page">
                    <xsl:with-param name="page">intervenant</xsl:with-param>
                    <xsl:with-param name="tilte" select="nom"/>
                    <xsl:with-param name="pageTitle" select="nom"/>
                    <xsl:with-param name="subPageTitle">Fiche de</xsl:with-param>
                </xsl:call-template>
            </xsl:result-document>
        </xsl:for-each>

        <xsl:for-each select="//parcours">
            <xsl:result-document href="www/parc-{abrev}.html" method="xml" encoding="iso-8859-1"
                indent="yes" doctype-public="//W3C//DTD XHTML 1.0 Transitional//EN"
                doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
                xmlns="http://www.w3.org/1999/xhtml">
                <xsl:call-template name="Page">
                    <xsl:with-param name="page">parcours</xsl:with-param>
                    <xsl:with-param name="tilte"><xsl:value-of select="nom"/> (<xsl:value-of
                            select="abrev"/>)</xsl:with-param>
                    <xsl:with-param name="pageTitle"><xsl:value-of select="nom"/> (<xsl:value-of
                            select="abrev"/>)</xsl:with-param>
                    <xsl:with-param name="subPageTitle">
                        <xsl:if test="finalite[text() != 'Tronc commun']">Un parcours à finalité </xsl:if>
                        <xsl:value-of select="finalite"/>
                    </xsl:with-param>
                </xsl:call-template>
            </xsl:result-document>
        </xsl:for-each>

        <xsl:for-each select="//ue">
            <xsl:result-document href="www/ue-{@id}.html" method="xml" encoding="iso-8859-1"
                indent="yes" doctype-public="//W3C//DTD XHTML 1.0 Transitional//EN"
                doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
                xmlns="http://www.w3.org/1999/xhtml">
                <xsl:call-template name="Page">
                    <xsl:with-param name="page">ue</xsl:with-param>
                    <xsl:with-param name="tilte" select="nom"/>
                    <xsl:with-param name="pageTitle">« <xsl:value-of select="nom"/>
                        »</xsl:with-param>
                    <xsl:with-param name="subPageTitle">Unité d'enseignement <xsl:value-of
                            select="@id"/></xsl:with-param>
                </xsl:call-template>
            </xsl:result-document>
        </xsl:for-each>

        <xsl:result-document href="www/unites.html" method="xml" encoding="iso-8859-1" indent="yes"
            doctype-public="//W3C//DTD XHTML 1.0 Transitional//EN"
            doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
            xmlns="http://www.w3.org/1999/xhtml">
            <xsl:call-template name="Page">
                <xsl:with-param name="page">unites</xsl:with-param>
                <xsl:with-param name="tilte">Les unités d'enseignements</xsl:with-param>
                <xsl:with-param name="pageTitle">Les unités d'enseignements</xsl:with-param>
            </xsl:call-template>
        </xsl:result-document>


        <xsl:result-document href="www/intervenants.html" method="xml" encoding="iso-8859-1"
            indent="yes" doctype-public="//W3C//DTD XHTML 1.0 Transitional//EN"
            doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
            xmlns="http://www.w3.org/1999/xhtml">
            <xsl:call-template name="Page">
                <xsl:with-param name="page">intervenants</xsl:with-param>
                <xsl:with-param name="tilte">Les intervenants du Master
                    Informatique</xsl:with-param>
                <xsl:with-param name="pageTitle">Les intervenants du Master
                    Informatique</xsl:with-param>
            </xsl:call-template>
        </xsl:result-document>

        <xsl:result-document href="www/index.html" method="xml" encoding="iso-8859-1" indent="yes"
            doctype-public="//W3C//DTD XHTML 1.0 Transitional//EN"
            doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
            xmlns="http://www.w3.org/1999/xhtml">
            <xsl:call-template name="Page">
                <xsl:with-param name="page">index</xsl:with-param>
                <xsl:with-param name="tilte">Master Informatique de Marseille</xsl:with-param>
                <xsl:with-param name="pageTitle">Master Informatique de Marseille</xsl:with-param>
                <xsl:with-param name="subPageTitle"/>
            </xsl:call-template>
        </xsl:result-document>

    </xsl:template>
</xsl:stylesheet>

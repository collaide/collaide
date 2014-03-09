#Repértoire de la nouvelle version de www.collaide.com

La nouvelle version de collaide est développé grâce au framework Ruby on Rails. Actuellement, nous sommes deux personnes
à y traviller.
Cette nouvelle version a pour but d'utiliser les technologies web modernes (Ajax, responsive design, etc), de suivre
le modèle de programmation REST, d'avoir une base de donnée unifiée (gerée avec un ORM), avec une seule logique et d'être
multi-lingue.

Version test sur : http://vps42634.ovh.net/

##Recherche

Nous recherchons encore quelqu'un pour :
* la traduction français-anglais
* la traduction français-allemand
* la traduction français-italien
* le web-design
* le développement du front-end (bonne maîtrise de JQuery, d'AJAX, html et css. Connaissance de base en ruby et maîtrise de haml ou erb)
* le développement des modules membre ou file
* la communication du site (social marketing, réferencement, écriture de textes, etc)
* le web-designe
* le développement du front-end (bonne maîtrise de JQuery, d'AJAX, html et css. Connaissance )
* un développeur Ruby on Rails
* une personne responsable de la communication (social marketing, réferencement, écriture de textes, etc)

Une personne peut remplir plusieurs fonctions à la foi. Contactez-nous par e-mail à l'adresse facenord.sud at gmail.com
si vous êtes intéressés

##Languages et outils

Pour le versioning:
* git

Nous utilisons les languages suivant :
* Ruby
* Haml/ERB
* HTML/CSS/XSLT
* Javascript
* Saas

Les base de données sont en :
* postgresql
* mysql (indexation)


Nous utilisons comme outils :
* Ruby on Rails
* JQuery
* Ajax
* Foundation (html framework)

Liste des gems Ruby les plus importantes :
* devise
* ancestry
* cancan
* globalize3
* active-admin
* i18n
* i18n-routing

et beaucoup d'autre...

Pour les tests, nous utilisons:
* Rspec
* cucumber
* FactoryGirl
* guard

##Organisation

Nous avons séparé le travil en plusieurs modules indépendants l'un de l'autre. Ainsi, chacun peut travailler sur le ou les modules qui lui conviennent sans devoir comprendre l'ensemble du site.

###Modules

Nous avons séparé le site en plusieurs modules et nous leur avons donné un ordre d'importance. 
* Member -> Regroupe tout ce qui touche à l'utilisateur. C-à-d : gestion des groupes, des contacts, des horaires, des discussions, etc. Pas prioritaire. Peut être fait après la mise ne ligne
* CFile -> Gestion, stockage et partage de fichiers et de dossiers. Le partage peut se faire entre utilsateurs ou groupes. Idem, n'est pas requis avant la mise en ligne
* Document -> Gestion des documents. Affichage, recherche, upload/downlaod. Par documents, nous entendons documents scolaires. Des documents qui sont des travaux réalisé dans le cadre des études et accessibles par tous. Ce module est prioriatire et presque fini. Il doit encore être paufiné.
* Advertisement -> Annonces de différents types. Avant la mise en ligne, seulement la vente de livres sera faite. Module en cours de réalisation ~50%
* Gestion des utilisateurs par devise[https://github.com/plataformatec/devise], nécessite d'être configuré, amélioré et adapté à nos besoins. Notament, l'affichage/édition du profil. -> prioriatire
* Rédaction de différentes pages d'aide, de contact, etc.  -> prioriatire
* Création de la page d'accueil  -> prioriatire
* Notifications (notifiaction par message quand l'utilisateur est sur le site et envoi d'emails)  -> prioriatire

Les tâches marqués prioritaire, sont celle a effectués avant la mise en ligne.   


###Méthodes

Comme méthode de travail à l'intérieur d'un module, nous procédons de la sorte :
1. mise sur papier des besoins et des fonctionalités pour le module
2. design ORM de la base de donnée
3. configuration des routes
4. génération des modèles, vues, contrôlleurs et de leurs méthodes
5. ajout de librairies utiles.
6. écriture des testes nécessaires
7. travail sur le(s) modèles (validation, relations, etc)
8. travail sur les contrôleurs (requêtes et passer les résultats à la vue)
9. création des vues
10. amélioration de l'interface (à plusieurs, suivant les retours)



License Collaide
-------
Copyright (c) 2009-2014 All rights reserved.

- Fondateur : Yves Baumann
- Cofondateur : Numa de Montmollin 




##Documentation

à faire / à compléter

en vrac :
http://www.ct2c.fr/blog/starter-app-ruby-on-rails-partie-02
https://github.com/Erol/yomu
http://docs.ruby-doc.com/docs/ProgrammingRuby/
https://devcenter.heroku.com/articles/paperclip-s3
http://asciicasts.com/episodes/206-action-mailer-in-rails-3
https://github.com/enriclluelles/route_translator
http://rubylearning.com/blog/2012/07/24/minimal-i18n-with-rails-3-2/
http://jqueryui.com/datepicker/#localization
https://github.com/ryanb/cancan/wiki/Role-Based-Authorization
https://github.com/ryanb/cancan/wiki/Separate-Role-Model
https://github.com/ryanb/cancan/wiki/Abilities-in-Database
http://www.ct2c.fr/blog/starter-app-ruby-on-rails-partie-02
http://jsoup.org/cookbook/extracting-data/selector-syntax
http://www.dandelionmood.com/Ruby-on-Rails-Vues-Controleur.html
http://french.railstutorial.org/chapters/beginning#sec:install_rails
http://techie.lucaspr.im/creating-class-macros/
http://stackoverflow.com/questions/4113299/ruby-on-rails-server-options
https://github.com/weppos/breadcrumbs_on_rails
http://pusher.com/
http://stackoverflow.com/questions/6772203/implementing-notifications-in-rails
https://github.com/JangoSteve/remotipart
http://railscasts.com/episodes/417-foundation?view=asciicast
http://pat.github.io/thinking-sphinx/
https://github.com/glebtv/rails-uploader
http://www.localeapp.com/
http://thepugautomatic.com/2012/07/rails-i18n-tips/
http://rubysource.com/seeking-lovecraft-part-1-an-introduction-to-nlp-and-the-treat-gem/
https://github.com/ging/mailboxer
https://github.com/RobinBrouwer/gritter
https://github.com/pusher/notify
http://eggsonbread.com/2009/07/23/file-versioning-in-ruby-on-rails-with-paperclip-acts_as_versioned/
http://kgsspot.blogspot.ch/2011/09/convert-doc-to-pdf-in-command-line.html
http://railscasts.com/episodes/246-ajax-history-state?view=asciicast
https://github.com/esilverberg/DocPdfToText/blob/master/lib/docpdftotext.rb
https://github.com/crowdint/rails3-jquery-autocomplete
https://github.com/norman/friendly_id
http://rdoc.info/github/edgarjs/ajaxful-rating
http://thewebfellas.com/blog/2009/8/29/protecting-your-paperclip-downloads
http://dev.maxmind.com/geoip/legacy/geolite/
https://github.com/brainspec/enumerize
https://github.com/ricn/libreconv
http://pikock.github.io/bootstrap-magic/app/index.html#!/editor
http://git-scm.com/book/fr/Les-branches-avec-Git-Brancher-et-fusionner%C2%A0%3A-les-bases
http://pat.github.io/thinking-sphinx/resources.html
http://blog.ideematic.com/2011/11/creer-des-filtres-personnalises-avec-paperclip/



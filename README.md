#Repértoire de la nouvelle version de www.collaide.com

Béta version : http://www.collaide.com

Hack collaide: [![Hack collaide/collaide on Nitrous.IO](https://d3o0mnbgv6k92a.cloudfront.net/assets/hack-s-v1-7475db0cf93fe5d1e29420c928ebc614.png)](https://www.nitrous.io/hack_button?source=embed&runtime=rails&repo=collaide%2Fcollaide)

##Description
collaide.com est un site web offrant différents services aux étudiants.

##TODO

- [ ] pas coché
- [X] coché

##Recherche

Nous recherchons des personnes désirueses de nous aider :
* traducteur français-anglais -> trouvé
* traducteur français-allemand -> trouvé
* traducteur français-italien
* plusieurs développeurs Web dans les domaines suivant (un seul est c'est déjà cool): HTML/CSS, Javascript, Ruby/RoR
* une personne responsable de la communication (social marketing, réferencement, écriture de textes, etc)


##Languages et outils

Pour le versioning:
* git

Nous utilisons les languages suivant :
* Ruby
* Haml/ERB
* HTML/CSS
* Coffeescript
* Saas

Les base de données sont en :
* postgresql
* mysql (indexation)


Nous utilisons comme framework :
* Ruby on Rails
* Foundation

Liste des gems Ruby les plus importantes :
* devise
* ancestry
* cancan
* globalize3
* active-admin
* i18n
* i18n-routing

consulter le Gemfile pour une liste complète

Pour les tests, nous utilisons:
* Rspec
* cucumber
* FactoryGirl
* guard

##Organisation

Nous avons séparé le travil en plusieurs modules indépendants l'un de l'autre. Ainsi, chacun peut travailler sur le ou les modules qui lui conviennent sans devoir comprendre l'ensemble du site. Pour l'instant, il y a trois modules:

* Documents, gestion de documents scolaires.
* Annonces, Vendre des livres, en acheter. Par la suite, possibilité de poster des annonces pour d'autres choses
* Groups, échanger entre étudiants. Pour l'instant uniquement les groupes de travails sont implémentés, mais d'autres types de groupe viendront par la suite.

License Collaide
-------
Copyright (c) 2009-2014 All rights reserved.

- Fondateur : Yves Baumann
- Cofondateur : Numa de Montmollin 


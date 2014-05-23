#Repértoire de la nouvelle version de collaide.com

Béta version : http://www.collaide.com

Hack collaide: [![Hack collaide/collaide on Nitrous.IO](https://d3o0mnbgv6k92a.cloudfront.net/assets/hack-s-v1-7475db0cf93fe5d1e29420c928ebc614.png)](https://www.nitrous.io/hack_button?source=embed&runtime=rails&repo=collaide%2Fcollaide)

## Bugs, suggestion
Postez une issue sur github: https://github.com/collaide/collaide/issues/new

##Déscription
collaide.com est un site web offrant différents services aux étudiants. Actuellement il est possible de télécharger et mettre à disposition des documents scolaires, acheter et vendre des livres scolaires d'occasion et créer des groupes de travails.
### Echange de documents scolaires
C'est actuellement le service le plus utilisé. Il est possible de rechercher, télécharger et mettre des documents scolaires importants. Par exemple, rapport de projet, travail de maturité, de séminaire, dosssier, etc. Pour le moment plus de 100 documents sont mis à disposition.
### Vente et achat de livres scolaires
Permet d'acheter et vendre des livres d'occasions. Par la suite, il est prévu de pouvoir poster des annonces pour d'autres domaines. Appartements, échange de service, etc.
### Groupes de travails
Tout nouveau service! Il permet à des étudiants de discuter et échanger des fichiers dans un espace privé. C'est le service qui va la plus vite évoluer avec comme premiers objectifs la possibilité de garder un historique des modifications des fichiers, éditer, commenter des fichiers.

Par la suite, il est aussi prévu de pouvoir créer d'autres type de groupe. Groupes publics, présentation d'association d'étudiants, de faculté, etc.

##Recherche

Nous recherchons des personnes désirueses de nous aider :
* traducteur français-anglais -> trouvé
* traducteur français-allemand -> trouvé
* traducteur français-italien
* plusieurs développeurs Web dans les domaines suivant (un seul est c'est déjà cool): HTML/CSS, Javascript, Ruby/RoR
* une personne responsable de la communication (social marketing, réferencement, écriture de textes, etc)

##Organisation

collaide.com a été développé durant notre temps libre. Le coût des serveurs et autre et payé de notre poche. Si vous voulez nous soutenir finacièrement, [contactez-nous](http://www.collaide.com/fr/contactez-nous)

Nous avons séparé le travail en plusieurs modules indépendants l'un de l'autre. Ainsi, chacun peut travailler sur le ou les modules qui lui conviennent sans devoir comprendre l'ensemble du site. Pour l'instant, il y a 5 modules:

* Documents, gestion de documents scolaires.
* Annonces, Vendre des livres, en acheter. Par la suite, possibilité de poster des annonces pour d'autres choses
* Groupes, échanger entre étudiants. Pour l'instant uniquement les groupes de travails sont implémentés, mais d'autres types de groupe viendront par la suite.
* Utilisateurs, gestion des utilisateurs, messagerie privé et notification
* Activités, gestion des activités du site. Chaque utilisateur peur configurer quelles activités il veut voir et chaque modèle possède ses propres activités.

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

##Auteurs
Yves Baumann et Numa de Montmollin. [les auteurs](http://www.collaide.com/fr/a-propos)

License Collaide
-------
Copyright (c) 2009-2014 All rights reserved.

- Fondateur : Yves Baumann
- Cofondateur : Numa de Montmollin 

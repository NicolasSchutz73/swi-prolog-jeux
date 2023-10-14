# swi-prolog-jeux
Jeux d'aventure en prolog

1. Introduction
   
Tu es le redoutable Doom Slayer, luttant sans relâche contre les forces de l'enfer sur les plaines désolées de la dimension infernale. Des démons de toutes tailles et de toutes formes t'encerclent, leur présence maudite menaçant d'engloutir le monde dans les ténèbres. Pour maintenir la sainteté de la Terre et la purger de la souillure démoniaque, tu dois t'enfoncer dans les recoins les plus sombres de l'enfer lui-même, affronter le démon suprême qui règne en maître, et anéantir les hordes de démons ! Déchire et massacre, Doom Slayer, que tu ne trouves aucun repos tant que le dernier démon ne tombera pas et que tu ne seras pas revenu victorieux des entrailles infernales !

2. Carte du monde

   
                [LES ROYAUMES INFERNALS]                                   [L'ABIME DES TENEBRES]
    Tour de Phobos                                                       Les Profondeurs Infernales
       |                                                                            |
    Marais Sanglant----Le Bois des Noyés----------Rivière des Âmes-------------Mont Erebus-------------Les Flammes Éternelles
                        |                               |                           |
    Caverne------------Forteresse               Tourbillon des Âmes       Les Terres de la Damnation
    des Os             de l'Enfer
       |                |
    Le Crâne Abyssal    Le Marché Maudit--------Désolation Ardente


3. Exigences

   1. Porte verrouillées: "La Tour de Phobos" est bloqué jusqu'à ce que tu trouve une clé dans la "Désolation Ardente".
   2. Objet caché: a. L'Orbe de Sang est caché dans la "Tour de Phobos". b. Le Rubis de l'Enfer est caché dans la "Caverne des Os" jusqu'à que tu utilises un BFG 9000 activé pour le révéler. c. Le Plasma et le JetPack ne sont disponibles que dans la "Forteresse de l'Enfer".
   3. Objet à compléter: Le BFG 9000 ne peut pas être utilisé jusqu'à qu'il soit completement activé avec de la matière verte -  qui est le Plasma disponible dans la "Forteresse de l'Enfer".
   4. Resource limitées: Vous avez besoin de 10 000 Fury pour acheter le Plasma et le JetPack Initialement tu as 100 Fury. Tu dois trouver un moyen d'en avoir plus.

4. Solution
   1. Depuis la "Forteresse de l'Enfer", aller en direction du SUD puis de l'EST pour aller chercher la clé dans la "Désolation Ardente".
   2. Retourne à la "Forteresse de l'Enfer", va au NORD, puis OUEST jusqu'aux "Marais Sanglant", prend le "BFG 9000".
   3. Va au NORD, ouvre la "Tour de Phobos", prend "l'Orbe de Sang".
   4. Va au SUD, EST, SUD, au SUD jusqu'au "Marché Maudit", vend "l'Orbe de Sang" et reçois 5000 Furys.
   5. Achète le "Plasma". (L'astuce ici est d'acheter d'abord le "Plasma". Notez que vous NE DEVRIEZ JAMAIS essayer d'acheter le JetPack, sinon vous n'aurez même pas la chance d'activer votre BFG 9000!)
   6. Va au NORD, puis OUEST jusqu'a la "Caverne des Os", tu devras pouvoir activer un évènement spécial prendre le "Rubis de l'Enfer".
   [IMPASSE]Si vous vous dirigez ensuite vers le sud jusqu'au "Crâne Abyssal" et combattez, vous mourrez.
   7. Va à l'EST, puis SUD jusqu'au "Marché Maudit", vend le "Rubis de l'Enfer" pour 5000 Furys.
   8. Achète le JetPack.
   9. Va au NORD, puis NORD, puis l'EST jusqu'a la "Rivière des Âmes".
   10. Va au SUD jusqu'au "Tourbillon des Âmes", prend la "Lame du Creuset".
   11. Va au NORD, puis EST jusqu'au "Mont Erebus" de "l'Abime des Tenèbres"
   [IMPASSE] Si vous aller au SUD jusqu'aux "Terres de la Damnation" vous mourrez.
   [IMPASSE] Si vous aller a l'EST jusqu'aux "Flammes Éternelles" et vous combattez, vous mourrez.
   12. [FIN] Va au NORD jusqu'au "Profondeurs Infernales", affronter le démon suprême avec la "Lame du Creuset" - vous avez gagner !

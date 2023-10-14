%%% INFO-501, TP3, 2A
%%% Schutz Nicolas
%%%
%%% Lancez la "requête"
%%% jouer.
%%% pour commencer une partie !
%

% il faut déclarer les prédicats "dynamiques" qui vont être modifié par le programme.
:- dynamic a/2, position_init/1, position_obj/2, envie/1, fury/1.

% on remet à jours les positions des objets et du joueur
:- retractall(a(_, _)), retractall(position_init (_)), retractall(position_obj(_, _)), retractall(envie(_)), retractall(fury(_)).

% Information initial 
position_init(forteresse_de_lenfer).
fury(100).


% The facts describes the map.
passage(profondeurs_infernales, s, mont_erebus).
passage(mont_erebus, o, riviere_ames) :- a(jetpack, en_main).
passage(mont_erebus, o, ) :-
    write('Oh, there''s no way to get through this fierce river without'), nl,
    write('any tools. Could you find something like a boat, ship, or even'), nl,
    write('an jetpack?'), nl, fail.
passage(mont_erebus, s, terre_damnation).
passage(mont_erebus, e, flammes_eternelles).
passage(mont_erebus, n, profondeurs_infernales).
passage(flammes_eternelles, o, mont_erebus).
passage(riviere_ames, o, bois_noyes).
passage(riviere_ames, s, tourbillon_ames).
passage(riviere_ames, e, mont_erebus).
passage(tourbillon_ames, n, riviere_ames).
passage(bois_noyes, s, forteresse_de_lenfer).
passage(bois_noyes, o, marais_sanglant).
passage(bois_noyes, e, riviere_ames) :- a(jetpack, en_main).
passage(bois_noyes, e, riviere_ames) :-
        write('Oh, there''s no way to get through this fierce river without'), nl,
        write('any tools. Could you find something like a boat, ship, or even'), nl,
        write('an jetpack?'), nl, fail.
passage(marais_sanglant, n, tour_phobos) :- a(key, en_main).
passage(marais_sanglant, n, tour_phobos) :-
        write('Oops, the cabinet appears to be locked!'), nl, fail.
passage(marais_sanglant, e, bois_noyes).
passage(tour_phobos, s, marais_sanglant).
passage(forteresse_de_lenfer, s, marché_maudit).
passage(forteresse_de_lenfer, o, caverne_os).
passage(forteresse_de_lenfer, n, bois_noyes).
passage(caverne_os, e, forteresse_de_lenfer).
passage(caverne_os, s, crane_abyssal).
passage(crane_abyssal, n, caverne_os).
passage(marché_maudit, n, forteresse_de_lenfer).
passage(marché_maudit, e, desolation_ardente).
passage(desolation_ardente, o, marché_maudit).

/* position des objets */
position_obj(plasma, marché_maudit).
position_obj(jetpack, marché_maudit).

caché(bfg_900, marais_sanglant).
caché(orbe_sang, tour_phobos).
caché(clé, desolation_ardente).
caché(lame_creuset, tourbillon_ames).

/* Indique que le demon suprême est en vie */
envie(demon_supreme).

/*************************************
                Rules
**************************************/

% Ces règles décrivent comment acheter un objet
acheter(X) :-
        position_init(marché_maudit),
        position_obj(X, marché_maudit),
        fury(M), M >= 5000,
        retract(position_obj(X, marché_maudit)),
        assert(a(X, en_main)),
        retract(fury(M)),
        N is M - 5000,
        assert(fury(N)),
        write('OK. Furys restantes: '),
        write(N), nl, !.
acheter(X) :-
        position_init(marché_maudit),
        position_obj(X, marché_maudit),
        write('Le prix de '), write(X),
        write(' est 5000 Furys, '),
        fury(M), write('Mais vous n\'avez que '),
        write(M), write(' Furys!'), nl, !.
acheter(_) :-
        position_init(marché_maudit),
        write('Cet objet n\'est pas disponible dans ce marché !'), nl, !.
acheter(_) :-
        write('Vous n\'êtes pas au marché !'),
        nl.

/* Ces règles décrivent comment vendre un objet.*/
vendre(X) :-
        position_init(marché_maudit),
        a(X, en_main),
        (a(orbe_sang, en_main) ; a(rubis_enfer, en_main)),
        retract(a(X, en_main)),
        retract(fury(M)),
        N is M + 5000,
        assert(fury(N)),
        write('OK. Furys restantes: '),
        write(N), nl, !.
vendre(X) :-
        position_init(marché_maudit),
        a(X, en_main),
        write('Le marché n\'accepte pas ce genre d\'objet!'), nl, !.
vendre(_) :-
        position_init(marché_maudit),
        write('Tu ne l\'as pas!'), nl, !.
vendre(_) :-
        write('Vous n\'êtes pas au marché !'),
        nl.

/* Ramasser un objet. */
prendre(X) :-
        a(X, en_main),
        write('Vous l\'avez déjà !'),
        nl, !.

prendre(X) :-
        position_init(Place),
        a(X, Place),
        retract(a(X, Place)),
        assert(a(X, en_main)),
        write('OK.'),
        nl, !.

prendre(_) :-
        write('Je ne vois rien ici!'),
        nl.

/* Lacher un objet */
lacher(X) :-
        a(X, en_main),
        position_init(Place),
        retract(at(X, en_main)),
        assert(at(X, Place)),
        write('OK.'),
        nl, !.

lacher(_) :-
        write('Vous n\'avez pas ça en votre possession !'),
        nl.

/* déplacements */
aller(Direction) :-
        position_init(Ici),
        passage(Ici, Direction, La),
        retract(position_init(Ici)),
        assert(position_init(La)),
        regarder, !.

aller(_) :-
        write('Tu ne peux pas aller dans cette direction !').

/* Regarder autour de soi */
regarder :-
        position_init(Place),
        decrire(Place),
        nl,
        liste_objets(Place),
        nl.

/* Lister les objets */

liste_objets(Place) :-
        a(X, Place),
        write('Il y a'), write(X), write(' ici.'), nl,
        fail.

liste_objets(_).

/* The rules describe how to handle killing */
combattre :-
        position_init(crane_abyssal),
        write('Ah, your weak power can never protect you. You have been'), nl,
        write('eaten by the giant Enkidu.'), nl,
        !, die.
combattre :-
        position_init(flammes_eternelles),
        write('So bad! The deadly Decarabia with the enormous magic power'), nl,
        write('makes your body disappear in this fire hell forever.'), nl,
        !, die.

combattre :-
        position_init(profondeurs_infernales),
        a(lame_creuset, en_main),
        retract(envie(demon_supreme)),
        write('********************************************************'), nl,
        write('*****                CONGRATULATIONS!             ******'), nl,
        write('********************************************************'), nl, nl,
        write('The Devil Dark Dragon''s giant fangs are never as sharp as'), nl,
        write('your blade! It is killed - and you protect your honored'), nl,
        write('country and people. You guard the glorious pride of knights!'), nl,
        finish, !.

combattre :-
        position_init(profondeurs_infernales),
        write('Run away! The Devil Dark Dragon''s giant fangs are too sharp!'), nl,
        write('You cannot win this battle without a truly powerful weapon.'), nl,
        write('You really need a sacred sword to give you this power.'), nl.

combattre :-
        write('I see nothing inimical here.'), nl.

/* The rules display all the items you're now holding. */
inventaire :-
        a(X, en_main),
        write(X), nl, fail.
inventaire :-
        write('---END OF LIST---').

/* The rule defines how to die. */
die :- !, finish.

/* The rule defines how to exit Prolog elegantly. */
finish :-
        nl,
        write('The game is over. Please enter the ''halt.'' command.'),
        nl, !.

/* The rule writes out game introduction. */
introduction :-
        write('********************************************************'), nl,
        write('*****                DRAGON FIGHTER                *****'), nl,
        write('********************************************************'), nl, nl,
        write('You are a brave knight living in the kingdom of Holy Modo.'), nl,
        write('Your country has long been threatened by the Devil Dark'), nl,
        write('Dragon lurking in the land of unknown, where nobody has ever'), nl,
        write('explored or even known its existence. To guard the fame'), nl,
        write('and rightness of the sacred knight, you need to find out this'), nl,
        write('place - and kill the dragon! Good luck!'), nl, nl.

/* This rule just writes out game instructions. */

instructions :-
        nl,
        write('Les commandes doivent être données avec la syntaxe Prolog habituelle.'), nl,
        write('Les commandes existantes sont :'), nl,
        write('jouer.                   -- pour commencer une partie.'), nl,
        write('n. s. e. o.              -- pour aller dans cette direction (nord / sud / est / ouest).'), nl,
        write('prendre(objet).          -- pour prendre un objet.'), nl,
        write('lacher(objet).           -- pour lacher un objet en votre possession.'), nl,
        write('regarder.                -- pour regarder autour de vous.'), nl,
        write('passer(objet).           -- pour passer en mode trépas.'), nl,
        write('instructions.            -- pour revoir ce message !.'), nl,
        write('code(objet).             -- Utiliser le code pour trouver un objet.'), nl,
        write('clef(objet).             -- Utiliser la clef pour trouver un objet.'), nl,
        write('trep(objet).             -- Utiliser le mode trépas pour trouver un objet.'), nl,
        write('halt.                    -- pour terminer la partie et quitter.'),nl,
        write('gagner.               -- quand vous avez construit l \'avion!.'),
        nl,nl.


/* lancer une nouvelle partie */

jouer :-
        introduction,
        instructions,
        regarder.

/* The rules defines shortcuts. */
e :- aller(e).
s :- aller(s).
o :- aller(o).
n :- aller(n).
i :- write('You''re currently holding:'), nl, inventaire.


/* Les règles décrivent différents endroits (dans diverses circonstances) dans le jeu. */

decrire(forteresse_de_lenfer) :-
    write('Vous êtes maintenant dans la Forteresse de l''Enfer. Les murs sont'), nl,
    write('recouverts de chair en décomposition et d''ossements. Les cris'), nl,
    write('des démons résonnent tout autour de vous. Vous savez que pour'), nl,
    write('survivre, vous devez avancer plus profondément dans cette'), nl,
    write('forteresse sinistre.'), nl.

decrire(marché_maudit) :-
    write('Bienvenue sur le Marché Maudit ! Cet endroit est infesté de'), nl,
    write('marchands démoniaques vendant des armes et des artefacts'), nl,
    write('surnaturels. Votre seule monnaie ici est l''âme. Vous pouvez'), nl,
    write('acheter des pouvoirs infernaux pour vous renforcer, mais cela'), nl,
    write('vous coûtera votre humanité.'), nl.

decrire(desolation_ardente) :-
    write('Vous vous trouvez dans la Désolation Ardente, un paysage stérile'), nl,
    write('où la lave en fusion coule à flots. Des créatures démoniaques se'), nl,
    write('cachent parmi les rochers. Vous savez que la prochaine étape de'), nl,
    write('votre voyage vous mènera à travers ce paysage infernal.'), nl.
decrire(desolation_ardente) :-

decrire(caverne_os) :-
    write('Vous pénétrez dans une sombre caverne d''ossements. Les murs sont'), nl,
    write('tapissés de crânes et d''os. L''air est chargé d''une atmosphère'), nl,
    write('sinistre. Vous avez le sentiment que quelque chose de terrifiant'), nl,
    write('vous attend au plus profond de la caverne.'), nl.
decrire(caverne_os) :-
decrire(caverne_os) :-

decrire(crane_abyssal) :-
    write('Vous êtes maintenant face au Crâne Abyssal, un portail vers les'), nl,
    write('ténèbres les plus profondes de l''enfer. Vous pouvez sentir un'), nl,
    write('souffle maléfique s''échapper de cette sinistre ouverture. Il n''y a'), nl,
    write('pas de retour en arrière. Vous devez avancer et affronter l''horreur'), nl,
    write('qui vous attend de l''autre côté.'), nl.

decrire(bois_noyes) :-
    write('Vous vous trouvez dans les Bois Noyés, un endroit maudit où les'), nl,
    write('arbres sont morts et pourrissent. Des ombres maléfiques se cachent'), nl,
    write('parmi les arbres en décomposition. Vous savez que c''est un endroit'), nl,
    write('dangereux, mais vous n''avez pas d''autre choix que de le traverser.'), nl.

decrire(marais_sanglant) :-
    write('Vous êtes piégé dans le Marais Sanglant, un endroit infâme où la'), nl,
    write('boue est imprégnée de sang et de souffrance. Des créatures cauchemardesques'), nl,
    write('rôdent dans les eaux troubles. Vous devez trouver un moyen de sortir de'), nl,
    write('ce cauchemar vivant.'), nl.

decrire(tour_phobos) :-
    write('Vous êtes au pied de la Tour de Phobos, une structure démoniaque qui'), nl,
    write('s''élève vers les cieux. Des cris d''agonie émanent de l''intérieur de'), nl,
    write('la tour. Vous savez que pour atteindre votre objectif, vous devez'), nl,
    write('grimper cette tour infernale.'), nl.
decrire(tour_phobos) :-

decrire(riviere_ames) :-
    write('Vous naviguez sur la Rivière des Âmes dans un bateau de damnation.'), nl,
    write('Les âmes tourmentées flottent dans l''eau, gémissant de douleur.'), nl,
    write('Vous ne savez pas où vous mènera cette sinistre rivière, mais'), nl,
    write('vous devez la suivre pour avancer dans votre quête.'), nl.

decrire(tourbillon_ames) :-
    write('Vous êtes pris dans un tourbillon d''âmes tourmentées. Les âmes'), nl,
    write('hurlent et se tordent autour de vous. Vous réalisez que vous êtes'), nl,
    write('dans une dimension de tourment éternel. Au centre du tourbillon se'), nl,
    write('trouve un artefact puissant que vous pouvez tenter de récupérer,'), nl,
    write('mais cela implique de plonger plus profondément dans cette folie.'), nl.

decrire(mont_erebus) :-
    write('Vous vous trouvez sur le Mont Érébus, une montagne infernale couverte'), nl,
    write('de flammes et de lave. Les démons volent dans les airs, prêts à'), nl,
    write('vous attaquer. Vous êtes proche de votre objectif final, mais vous'), nl,
    write('devez encore gravir cette montagne dangereuse pour l''atteindre.'), nl.

decrire(terre_damnation) :-
    write('Vous êtes sur la Terre de Damnation, un endroit où l''enfer a pris'), nl,
    write('racine. Les âmes tourmentées errent sans fin, cherchant la libération'), nl,
    write('de leur douleur éternelle. Vous êtes au seuil de l''enfer lui-même.'), nl,
    write('Votre ultime épreuve vous attend ici.'), nl.

decrire(flammes_eternelles) :-
    write('Vous avez atteint les Flammes Éternelles, le cœur de l''enfer. Les'), nl,
    write('flammes dévorent tout sur leur passage, et les démons les plus'), nl,
    write('puissants règnent en maîtres. Vous devez maintenant affronter'), nl,
    write('l''horreur ultime pour atteindre votre objectif.'), nl.

decrire(profondeurs_infernales) :-
    write('Vous êtes maintenant dans les Profondeurs Infernales, un endroit'), nl,
    write('où les ténèbres sont absolues. Il n''y a pas de retour en arrière,'), nl,
    write('et vous êtes confronté à l''ultime épreuve. Les démons les plus'), nl,
    write('terrifiants et les forces infernales les plus sombres vous attendent'), nl,
    write('dans ce royaume cauchemardesque.'), nl.

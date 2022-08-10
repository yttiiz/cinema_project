--sqlite
PRAGMA foreign_keys = ON;

-- ========================| INFORMATION IMPORTANTE | ======================== --
-- Une réservation équivaut à une séance, pouvant compter jusqu'à 5 personnes sur cette même réservation.
-- Avec son compte, l'utilisateur pourra toutefois réserver autant de fois qu'il veut d'autres séances de son choix.
-- L'(les) administrateur(s) pourra(ont) à tout moment modifier les données en se connectant à la base de données via une interface graphique.

-- ========================| ETAPE 1 | ======================== --
-- Création des tables dans la base de données.

CREATE TABLE user
(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    firstname VARCHAR(100) NOT NULL,
    lastname VARCHAR(100) NOT NULL,
    date_of_birth INTEGER NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone INTEGER NOT NULL,
    gender VARCHAR(100) NULL
);

CREATE TABLE room
(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    number INTEGER NOT NULL,
    capacity INTEGER NOT NULL
);

CREATE TABLE seat
(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    row_line VARCHAR(100) NOT NULL,
    number INTEGER NOT NULL,
    room_id INTEGER,
    FOREIGN KEY (room_id) REFERENCES room (id)
);

CREATE TABLE user_seats
(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    seat_01 INTEGER,
    seat_02 INTEGER,
    seat_03 INTEGER,
    seat_04 INTEGER,
    seat_05 INTEGER,
    FOREIGN KEY (seat_01) REFERENCES seat (id),
    FOREIGN KEY (seat_02) REFERENCES seat (id),
    FOREIGN KEY (seat_03) REFERENCES seat (id),
    FOREIGN KEY (seat_04) REFERENCES seat (id),
    FOREIGN KEY (seat_05) REFERENCES seat (id)
);

CREATE TABLE price
(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    mode REAL NOT NULL
);

CREATE TABLE total_price
(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    price_01 INTEGER NOT NULL,
    price_02 INTEGER,
    price_03 INTEGER,
    price_04 INTEGER,
    price_05 INTEGER,
    FOREIGN KEY (price_01) REFERENCES price (id),
    FOREIGN KEY (price_02) REFERENCES price (id),
    FOREIGN KEY (price_03) REFERENCES price (id),
    FOREIGN KEY (price_04) REFERENCES price (id),
    FOREIGN KEY (price_05) REFERENCES price (id)
);

CREATE TABLE cinema
(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    city VARCHAR(100) NOT NULL,
    address VARCHAR(255) NOT NULL,
    room_id INTEGER NOT NULL,
    handicap_access TINYINT NOT NULL,
    FOREIGN KEY (room_id) REFERENCES room (id)
);

CREATE TABLE movie
(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    title VARCHAR(100) NOT NULL,
    director VARCHAR(100) NOT NULL,
    production VARCHAR(100) NOT NULL,
    synopsys VARCHAR(255) NOT NULL,
    main_characters VARCHAR(255) NOT NULL,
    duration INTEGER NOT NULL,
    year INTEGER NOT NULL,
    gender VARCHAR(100) NULL
);

CREATE TABLE show
(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    start INTEGER NOT NULL,
    movie_id INTEGER NOT NULL,
    cinema_id INTEGER NOT NULL,
    FOREIGN KEY (movie_id) REFERENCES movie (id),
    FOREIGN KEY (cinema_id) REFERENCES cinema (id)
);

CREATE TABLE booking
(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    reservation VARCHAR(100) NOT NULL,
    user_id INTEGER,
    show_id INTEGER,
    user_seats_id INTEGER,
    total_price_id INTEGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES user (id),
    FOREIGN KEY (show_id) REFERENCES show (id),
    FOREIGN KEY (user_seats_id) REFERENCES user_seats (id),
    FOREIGN KEY (total_price_id) REFERENCES total_price (id)
);

CREATE TABLE ticket
(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    day VARCHAR(100) NOT NULL,
    booking_id INTEGER,
    FOREIGN KEY (booking_id) REFERENCES booking (id)
);

-- ========================| ETAPE 2 | ======================== --
-- Insertion des données dans les tables préalablement créées.

-- 1 - Les données basiques.

INSERT INTO price (mode) VALUES (9.20), (7.60), (5.90);

INSERT INTO room (number, capacity)
VALUES (0001, 50), (0002, 70), (0003, 30), (0004, 40), (0005, 50), (0006, 70), (0007, 30), (0008, 40);

INSERT INTO seat (row_line, number, room_id)
VALUES ('A', 1, 1), ('A', 2, 1), ('A', 3, 1), ('A', 4, 1), ('A', 5, 1), ('B', 1, 1), ('B', 2, 1), ('B', 3, 1), ('B', 4, 1), ('B', 5, 1);

INSERT INTO cinema (city, address, room_id, handicap_access)
VALUES
(
    'Rennes', '11 Avenue de la Gare', 1, true
),
(
    'Lyon', '17 Rue Paul Verlaine', 2, false
),
(
    'Toulouse', '105 Boulevard du Général de Gaulle', 3, false
),
(
    'Grenoble', '144 Boulevard Gorki', 4, true
),
(
    'Vincennes', '125 Rue de Paris', 5, false
),
(
    'Choisy-le-Roi', 'Z.I de la Gibeuse', 6, false
);

-- 2 - Les données évolutives.

INSERT INTO user (firstname, lastname, date_of_birth, password, email, phone, gender) VALUES
(
    'Marc', 'Tessier', 1326754605600, 'pw-001', 'marc.tessier@gmail.com', 0665901028, 'M'
),
(
    'Martine', 'Buisson', 1659991929776, 'pw-002', 'martine.buisson@gmail.com', 0617288833, 'F'
),
(
    'Jean-Philippe', 'Ledoux', 1595714294774, 'pw-003', 'p.ladoux@yahoo.fr', 0748512536, 'M'
),
(
    'Sylvain', 'Letellier', 1457802112545, 'pw-004', 'sylvain.letellier@yahoo.fr', 0648582736, 'M'
),
(
    'Arnaud', 'Hauterville', 1595714294774, 'pw-005', 'arnaud.hauterville@amd.fr', 0748512536, 'M'
),
(
    'Isabelle', 'Le Guen', 2345493314826, 'pw-006', 'isabelle.le-guen@amd.fr', 257484102665, 'F'
);

INSERT INTO movie (title, director, production, synopsys, main_characters, duration, year, gender)
VALUES
(
    'Avatar 2', 'James Cameron', '20th Century Studios', "Jake Sully et Neytiri sont devenus parents. L'intrigue se déroule une dizaine d'années après les événements racontés dans le long-métrage originel. Leur vie idyllique, proche de la nature, est menacée lorsque la Resources Development Administration, dangereuse organisation non-gouvernementale, est de retour sur Pandora.", 'Michelle Yeoh, Zoë Saldaña, Sam Worthington', 7212568, 2022, 'SF'
),
(
    'Matrix Resurrections', 'Lana Wachowski', 'Warner Bros.', 'MATRIX RESURRECTIONS nous replonge dans deux réalités parallèles – celle de notre quotidien et celle du monde qui s’y dissimule. Pour savoir avec certitude si sa réalité propre est une construction physique ou mentale, et pour véritablement se connaître lui-même, M. Anderson devra de nouveau suivre le lapin blanc.', 'Keanu Reeves, Carrie-Ann Moss, Yahya Abdul-Mateen II', 6517591, 2021, 'SF'
),
(
    'Bullet Train', 'David Leitch', 'Sony', "Coccinelle est un assassin malchanceux et particulièrement déterminé à accomplir sa nouvelle mission paisiblement après que trop d'entre elles aient déraillé. Mais le destin en a décidé autrement et l'embarque dans le train le plus rapide au monde aux côtés d'adversaires redoutables.", 'Joey King, Brad Pitt, Hiroyuki Sanada', 5212741, 2022, 'Humour'
);

INSERT INTO show (start, movie_id, cinema_id)
VALUES
(
    6917859787, 2, 1
),
(
    6142897320, 1, 6
),
(
    6012458963, 2, 5
),
(
    6114528761, 3, 1
),
(
    6235485692, 1, 4
),
(
    6989978542, 3, 2
);

-- 3 - Les données occasionnelles.
-- Nous considérons ici, que l'utilisateur qui a l'id n°1 à réservé 3 places, 2 au tarif de base et une au tarif étudiant, pour la séance qui à l'id n°1.

INSERT INTO user_seats (seat_01, seat_02, seat_03) VALUES (1, 2, 3);

INSERT INTO total_price (price_01, price_02, price_03) VALUES (1, 2, 1);

INSERT INTO booking (reservation, user_id, show_id, user_seats_id, total_price_id) VALUES ('0145-XTJK', 1, 1, 1, 1);

INSERT INTO ticket (day, booking_id) VALUES ('2022-8-15', 1);

-- ========================| ETAPE 3 | ======================== --
-- 1 - Requête pour associer le numéro de réservation avec quelques infos du client

SELECT b.id, b.reservation, u.firstname, u.lastname, u.email
FROM booking AS b JOIN user AS u WHERE u.id = b.user_id;

-- 2 - Requête pour associer la séance et le film qui y sera diffuser.

SELECT s.id, s.start, m.title, m.director, m.main_characters, m.year, m.gender
FROM show AS s JOIN movie AS m WHERE s.id = 1 AND s.movie_id = m.id;

-- 3 - Requête pour récupérer le prix total du ticket.

SELECT SUM(p.mode) AS prix_total 
FROM price AS p JOIN total_price AS tp
WHERE tp.price_01 = p.id OR
tp.price_02 = p.id OR
tp.price_03 = p.id OR
tp.price_04 = p.id OR
tp.price_05 = p.id;
CREATE TABLE city(
    city_id NUMBER GENERATED BY DEFAULT AS IDENTITY,
    name VARCHAR2(50) NOT NULL,
    no_of_theaters NUMBER,
    PRIMARY KEY (city_id)
);


ALTER TABLE city ADD country VARCHAR(70) NOT NULL;

--------------------------------------------------------------------------------

insert into city (name, no_of_theaters, country) VALUES ('Warsaw', 20, 'Poland');
insert into city (name, no_of_theaters, country) VALUES ('Krakow', 16, 'Poland');
insert into city (name, no_of_theaters, country) VALUES ('Gdansk', 9, 'Poland');
insert into city (name, no_of_theaters, country) VALUES ('Milan', 12, 'Italy');
insert into city (name, no_of_theaters, country) VALUES ('Rome', 18, 'Italy');
insert into city (name, no_of_theaters, country) VALUES ('Venice', 10, 'Italy');


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE theater(
    theater_id NUMBER GENERATED BY DEFAULT AS IDENTITY,
    name VARCHAR2(50) NOT NULL,
    address VARCHAR2(200) NOT NULL,
    contact VARCHAR2(50) NOT NULL,
    website VARCHAR2(200) NOT NULL,
    city_id NUMBER NOT NULL,
    PRIMARY KEY (theater_id),
    FOREIGN KEY (city_id) references city(city_id)
);

ALTER TABLE theater modify contact VARCHAR2(20);

--------------------------------------------------------------------------------

insert into theater (name, address,contact,website,city_id) VALUES 
('Il Cinemino','Via Seneca, 6, 20135 Milano MI, Italy','+39 02 3594 8722','https://www.ilcinemino.it/', 24);
insert into theater (name, address,contact,website,city_id) VALUES 
('The Space Odeon','Via Santa Radegonda, 8, 20121 Milano MI, Italy','+39 02 3534 8722', 'https://www.thespacecinema.it/al-cinema/milano-odeon', 24);
insert into theater (name, address,contact,website,city_id) VALUES 
('Multikino','Z?ote Tarasy, Z?ota 59, 00-120 Warszawa','+48 412672360','https://multikino.pl/repertuar/warszawa-zlote-tarasy', 21);
insert into theater (name, address,contact,website,city_id) VALUES 
('Multikino','Dobrego Pasterza 128, 30-962 Krak??w','+48 542303630','https://multikino.pl/repertuar/krakow', 22);
insert into theater (name, address,contact,website,city_id) VALUES 
('Multikino','Aleja Zwyci?stwa 14, 80-219 Gda?sk','54 230 36 31','https://multikino.pl/repertuar/gdansk', 23);


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------



CREATE TABLE movie(
    movie_id NUMBER GENERATED BY DEFAULT AS IDENTITY,
    name VARCHAR2(200) NOT NULL,
    duration VARCHAR2(50) NOT NULL,
    production VARCHAR2(200) NOT NULL,
    direction VARCHAR2(200) NOT NULL,
    genre VARCHAR2(200) NOT NULL,
    rating NUMBER NOT NULL,
    PRIMARY KEY (movie_id)
);

--------------------------------------------------------------------------------

insert into movie (name, duration, production, direction, genre, rating) VALUES 
('Dune', '2h 35m','Legendary Pictures', 'Denis Villeneuve', 'Science-Fiction, Adventure', 8.2);
insert into movie (name, duration, production, direction, genre, rating) VALUES 
('Spider-Man: No Way Home', '2h 28m','Colombia pictres, Marvel Studios, Pascal Pictures', 'Jon Watts', 'Science-Fiction, Action, Adventure', 8.7);
insert into movie (name, duration, production, direction, genre, rating) VALUES 
('The Matrix Resurrections', '2h 28m','Village Roadshow Pictures, Venus Castina Productions', 'Lana Wachowski', 'Science-Fiction, Action', 7.5);
insert into movie (name, duration, production, direction, genre, rating) VALUES 
('House of Gucci', '2h 37m','Ridley Scott, Giannina Facio, Kevin J. Walsh, Mark Huffams', 'Ridley Scott', 'Crime, Drama', 6.9);
insert into movie (name, duration, production, direction, genre, rating) VALUES 
('Eternals', '2h 37m','Marvel Studios', 'Chloe Zhao', 'Action, Adventure', 6.8);
insert into movie (name, duration, production, direction, genre, rating) VALUES 
('Clifford the Big Red Dog', '1h 37m','Jordan Kerner, Iole Lucchese', 'Walt Becker', 'Comedy, Family', 6.0);


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------


CREATE TABLE theatering_movies (
    movie_id NUMBER NOT NULL,
    theater_id NUMBER NOT NULL,
    premiere DATE NOT NULL,
    ticket_price NUMBER NOT NULL,
    CONSTRAINT pk_theatering_movies PRIMARY KEY(movie_id, theater_id),
    CONSTRAINT fk_movie FOREIGN KEY (movie_id) REFERENCES movie(movie_id),
    CONSTRAINT fk_theater FOREIGN KEY (theater_id) REFERENCES theater(theater_id)
    
);

ALTER TABLE theatering_movies 
modify(
    ticket_price NUMBER(5,2)
); 

ALTER TABLE theatering_movies ADD currency VARCHAR(3) NOT NULL;

--------------------------------------------------------------------------------

insert into theatering_movies (movie_id, theater_id, premiere, ticket_price, currency) VALUES (21, 24, DATE '2021-10-22', 25.00, 'PLN');
insert into theatering_movies (movie_id, theater_id, premiere, ticket_price, currency) VALUES (21, 23, DATE '2021-10-22', 24.90, 'PLN');
insert into theatering_movies (movie_id, theater_id, premiere, ticket_price, currency) VALUES (21, 21, DATE '2021-09-03', 4.90,  'EUR');
insert into theatering_movies (movie_id, theater_id, premiere, ticket_price, currency) VALUES (22, 23, DATE '2021-12-17', 25.40, 'PLN');
insert into theatering_movies (movie_id, theater_id, premiere, ticket_price, currency) VALUES (22, 24, DATE '2021-12-17', 23.20, 'PLN');
insert into theatering_movies (movie_id, theater_id, premiere, ticket_price, currency) VALUES (22, 21, DATE '2021-09-17', 5.40,  'EUR');
insert into theatering_movies (movie_id, theater_id, premiere, ticket_price, currency) VALUES (22, 41, DATE '2021-12-17', 23.40, 'PLN');


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

SELECT
a.name NAME,
a.genre GENRE,
a.rating RATING
FROM movie a 
INNER JOIN theatering_movies b 
ON a.movie_id = b.movie_id WHERE a.rating > 8.5;


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE cast (
    actor_id NUMBER GENERATED BY DEFAULT AS IDENTITY,
    name VARCHAR2(100) NOT NULL,
    PRIMARY KEY (actor_id)
);

--------------------------------------------------------------------------------

insert into cast (name) VALUES ('Tom Holland');
insert into cast (name) VALUES ('Zendaya');
insert into cast (name) VALUES ('William Dafoe');
insert into cast (name) VALUES ('Jamie Foxx');
insert into cast (name) VALUES ('Benedict Cumerbatch');

insert into cast (name) VALUES ('Timothee Chalamet');
insert into cast (name) VALUES ('Rebecca Ferguson');
insert into cast (name) VALUES ('Oscar Issac');
insert into cast (name) VALUES ('Jason Mamoa');



--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE acted_movies(
    movie_id NUMBER NOT NULL,
    actor_id NUMBER NOT NULL,
    acted_year NUMBER NOT NULL,
    CONSTRAINT pk_acted_movies PRIMARY KEY(movie_id, actor_id),
    CONSTRAINT fk_acted_movie FOREIGN KEY (movie_id) REFERENCES movie(movie_id),
    CONSTRAINT fk_actor FOREIGN KEY (actor_id) REFERENCES cast(actor_id)
);

--------------------------------------------------------------------------------

insert into acted_movies (movie_id, actor_id, acted_year) VALUES (21, 15, 2021);
insert into acted_movies (movie_id, actor_id, acted_year) VALUES (21, 16, 2021);
insert into acted_movies (movie_id, actor_id, acted_year) VALUES (21, 17, 2021);
insert into acted_movies (movie_id, actor_id, acted_year) VALUES (21, 18, 2021);
insert into acted_movies (movie_id, actor_id, acted_year) VALUES (21, 11, 2021);

insert into acted_movies (movie_id, actor_id, acted_year) VALUES (22, 10, 2021);
insert into acted_movies (movie_id, actor_id, acted_year) VALUES (22, 11, 2021);
insert into acted_movies (movie_id, actor_id, acted_year) VALUES (22, 12, 2021);
insert into acted_movies (movie_id, actor_id, acted_year) VALUES (22, 13, 2021);
insert into acted_movies (movie_id, actor_id, acted_year) VALUES (22, 14, 2021);

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------



CREATE TABLE news (
    news_id NUMBER GENERATED BY DEFAULT AS IDENTITY,
    title VARCHAR2(100) NOT NULL,
    content VARCHAR2(1000) NOT NULL,
    news_date DATE NOT NULL,
    posted_by VARCHAR2(50) NOT NULL,
    movie_id NUMBER NOT NULL,
    PRIMARY KEY (news_id),
    FOREIGN KEY (movie_id) references movie(movie_id)
);

--------------------------------------------------------------------------------

insert into news (title, content, news_date, posted_by, movie_id) VALUES
('Dune is a classic space opera. Let???s talk about other great works in this genre.', 
'Ah, the space opera! That ???hacky, grinding, stinking, outworn, spaceship yarn,??? as science fiction author Wilson Tucker memorably put it when he coined the term in 1941. 
Science fiction writers (and readers) seem to never get enough of big spaceships, big galactic empires or giant worms. Frank Herbert???s ???Dune??? may seem like the most epic of these epics, 
but before him writers such as E.E. ???Doc??? Smith and Edmond ???The World Wrecker??? Hamilton were dreaming up sweeping space adventures. Let???s talk about some of our favorites in this action-packed genre.',
DATE '2021-12-18', 'The Washington Post', 21);

--------------------------------------------------------------------------------

insert into news (title, content, news_date, posted_by, movie_id) VALUES
('Spider-Man: No Way Home is already breaking pre-pandemic box-office records', 
'The third movie in Sony Pictures and Marvel Studios??? Spidey films, Spider-Man: No Way Home, which promises [NO, WE WON???T SPOIL ANYTHING] is proving to be a genuine pandemic-era smash hit. 
In previews on Thursday, Dec. 16 alone, No Way Home pulled in a reported $50 million in domestic box office. If international box office is taken into account, the number jumps to $93.6 million.',
DATE '2021-12-17', 'Polygon', 22);

--------------------------------------------------------------------------------

insert into news (title, content, news_date, posted_by, movie_id) VALUES
('The Matrix Resurrections: First reactions are in', 
'The Matrix Resurrections has received its first batch of reactions and even folks who enjoyed it are aware that not everyone will. Voxs critic Emily VanDerWerff took just that stance. 
Yahoo Entertainment writer Ethan Alter tweeted Absolutely adored which builds on where the sequels left off in beautiful and unexpected ways, and presents a world thats entirely consistent 
with what came before and also opens it up to a host of new stories. My synapses have been firing for days.',
DATE '2021-12-18', 'CNN Entertainment', 23);


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE hall(
    hall_id NUMBER GENERATED BY DEFAULT AS IDENTITY,
    no_of_seat NUMBER NOT NULL,
    theather_id NUMBER NOT NULL,
    PRIMARY KEY (hall_id),
    FOREIGN KEY (theather_id) references theater(theater_id)    
);

ALTER TABLE hall ADD hall_num NUMBER NOT NULL;

--------------------------------------------------------------------------------

insert into hall (hall_num, no_of_seat, theather_id) VALUES (1, 176, 23);
insert into hall (hall_num, no_of_seat, theather_id) VALUES (2, 364, 23);
insert into hall (hall_num, no_of_seat, theather_id) VALUES (3, 372, 23);

insert into hall (hall_num, no_of_seat, theather_id) VALUES (1, 120, 22);
insert into hall (hall_num, no_of_seat, theather_id) VALUES (2, 340, 22);


insert into hall (hall_num, no_of_seat, theather_id) VALUES (1, 376, 21);
insert into hall (hall_num, no_of_seat, theather_id) VALUES (2, 164, 21);

insert into hall (hall_num, no_of_seat, theather_id) VALUES (1, 160, 41);

insert into hall (hall_num, no_of_seat, theather_id) VALUES (1, 120, 24);


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE seat (
    seat_id NUMBER GENERATED BY DEFAULT AS IDENTITY,
    row_seat NUMBER NOT NULL,
    no_seat  NUMBER NOT NULL,
    hall_id NUMBER NOT NULL,
    PRIMARY KEY (seat_id),
    FOREIGN KEY (hall_id) references hall(hall_id)
);

ALTER TABLE seat
modify(
    row_seat VARCHAR2(2)
);

--------------------------------------------------------------------------------

insert into seat (row_seat, no_seat, hall_id) VALUES ('A',1,3);
insert into seat (row_seat, no_seat, hall_id) VALUES ('A',2,3);
insert into seat (row_seat, no_seat, hall_id) VALUES ('A',3,3);
insert into seat (row_seat, no_seat, hall_id) VALUES ('D',11,3);
insert into seat (row_seat, no_seat, hall_id) VALUES ('D',12,3);
insert into seat (row_seat, no_seat, hall_id) VALUES ('D',13,3);
insert into seat (row_seat, no_seat, hall_id) VALUES ('D',14,3);


insert into seat (row_seat, no_seat, hall_id) VALUES ('H',13,2);
insert into seat (row_seat, no_seat, hall_id) VALUES ('H',14,2);
insert into seat (row_seat, no_seat, hall_id) VALUES ('H',15,2);
insert into seat (row_seat, no_seat, hall_id) VALUES ('H',16,2);
insert into seat (row_seat, no_seat, hall_id) VALUES ('H',17,2);
insert into seat (row_seat, no_seat, hall_id) VALUES ('I',13,2);
insert into seat (row_seat, no_seat, hall_id) VALUES ('I',14,2);

insert into seat (row_seat, no_seat, hall_id) VALUES ('L',13,6);
insert into seat (row_seat, no_seat, hall_id) VALUES ('L',14,6);
insert into seat (row_seat, no_seat, hall_id) VALUES ('L',15,6);
insert into seat (row_seat, no_seat, hall_id) VALUES ('M',14,6);
insert into seat (row_seat, no_seat, hall_id) VALUES ('M',15,6);
insert into seat (row_seat, no_seat, hall_id) VALUES ('N',12,6);
insert into seat (row_seat, no_seat, hall_id) VALUES ('N',19,6);


insert into seat (row_seat, no_seat, hall_id) VALUES ('O',11,21);
insert into seat (row_seat, no_seat, hall_id) VALUES ('O',12,21);
insert into seat (row_seat, no_seat, hall_id) VALUES ('P',16,21);
insert into seat (row_seat, no_seat, hall_id) VALUES ('P',17,21);
insert into seat (row_seat, no_seat, hall_id) VALUES ('P',18,21);
insert into seat (row_seat, no_seat, hall_id) VALUES ('Q',11,21);
insert into seat (row_seat, no_seat, hall_id) VALUES ('Q',12,21);


insert into seat (row_seat, no_seat, hall_id) VALUES ('R',10,22);
insert into seat (row_seat, no_seat, hall_id) VALUES ('R',11,22);
insert into seat (row_seat, no_seat, hall_id) VALUES ('R',12,22);

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE screening(
    screening_id NUMBER GENERATED BY DEFAULT AS IDENTITY,
    date_n_time DATE NOT NULL,
    status VARCHAR2(50) NOT NULL,
    theater_id NUMBER NOT NULL,
    movie_id NUMBER NOT NULL,
    hall_id NUMBER NOT NULL,
    PRIMARY KEY (screening_id),
    FOREIGN KEY (theater_id) references theater(theater_id),
    FOREIGN KEY (movie_id) references movie(movie_id),
    FOREIGN KEY (hall_id) references hall(hall_id)
    
);

--------------------------------------------------------------------------------

insert into screening (date_n_time, status, theater_id, movie_id, hall_id) VALUES (TO_DATE('2021/12/18 21:10:00', 'yyyy/mm/dd hh24:mi:ss'), 'RUNNING', 23, 22, 2);
insert into screening (date_n_time, status, theater_id, movie_id, hall_id) VALUES (TO_DATE('2021/12/18 16:50:00', 'yyyy/mm/dd hh24:mi:ss'), 'RUNNING', 23, 22, 2);
insert into screening (date_n_time, status, theater_id, movie_id, hall_id) VALUES (TO_DATE('2021/12/18 10:40:00', 'yyyy/mm/dd hh24:mi:ss'), 'RUNNING', 23, 22, 2);
insert into screening (date_n_time, status, theater_id, movie_id, hall_id) VALUES (TO_DATE('2021/12/18 20:30:00', 'yyyy/mm/dd hh24:mi:ss'), 'RUNNING', 23, 22, 1);


insert into screening (date_n_time, status, theater_id, movie_id, hall_id) VALUES (TO_DATE('2021/12/18 16:40:00', 'yyyy/mm/dd hh24:mi:ss'), 'RUNNING', 23, 21, 1);
insert into screening (date_n_time, status, theater_id, movie_id, hall_id) VALUES (TO_DATE('2021/12/18 20:30:00', 'yyyy/mm/dd hh24:mi:ss'), 'RUNNING', 23, 21, 3);


insert into screening (date_n_time, status, theater_id, movie_id, hall_id) VALUES (TO_DATE('2021/12/19 17:20:00', 'yyyy/mm/dd hh24:mi:ss'), 'RUNNING', 21, 22, 6);
insert into screening (date_n_time, status, theater_id, movie_id, hall_id) VALUES (TO_DATE('2021/12/19 18:10:00', 'yyyy/mm/dd hh24:mi:ss'), 'RUNNING', 21, 24, 7);

insert into screening (date_n_time, status, theater_id, movie_id, hall_id) VALUES (TO_DATE('2021/12/18 16:40:00', 'yyyy/mm/dd hh24:mi:ss'), 'RUNNING', 41, 22, 21);
insert into screening (date_n_time, status, theater_id, movie_id, hall_id) VALUES (TO_DATE('2021/12/18 20:30:00', 'yyyy/mm/dd hh24:mi:ss'), 'RUNNING', 41, 22, 21);

insert into screening (date_n_time, status, theater_id, movie_id, hall_id) VALUES (TO_DATE('2021/12/19 18:10:00', 'yyyy/mm/dd hh24:mi:ss'), 'RUNNING', 24, 22, 22);

alter session set nls_date_format = 'YYYY-MON-DD HH24:MI:SS';

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE  user_account(
    user_id NUMBER GENERATED BY DEFAULT AS IDENTITY,
    email_id VARCHAR2(256) NOT NULL UNIQUE,
    password VARCHAR2(30) NOT NULL,
    first_name VARCHAR2(50) NOT NULL,
    last_name VARCHAR2(50) NOT NULL,
    phone_number VARCHAR2(20) NOT NULL,
    age NUMBER NOT NULL,
    PRIMARY KEY (user_id)
);

--------------------------------------------------------------------------------

insert into user_account (email_id, password, first_name, last_name, phone_number, age) VALUES 
('Jamessmith234@gmail.com', 'ksjgno2i', 'James', 'Smith', '+48 745633441', 30);
insert into user_account (email_id, password, first_name, last_name, phone_number, age) VALUES 
('MariaGracia6211@gmail.com', 'kjb$*UNK9asf', 'Marcia', 'Gracia', '+48 726483922', 24);
insert into user_account (email_id, password, first_name, last_name, phone_number, age) VALUES 
('Gregorywilliams77@gmail.com', 'o5wijb%$sefg#', 'Gregory', 'Williams', '+48 835462854', 24);
insert into user_account (email_id, password, first_name, last_name, phone_number, age) VALUES 
('JasonBourne@gmail.com', 'sdg4dnr^#ae', 'Jason', 'Bourne', '+48 856452312', 32);
insert into user_account (email_id, password, first_name, last_name, phone_number, age) VALUES 
('Jamesbond007@gmail.com', 'shdbg12gy*#hgfvh', 'James', 'Bond', '+48 7354586749', 34);
insert into user_account (email_id, password, first_name, last_name, phone_number, age) VALUES 
('OliviaBenjamin2342@gmail.com', 'sfgn8isbbg2#', 'Olivia', 'Benjamin', '+48 786746202', 26);
insert into user_account (email_id, password, first_name, last_name, phone_number, age) VALUES 
('Emmanoah555@gmail.com', 'oisrgon#23nj', 'Emma', 'Noah', '+48 7903148254', 23);
insert into user_account (email_id, password, first_name, last_name, phone_number, age) VALUES 
('CarlSmith532@gmail.com', 'skjgb#kj@134', 'Carl', 'Smith', '+48 8393817033', 25);


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE promotion(
    promotion_id NUMBER GENERATED BY DEFAULT AS IDENTITY,
    title VARCHAR2(200),
    availabile VARCHAR2(1),
    valid VARCHAR2(1),
    
    PRIMARY KEY (promotion_id)
);   

--------------------------------------------------------------------------------

ALTER TABLE promotion ADD details VARCHAR(500) NOT NULL;

ALTER TABLE promotion RENAME COLUMN availabile TO available;

--------------------------------------------------------------------------------

insert into promotion (title, details, available, valid) VALUES 
('Allegro Smart Student', 'You have Allegro Smart active! Student? Excellent! This is one of Allegros partners. Thanks to this, in addition to the basic benefits under Allegro Smart! 
students are entitled to additional benefits in the cinemas of the Multikino network. You can redeem them using special codes generated in the Allegro application.','Y', 'Y');
insert into promotion (title, details, available, valid) VALUES 
('Family Card To The Movies', 'Bar sets and film gadgets at a promotional price and many other attractions - with the Family to the Cinema card you can do more! 
We invite you to take advantage of our latest offer perfectly tailored to the needs of families who love trips to the cinema with their loved ones!', 'Y', 'N');
insert into promotion (title, details, available, valid) VALUES 
('Experience Priceless Moments with Mastercard', 'We are a partner of the Mastercard program, a new version of the Priceless Specials program, in which your life passions count, 
and each payment with a Mastercard card brings you closer to your goal, i.e. the selected award.', 'Y', 'Y');
insert into promotion (title, details, available, valid) VALUES 
('Payback', 'PAYBACK - is the largest multipartner Bonus Program in Poland. Its idea is very simple, during everyday purchases at the Program partners, you show the PAYBACK card or application
and collect points that you can easily exchange for purchases or prizes. We are one of over  400 PAYBACK partners !', 'N', 'N');

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE reservation(
    reservation_id NUMBER GENERATED BY DEFAULT AS IDENTITY,
    total_price NUMBER NOT NULL,
    amount_paid NUMBER NOT NULL,
    active VARCHAR2(1),
    
    screening_id NUMBER NOT NULL,
    hall_id NUMBER NOT NULL,
    user_id NUMBER NOT NULL,
    promotion_id NUMBER NOT NULL,
    
    PRIMARY KEY (reservation_id),
    FOREIGN KEY (screening_id) references screening(screening_id),
    FOREIGN KEY (hall_id) references hall(hall_id),
    FOREIGN KEY (user_id) references user_account(user_id),
    FOREIGN KEY (promotion_id) references promotion(promotion_id)
);

--------------------------------------------------------------------------------

ALTER TABLE reservation 
modify(
    promotion_id NUMBER NULL
);

--------------------------------------------------------------------------------

insert into reservation (total_price, amount_paid, active, screening_id, hall_id, user_id, promotion_id) VALUES
(50.80, 50.80, 'Y', 2, 2, 1, NULL);
insert into reservation (total_price, amount_paid, active, screening_id, hall_id, user_id, promotion_id) VALUES
(76.20, 76.20, 'Y', 3, 2, 2, NULL);
insert into reservation (total_price, amount_paid, active, screening_id, hall_id, user_id, promotion_id) VALUES
(24.50, 24.50, 'Y', 6, 3, 3, NULL);

insert into reservation (total_price, amount_paid, active, screening_id, hall_id, user_id, promotion_id) VALUES
(10.80, 10.80, 'Y', 7, 6, 6, NULL);
insert into reservation (total_price, amount_paid, active, screening_id, hall_id, user_id, promotion_id) VALUES
(5.40, 5.40, 'Y', 7, 6, 7, NULL);

insert into reservation (total_price, amount_paid, active, screening_id, hall_id, user_id, promotion_id) VALUES
(117, 117, 'Y', 21, 21, 4, NULL);
insert into reservation (total_price, amount_paid, active, screening_id, hall_id, user_id, promotion_id) VALUES
(46.8, 46.8, 'Y', 21, 21, 5, NULL);

insert into reservation (total_price, amount_paid, active, screening_id, hall_id, user_id, promotion_id) VALUES
(23.40, 23.40, 'Y', 23, 22, 21, NULL);




insert into reservation (total_price, amount_paid, active, screening_id, hall_id, user_id, promotion_id) VALUES
(23.40, 23.40, 'Y', 23, 22, 21, NULL);

insert into reservation (total_price, amount_paid, active, screening_id, hall_id, user_id, promotion_id) VALUES
(25.40, 25.40, 'Y', 23, 22, 21, NULL);

UPDATE reservation 
SET total_price = 46.8, amount_paid = 46.8
WHERE reservation_id = 61;

    





--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE seat_reserved(
    seat_id NUMBER NOT NULL,
    reservation_id NUMBER NOT NULL,
    active VARCHAR2(1) NOT NULL,
    CONSTRAINT pk_seat_reserved PRIMARY KEY (seat_id, reservation_id),
    CONSTRAINT fk_seat_id FOREIGN KEY (seat_id) references seat(seat_id),
    CONSTRAINT fk_reservation_id FOREIGN KEY (reservation_id) references reservation(reservation_id)
    
);

--------------------------------------------------------------------------------

insert into seat_reserved (seat_id, reservation_id, active) VALUES (31, 1, 'Y');
insert into seat_reserved (seat_id, reservation_id, active) VALUES (32, 1, 'Y');

insert into seat_reserved (seat_id, reservation_id, active) VALUES (29, 2, 'Y');
insert into seat_reserved (seat_id, reservation_id, active) VALUES (30, 2, 'Y');
insert into seat_reserved (seat_id, reservation_id, active) VALUES (31, 2, 'Y');

insert into seat_reserved (seat_id, reservation_id, active) VALUES (22, 3, 'Y');

insert into seat_reserved (seat_id, reservation_id, active) VALUES (36, 4, 'Y');
insert into seat_reserved (seat_id, reservation_id, active) VALUES (37, 4, 'Y');

insert into seat_reserved (seat_id, reservation_id, active) VALUES (38, 5, 'Y');

insert into seat_reserved (seat_id, reservation_id, active) VALUES (61, 21, 'Y');
insert into seat_reserved (seat_id, reservation_id, active) VALUES (62, 21, 'Y');
insert into seat_reserved (seat_id, reservation_id, active) VALUES (63, 21, 'Y');
insert into seat_reserved (seat_id, reservation_id, active) VALUES (64, 21, 'Y');
insert into seat_reserved (seat_id, reservation_id, active) VALUES (65, 21, 'Y');


insert into seat_reserved (seat_id, reservation_id, active) VALUES (66, 22, 'Y');
insert into seat_reserved (seat_id, reservation_id, active) VALUES (67, 22, 'Y');

insert into seat_reserved (seat_id, reservation_id, active) VALUES (69, 23, 'Y');

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE actions_performed(
    action_id NUMBER GENERATED BY DEFAULT AS IDENTITY,
    table_name VARCHAR2(100),
    specified_action VARCHAR2(50),
    by_user VARCHAR2(50),
    action_performed_date DATE,
    PRIMARY KEY(action_id)
);

--------------------------------------------------------------------------------

CREATE OR REPLACE TRIGGER reservation_action_trigger
AFTER 
INSERT OR UPDATE OR DELETE
ON reservation
FOR EACH ROW
DECLARE
specified_action_name VARCHAR2(50);
BEGIN

specified_action_name := CASE
WHEN INSERTING THEN 'INSERT'
WHEN UPDATING THEN 'UPDATE'
WHEN DELETING THEN 'DELETE'
END;

INSERT INTO actions_performed (table_name, specified_action, by_user, action_performed_date) VALUES ('RESERVATION', specified_action_name, USER, SYSDATE);
END;



--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- INNER JOIN
SELECT theater.name, city.name
FROM city
INNER JOIN theater
ON city.city_id = theater.city_id;

--------------------------------------------------------------------------------
-- LEFT JOIN
SELECT city.name, theater.name
FROM city
LEFT OUTER JOIN theater
ON city.city_id = theater.city_id;

--------------------------------------------------------------------------------
-- RIGHT JOIN
SELECT theatering_movies.premiere, movie.name
FROM theatering_movies
RIGHT OUTER JOIN movie
ON movie.movie_id = theatering_movies.movie_id;

--------------------------------------------------------------------------------
-- FULL OUTER JOIN
SELECT movie.name, news.title, news.posted_by, news.news_date
FROM movie
FULL OUTER JOIN news
ON movie.movie_id = news.movie_id;
--------------------------------------------------------------------------------
-- CROSS JOIN
--SELECT city.name, theater.name
--FROM city
--CROSS JOIN theater;

--------------------------------------------------------------------------------
-- SUM, MAX, MIN, AVG
SELECT SUM(ticket_price), MAX(ticket_price), MIN(ticket_price), AVG(ticket_price)
FROM theatering_movies WHERE theatering_movies.currency = 'PLN';

--------------------------------------------------------------------------------

-- GROUP BY
SELECT screening.theater_id, SUM(reservation.amount_paid)
FROM screening
INNER JOIN reservation
ON screening.screening_id = reservation.screening_id
GROUP BY screening.theater_id;



--------------------------------------------------------------------------------

-- GROUP BY
SELECT theatering_movies.theater_id, theatering_movies.currency
FROM theatering_movies
INNER JOIN screening
ON theatering_movies.theater_id = screening.theater_id
GROUP BY theatering_movies.currency, theatering_movies.theater_id;

--------------------------------------------------------------------------------

-- ORDER BY, HAVING
SELECT movie.name, movie.genre, movie.rating
FROM movie 
GROUP BY movie.name, movie.genre, movie.rating
HAVING movie.rating > 7
ORDER BY movie.rating DESC;

--------------------------------------------------------------------------------


SELECT A1.name, SUM(B1.amount_paid)MONEY_COLLECTED, A1.currency
FROM(
SELECT theater.theater_id, theater.name, theatering_movies.currency
FROM theater
INNER JOIN theatering_movies
ON theater.theater_id = theatering_movies.theater_id
GROUP BY theater.name, theatering_movies.currency, theater.theater_id) A1
INNER JOIN(
SELECT distinct screening.theater_id, reservation.amount_paid
FROM screening
INNER JOIN reservation
ON screening.screening_id = reservation.screening_id
--GROUP BY screening.theater_id, reservation.amount_paid) B1
ON A1.theater_id = B1.theater_id 
GROUP BY A1.name, A1.currency;


--------------------------------------------------------------------------------


SELECT A1.theater_id, B1.name, SUM(A1.amount_paid)
FROM(
SELECT screening.theater_id, reservation.amount_paid
FROM screening
INNER JOIN reservation
ON screening.screening_id = reservation.screening_id 
GROUP BY screening.theater_id, reservation.amount_paid) A1
INNER JOIN theater B1
ON A1.theater_id = B1.theater_id 
GROUP BY B1.name, A1.theater_id
HAVING SUM(A1.amount_paid) > 100
ORDER BY SUM(A1.amount_paid) DESC;


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--SELECT screening.theater_id, SUM(reservation.amount_paid), theatering_movies.currency
--FROM theatering_movies 
--INNER JOIN(

--SELECT screening.theater_id, SUM(reservation.amount_paid)
--FROM reservation
--INNER JOIN screening
--ON reservation.screening_id = screening.screening_id
--GROUP BY screening.theater_id; --)

--ON screening.theater_id = theatering_movies.theater_id 
--GROUP BY screening.theater_id, theatering_movies.currency;


--------------------------------------------------------------------------------
--SELECT screening.theater_id, SUM(reservation.amount_paid)
--FROM screening
--INNER JOIN reservation
--ON screening.screening_id = reservation.screening_id 
--GROUP BY screening.theater_id
--HAVING SUM(reservation.amount_paid) > 100
--ORDER BY SUM(reservation.amount_paid) DESC;

--------------------------------------------------------------------------------

--SELECT screening.theater_id, reservation.amount_paid
--FROM screening
--INNER JOIN reservation
--ON screening.screening_id = reservation.screening_id
--GROUP BY screening.theater_id, reservation.amount_paid;

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

--scriptSQL_DINU_ANDREEA_VIOLETA_GR261
--BIBLIOTECA

--crearea tabelului CITITOR

CREATE TABLE CITITOR(
CNP VARCHAR(13)
    CONSTRAINT CITITOR_CNP_PK PRIMARY KEY
    CONSTRAINT CITITOR_CNP_C CHECK (LENGTH(CNP)=13),
nume VARCHAR(30)
    CONSTRAINT CITITOR_nume_NN NOT NULL,
prenume VARCHAR(30)
    CONSTRAINT CITITOR_prenume_NN NOT NULL,
data_nastere DATE
    CONSTRAINT CITITOR_datanastere_NN NOT NULL,
nr_telefon VARCHAR2(10)
    CONSTRAINT CITITOR_nrtelefon_NN NOT NULL
    CONSTRAINT CITITOR_nrtelefon_C CHECK (LENGTH(nr_telefon)=10)
    CONSTRAINT CITITOR_nrtelefon_U UNIQUE
);

--crearea tabelului EDITURA

CREATE TABLE EDITURA(
id_editura NUMBER(4)
	CONSTRAINT EDITURA_ideditura_PK PRIMARY KEY,
nume VARCHAR2(30)
	CONSTRAINT EDITURA_nume_NN NOT NULL,
oras VARCHAR(15)
	CONSTRAINT EDITURA_oras_NN NOT NULL,
strada VARCHAR(15)
	CONSTRAINT EDITURA_strada_NN NOT NULL,
nr_telefon VARCHAR(10)
	CONSTRAINT EDITURA_nrtelefon_NN NOT NULL
	CONSTRAINT EDITURA_nrtelefon_C CHECK (LENGTH(nr_telefon)=10)
	CONSTRAINT EDITURA_nrtelefon_U UNIQUE,
email VARCHAR(15)
	CONSTRAINT EDITURA_email_NN NOT NULL
	CONSTRAINT EDITURA_email_U UNIQUE
);
CREATE SEQUENCE EDITURA_ideditura_SEQ 
START WITH 1000
INCREMENT BY  1;


--crearea tabelului SALA_LECTURA

CREATE TABLE SALA_LECTURA(
numar_sala NUMBER(2)
	CONSTRAINT SALA_LECTURA_PK PRIMARY KEY,
numar_locuri NUMBER(2)
	CONSTRAINT SALA_numarlocuri_NN NOT NULL
);



--crearea tabelului SECTIUNE

CREATE TABLE SECTIUNE(
	id_sectiune NUMBER(4)
		CONSTRAINT SECTIUNE_idsectiune_PK PRIMARY KEY,
	nume_domeniu VARCHAR2(15)
		CONSTRAINT SECTIUNE_numedomeniu_NN NOT NULL,
	numar_sala NUMBER(2)
        CONSTRAINT SECTIUNE_numarsala_NN NOT NULL
		CONSTRAINT SECTIUNE_numarsala_FK REFERENCES SALA_LECTURA(numar_sala) ON DELETE CASCADE,
	nr_raft NUMBER(2)
		CONSTRAINT SECTIUNE_nrraft_NN NOT NULL,
    nr_rand NUMBER(2)
		CONSTRAINT SECTIUNE_nrrand_NN NOT NULL
);
CREATE SEQUENCE SECTIUNE_idsectiune_SEQ 
START WITH 2000
INCREMENT BY  1;


--crearea tabelului CARTE

CREATE TABLE CARTE(
serie NUMBER(4)
		CONSTRAINT CARTE_serie_PK PRIMARY KEY,
titlu VARCHAR2(15)
		CONSTRAINT CARTE_titlu_NN NOT NULL,
id_sectiune NUMBER(4)
		CONSTRAINT CARTE_idsectiune_FK REFERENCES SECTIUNE(id_sectiune) ON DELETE SET NULL,
id_editura NUMBER(4)
		CONSTRAINT  CARTE_ideditura_FK REFERENCES EDITURA(id_editura) ON DELETE CASCADE
		CONSTRAINT CARTE_ideditura_NN NOT NULL,
nr_pagini NUMBER(4)
        CONSTRAINT CARTE_nrpagini_NN NOT NULL,
an_publicare NUMBER(4)
        CONSTRAINT CARTE_anpublicare_NN NOT NULL
);

CREATE SEQUENCE CARTE_serie_SEQ
START WITH 1000
INCREMENT BY  1;



--crearea tabelului FISA_IMPRUMUT

CREATE TABLE FISA_IMPRUMUT(

CNP VARCHAR(13)
	CONSTRAINT FISA_IMPR_CNP_FK REFERENCES CITITOR(CNP) ON DELETE CASCADE,
serie NUMBER(4)
	CONSTRAINT FISA_IMPR_serie_FK REFERENCES CARTE(serie) ON DELETE CASCADE,
data_imprumut DATE
	CONSTRAINT FISA_dataimprumut_NN NOT NULL,
data_returnare DATE,
CONSTRAINT FISA_IMPR_PK PRIMARY KEY (CNP,serie) 
);




--crearea tabelului AUTOR

CREATE TABLE AUTOR (
id_autor NUMBER(4)
	CONSTRAINT AUTOR_idautor_PK PRIMARY KEY,
nume VARCHAR(30)
	CONSTRAINT AUTOR_nume_NN NOT NULL,
prenume VARCHAR(30)
	CONSTRAINT AUTOR_prenume_NN NOT NULL,
data_nastere DATE
	CONSTRAINT AUTOR_datanastere_NN NOT NULL
);
CREATE SEQUENCE AUTOR_serie_SEQ
START WITH 1
INCREMENT BY  1;

--crearea tabelului SCRIS

CREATE TABLE SCRIS (
serie NUMBER(4)
	CONSTRAINT SCRIS_serie_FK REFERENCES CARTE(serie) ON DELETE CASCADE,
id_autor NUMBER(4)
	CONSTRAINT SCRIS_idautor_FK REFERENCES AUTOR(id_autor) ON DELETE CASCADE,
an_finalizare NUMBER(4),
CONSTRAINT SCRIS_PK PRIMARY KEY (serie,id_autor)
);

--crearea tabelului ROL

CREATE TABLE ROL(
id_rol NUMBER(4)
	CONSTRAINT ROL_idrol_PK PRIMARY KEY,
titlu_rol VARCHAR2(15)
	CONSTRAINT ROL_titlurol_NN NOT NULL,
max_sal NUMBER(4)
	CONSTRAINT ROL_maxsal_NN NOT NULL,
min_sal NUMBER(4)
	CONSTRAINT ROL_minsal_NN NOT NULL
);
CREATE SEQUENCE ROL_idrol_SEQ
START WITH 1
INCREMENT BY  1;

--crearea tabelului ANGAJAT

CREATE TABLE ANGAJAT (
id_angajat NUMBER(4)
	CONSTRAINT ANGAJAT_idangajat_PK PRIMARY KEY,
nume VARCHAR2(30)
	CONSTRAINT ANGAJAT_nume_NN NOT NULL,
prenume VARCHAR2(30)
	CONSTRAINT ANGAJAT_prenume_NN NOT NULL,
data_nastere DATE
 	CONSTRAINT ANGAJAT_datanastere_NN NOT NULL,
data_angajarii DATE 
	CONSTRAINT ANGAJAT_dataangajarii_NN NOT NULL,
telefon VARCHAR2(10)
	CONSTRAINT ANGAJAT_telefon_NN NOT NULL
	CONSTRAINT ANGAJAT_telefon_U UNIQUE
	CONSTRAINT ANGAJAT_telefon_C CHECK (LENGTH(telefon)=10),
id_rol NUMBER(4)
	CONSTRAINT ANGAJAT_idrol_FK REFERENCES ROL(id_rol) ON DELETE CASCADE
	CONSTRAINT ANGAJAT_idrol_NN NOT NULL,
numar_sala NUMBER(4)
	CONSTRAINT ANGAJAT_numarsala_FK REFERENCES SALA_LECTURA(numar_sala) ON DELETE CASCADE
	CONSTRAINT ANGAJAT_numarsala_NN NOT NULL
);

CREATE SEQUENCE ANGAJAT_idangajat_SEQ
START WITH 3000
INCREMENT BY  1;

--inserare date in tabelul CITITOR
INSERT INTO CITITOR (CNP, nume, prenume, data_nastere, nr_telefon) VALUES 
('2950603291234', 'Micu', 'Adriana', TO_DATE('03-06-1995', 'DD-MM-YYYY'), '0725463995');
INSERT INTO CITITOR (CNP, nume, prenume, data_nastere, nr_telefon) VALUES 
('1991203291335', 'Dima', 'Marian', TO_DATE('03-12-1999', 'DD-MM-YYYY'), '0723473975');
INSERT INTO CITITOR (CNP, nume, prenume, data_nastere, nr_telefon) VALUES 
('5001011291437', 'Craciun', 'Adelin', TO_DATE('11-10-2000', 'DD-MM-YYYY'), '0721174995');
INSERT INTO CITITOR (CNP, nume, prenume, data_nastere, nr_telefon) VALUES 
('6021120291739', 'Iacob', 'Crina', TO_DATE('20-11-2002', 'DD-MM-YYYY'), '0721173335');
INSERT INTO CITITOR (CNP, nume, prenume, data_nastere, nr_telefon) VALUES 
('1871222291741', 'Dumitrescu', 'Ion', TO_DATE('22-12-1978', 'DD-MM-YYYY'), '0721444435');
INSERT INTO CITITOR (CNP, nume, prenume, data_nastere, nr_telefon) VALUES 
('1881214291741', 'Ion', 'Mihai', TO_DATE('14-12-1988', 'DD-MM-YYYY'), '0712345435');
INSERT INTO CITITOR (CNP, nume, prenume, data_nastere, nr_telefon) VALUES 
('2960315292756', 'Pavel', 'Maria', TO_DATE('15-03-1996', 'DD-MM-YYYY'), '0712345123');
INSERT INTO CITITOR (CNP, nume, prenume, data_nastere, nr_telefon) VALUES 
('1851201291743', 'Crin', 'Andrei', TO_DATE('01-12-1985', 'DD-MM-YYYY'), '0778945435');
INSERT INTO CITITOR (CNP, nume, prenume, data_nastere, nr_telefon) VALUES 
('2930904291461', 'Iris', 'Mihaela', TO_DATE('04-09-1993', 'DD-MM-YYYY'), '0712349631');
INSERT INTO CITITOR (CNP, nume, prenume, data_nastere, nr_telefon) VALUES 
('5040904291321', 'Florea', 'Evelin', TO_DATE('04-09-2004', 'DD-MM-YYYY'), '0712354631');


--inserare date in tabelul EDITURA
INSERT INTO EDITURA(id_editura, nume, oras, strada, nr_telefon, email) VALUES
(EDITURA_ideditura_SEQ.NEXTVAL,'Corint','Bucuresti','Mihai Eminescu','0737555999','cedit@gmail.com');
INSERT INTO EDITURA(id_editura, nume, oras, strada, nr_telefon, email) VALUES
(EDITURA_ideditura_SEQ.NEXTVAL,'Hyperion','Craiova','Florilor','0737123456','hyper@gmail.com');
INSERT INTO EDITURA(id_editura, nume, oras, strada, nr_telefon, email) VALUES
(EDITURA_ideditura_SEQ.NEXTVAL,'Bookzone','Bucuresti','Sos. Berceni','0744423456','bzone@gmail.com');
INSERT INTO EDITURA(id_editura, nume, oras, strada, nr_telefon, email) VALUES
(EDITURA_ideditura_SEQ.NEXTVAL,'Polirom','Iasi','Bd. Copou','0744423555','polir@gmail.com');
INSERT INTO EDITURA(id_editura, nume, oras, strada, nr_telefon, email) VALUES
(EDITURA_ideditura_SEQ.NEXTVAL,'Litera','Bucuresti','Moeciu','0744141792','ledit@gmail.com');
INSERT INTO EDITURA(id_editura, nume, oras, strada, nr_telefon, email) VALUES
(EDITURA_ideditura_SEQ.NEXTVAL,'Carminis','Pitesti','Exercitiu','0736641122','carmi@gmail.com');

--inserare date in tabelul SALA_LECTURA
INSERT INTO SALA_LECTURA(numar_sala,numar_locuri) VALUES(1,12);
INSERT INTO SALA_LECTURA(numar_sala,numar_locuri) VALUES (2,20);
INSERT INTO SALA_LECTURA(numar_sala,numar_locuri) VALUES (3,15);
INSERT INTO SALA_LECTURA(numar_sala,numar_locuri) VALUES (4,25);
INSERT INTO SALA_LECTURA(numar_sala,numar_locuri) VALUES (5,10);


--inserare date in tabelul SECTIUNE

INSERT INTO SECTIUNE(id_sectiune, nume_domeniu, numar_sala, nr_raft, nr_rand)VALUES
(SECTIUNE_idsectiune_SEQ.NEXTVAL,'Istorie',1,2,1);
INSERT INTO SECTIUNE(id_sectiune, nume_domeniu, numar_sala, nr_raft, nr_rand)VALUES
(SECTIUNE_idsectiune_SEQ.NEXTVAL,'Geografie',2,3,2);
INSERT INTO SECTIUNE(id_sectiune, nume_domeniu, numar_sala, nr_raft, nr_rand)VALUES
(SECTIUNE_idsectiune_SEQ.NEXTVAL,'Fictiune',3,2,1);
INSERT INTO SECTIUNE(id_sectiune, nume_domeniu, numar_sala, nr_raft, nr_rand)VALUES
(SECTIUNE_idsectiune_SEQ.NEXTVAL,'Non-fictiune',4,1,1);
INSERT INTO SECTIUNE(id_sectiune, nume_domeniu, numar_sala, nr_raft, nr_rand)VALUES
(SECTIUNE_idsectiune_SEQ.NEXTVAL,'Bibliografii',1,2,3);
INSERT INTO SECTIUNE(id_sectiune, nume_domeniu, numar_sala, nr_raft, nr_rand)VALUES
(SECTIUNE_idsectiune_SEQ.NEXTVAL,'Romance',3,3,1);
INSERT INTO SECTIUNE(id_sectiune, nume_domeniu, numar_sala, nr_raft, nr_rand)VALUES
(SECTIUNE_idsectiune_SEQ.NEXTVAL,'Matematica',5,1,1);



--inserare date in tabelul CARTE

INSERT INTO CARTE(serie, titlu, id_sectiune, id_editura, nr_pagini, an_publicare) VALUES
(CARTE_serie_SEQ.NEXTVAL, 'Atlas Europa',2001,1000,80,2013);
INSERT INTO CARTE(serie, titlu, id_sectiune, id_editura, nr_pagini, an_publicare) VALUES
(CARTE_serie_SEQ.NEXTVAL, 'Cartea Noptii',2002,1002,464,2022);
INSERT INTO CARTE(serie, titlu, id_sectiune, id_editura, nr_pagini, an_publicare) VALUES
(CARTE_serie_SEQ.NEXTVAL, 'Sapiens',2000,1004,384,2017);
INSERT INTO CARTE(serie, titlu, id_sectiune, id_editura, nr_pagini, an_publicare) VALUES
(CARTE_serie_SEQ.NEXTVAL, 'Atomic Habits',2003,1004,271,2019);
INSERT INTO CARTE(serie, titlu, id_sectiune, id_editura, nr_pagini, an_publicare) VALUES
(CARTE_serie_SEQ.NEXTVAL, 'Me before you',2005,1004,416,2016);
INSERT INTO CARTE(serie, titlu, id_sectiune, id_editura, nr_pagini, an_publicare) VALUES
(CARTE_serie_SEQ.NEXTVAL, 'Matematica M1',2006,1005,336,2006);


--inserare date in tabelul FISA_IMPRUMUT

INSERT INTO FISA_IMPRUMUT(CNP, serie, data_imprumut, data_returnare) VALUES
('2950603291234',1002,TO_DATE('10-12-2022', 'DD-MM-YYYY'),TO_DATE('06-01-2023', 'DD-MM-YYYY'));
INSERT INTO FISA_IMPRUMUT(CNP, serie, data_imprumut, data_returnare) VALUES
('2950603291234',1003,TO_DATE('10-12-2022', 'DD-MM-YYYY'),TO_DATE('06-01-2023', 'DD-MM-YYYY'));
INSERT INTO FISA_IMPRUMUT(CNP, serie, data_imprumut, data_returnare) VALUES
('1991203291335',1000,TO_DATE('12-12-2022', 'DD-MM-YYYY'),TO_DATE('23-12-2022', 'DD-MM-YYYY'));
INSERT INTO FISA_IMPRUMUT(CNP, serie, data_imprumut, data_returnare) VALUES
('5001011291437',1002,TO_DATE('11-11-2022', 'DD-MM-YYYY'),TO_DATE('25-11-2022', 'DD-MM-YYYY'));
INSERT INTO FISA_IMPRUMUT(CNP, serie, data_imprumut, data_returnare) VALUES
('1881214291741',1002,TO_DATE('01-12-2022', 'DD-MM-YYYY'),TO_DATE('08-12-2022', 'DD-MM-YYYY'));
INSERT INTO FISA_IMPRUMUT(CNP, serie, data_imprumut, data_returnare) VALUES
('5040904291321',1000,TO_DATE('07-01-2023', 'DD-MM-YYYY'),TO_DATE('07-01-2023', 'DD-MM-YYYY'));
INSERT INTO FISA_IMPRUMUT(CNP, serie, data_imprumut, data_returnare) VALUES
('6021120291739',1000,TO_DATE('12-01-2023', 'DD-MM-YYYY'),NULL);
INSERT INTO FISA_IMPRUMUT(CNP, serie, data_imprumut, data_returnare) VALUES
('1871222291741',1005,TO_DATE('03-10-2022', 'DD-MM-YYYY'),TO_DATE('20-11-2022', 'DD-MM-YYYY'));
INSERT INTO FISA_IMPRUMUT(CNP, serie, data_imprumut, data_returnare) VALUES
('2960315292756',1004,TO_DATE('12-02-2022', 'DD-MM-YYYY'),TO_DATE('20-02-2022', 'DD-MM-YYYY'));
INSERT INTO FISA_IMPRUMUT(CNP, serie, data_imprumut, data_returnare) VALUES
('1851201291743',1004,TO_DATE('01-02-2022', 'DD-MM-YYYY'),TO_DATE('5-02-2022', 'DD-MM-YYYY'));
INSERT INTO FISA_IMPRUMUT(CNP, serie, data_imprumut, data_returnare) VALUES
('2930904291461',1003,TO_DATE('17-04-2022', 'DD-MM-YYYY'),TO_DATE('25-04-2022', 'DD-MM-YYYY'));
INSERT INTO FISA_IMPRUMUT(CNP, serie, data_imprumut, data_returnare) VALUES
('2930904291461',1005,TO_DATE('26-05-2022', 'DD-MM-YYYY'),TO_DATE('29-05-2022', 'DD-MM-YYYY'));


--inserare date in tabelul AUTOR

INSERT INTO AUTOR(id_autor, nume, prenume, data_nastere) VALUES
(AUTOR_serie_SEQ.NEXTVAL,'Mandrut', 'Octavian', TO_DATE('15-01-1960', 'DD-MM-YYYY'));
INSERT INTO AUTOR(id_autor, nume, prenume, data_nastere) VALUES
(AUTOR_serie_SEQ.NEXTVAL,'Black', 'Holly', TO_DATE('10-11-1971', 'DD-MM-YYYY'));
INSERT INTO AUTOR(id_autor, nume, prenume, data_nastere) VALUES
(AUTOR_serie_SEQ.NEXTVAL,'Harari', 'Yuval Noah', TO_DATE('04-02-1976', 'DD-MM-YYYY'));
INSERT INTO AUTOR(id_autor, nume, prenume, data_nastere) VALUES
(AUTOR_serie_SEQ.NEXTVAL,'Clear', 'James', TO_DATE('22-01-1986', 'DD-MM-YYYY'));
INSERT INTO AUTOR(id_autor, nume, prenume, data_nastere) VALUES
(AUTOR_serie_SEQ.NEXTVAL,'Jojo', 'Moyes', TO_DATE('04-09-1969', 'DD-MM-YYYY'));
INSERT INTO AUTOR(id_autor, nume, prenume, data_nastere) VALUES
(AUTOR_serie_SEQ.NEXTVAL,'Burtea', 'Marius', TO_DATE('04-09-1965', 'DD-MM-YYYY'));
INSERT INTO AUTOR(id_autor, nume, prenume, data_nastere) VALUES
(AUTOR_serie_SEQ.NEXTVAL,'Burtea', 'Georgeta', TO_DATE('14-10-1966', 'DD-MM-YYYY'));


--inserare date in tabelul SCRIS

INSERT INTO SCRIS(serie, id_autor, an_finalizare) VALUES (1000,1,NULL);
INSERT INTO SCRIS(serie, id_autor, an_finalizare) VALUES (1001,2,NULL);
INSERT INTO SCRIS(serie, id_autor, an_finalizare) VALUES (1002,3,NULL);
INSERT INTO SCRIS(serie, id_autor, an_finalizare) VALUES (1005,6,2006);
INSERT INTO SCRIS(serie, id_autor, an_finalizare) VALUES (1005,7,2006);

--inserare date in tabelul ROL
INSERT INTO ROL(id_rol, titlu_rol, max_sal, min_sal) VALUES
(ROL_idrol_SEQ.NEXTVAL, 'Bibliotecar',3500,1525);
INSERT INTO ROL(id_rol, titlu_rol, max_sal, min_sal) VALUES
(ROL_idrol_SEQ.NEXTVAL, 'Supraveghetor',2500,1525);
INSERT INTO ROL(id_rol, titlu_rol, max_sal, min_sal) VALUES
(ROL_idrol_SEQ.NEXTVAL, 'Organizator',3000,1525);
INSERT INTO ROL(id_rol, titlu_rol, max_sal, min_sal) VALUES
(ROL_idrol_SEQ.NEXTVAL, 'Pers Curatenie',2000,1525);


--inserare date in tabelul ANGAJAT

INSERT INTO ANGAJAT(id_angajat, nume, prenume, data_nastere, data_angajarii, telefon, id_rol, numar_sala) VALUES
(ANGAJAT_idangajat_SEQ.NEXTVAL,'Mitu','Alina',TO_DATE('10-11-1971', 'DD-MM-YYYY'),TO_DATE('10-10-2010', 'DD-MM-YYYY'),'0734003145',1,1);
INSERT INTO ANGAJAT(id_angajat, nume, prenume, data_nastere, data_angajarii, telefon, id_rol, numar_sala) VALUES
(ANGAJAT_idangajat_SEQ.NEXTVAL,'Nita','Mariana',TO_DATE('12-02-1970', 'DD-MM-YYYY'),TO_DATE('05-07-2020', 'DD-MM-YYYY'),'0723400321',2,1);
INSERT INTO ANGAJAT(id_angajat, nume, prenume, data_nastere, data_angajarii, telefon, id_rol, numar_sala) VALUES
(ANGAJAT_idangajat_SEQ.NEXTVAL,'Popa','Catalin',TO_DATE('17-06-1990', 'DD-MM-YYYY'),TO_DATE('12-03-2021', 'DD-MM-YYYY'),'0713400925',3,1);
INSERT INTO ANGAJAT(id_angajat, nume, prenume, data_nastere, data_angajarii, telefon, id_rol, numar_sala) VALUES
(ANGAJAT_idangajat_SEQ.NEXTVAL,'Calin','Mihaela',TO_DATE('16-12-1985', 'DD-MM-YYYY'),TO_DATE('14-08-2022', 'DD-MM-YYYY'),'0723410321',4,1);
INSERT INTO ANGAJAT(id_angajat, nume, prenume, data_nastere, data_angajarii, telefon, id_rol, numar_sala) VALUES
(ANGAJAT_idangajat_SEQ.NEXTVAL,'Mihai','Andreea',TO_DATE('10-01-1981', 'DD-MM-YYYY'),TO_DATE('10-10-2016', 'DD-MM-YYYY'),'0734003149',1,2);
INSERT INTO ANGAJAT(id_angajat, nume, prenume, data_nastere, data_angajarii, telefon, id_rol, numar_sala) VALUES
(ANGAJAT_idangajat_SEQ.NEXTVAL,'Gica','Paul',TO_DATE('23-10-1979', 'DD-MM-YYYY'),TO_DATE('05-07-2021', 'DD-MM-YYYY'),'0723444321',2,2);
INSERT INTO ANGAJAT(id_angajat, nume, prenume, data_nastere, data_angajarii, telefon, id_rol, numar_sala) VALUES
(ANGAJAT_idangajat_SEQ.NEXTVAL,'Sovarel','Steliana',TO_DATE('19-05-1982', 'DD-MM-YYYY'),TO_DATE('12-03-2019', 'DD-MM-YYYY'),'0765400925',3,2);
INSERT INTO ANGAJAT(id_angajat, nume, prenume, data_nastere, data_angajarii, telefon, id_rol, numar_sala) VALUES
(ANGAJAT_idangajat_SEQ.NEXTVAL,'Dudu','Alexandra',TO_DATE('12-10-1990', 'DD-MM-YYYY'),TO_DATE('14-08-2022', 'DD-MM-YYYY'),'0723478921',4,2);
INSERT INTO ANGAJAT(id_angajat, nume, prenume, data_nastere, data_angajarii, telefon, id_rol, numar_sala) VALUES
(ANGAJAT_idangajat_SEQ.NEXTVAL,'Dumitru','Madalina',TO_DATE('10-08-1988', 'DD-MM-YYYY'),TO_DATE('10-10-2017', 'DD-MM-YYYY'),'0734034945',1,3);
INSERT INTO ANGAJAT(id_angajat, nume, prenume, data_nastere, data_angajarii, telefon, id_rol, numar_sala) VALUES
(ANGAJAT_idangajat_SEQ.NEXTVAL,'Alexandru','Erwin',TO_DATE('12-02-1994', 'DD-MM-YYYY'),TO_DATE('29-05-2021', 'DD-MM-YYYY'),'0723433321',2,3);
INSERT INTO ANGAJAT(id_angajat, nume, prenume, data_nastere, data_angajarii, telefon, id_rol, numar_sala) VALUES
(ANGAJAT_idangajat_SEQ.NEXTVAL,'Ilie','Flori',TO_DATE('17-11-1990', 'DD-MM-YYYY'),TO_DATE('12-03-2021', 'DD-MM-YYYY'),'0713147825',3,3);
INSERT INTO ANGAJAT(id_angajat, nume, prenume, data_nastere, data_angajarii, telefon, id_rol, numar_sala) VALUES
(ANGAJAT_idangajat_SEQ.NEXTVAL,'Grigore','Mihnea',TO_DATE('16-12-1977', 'DD-MM-YYYY'),TO_DATE('14-08-2022', 'DD-MM-YYYY'),'0732110321',4,3);
INSERT INTO ANGAJAT(id_angajat, nume, prenume, data_nastere, data_angajarii, telefon, id_rol, numar_sala) VALUES
(ANGAJAT_idangajat_SEQ.NEXTVAL,'Mihai','Daniela',TO_DATE('06-08-1991', 'DD-MM-YYYY'),TO_DATE('10-10-2018', 'DD-MM-YYYY'),'0734064745',1,4);
INSERT INTO ANGAJAT(id_angajat, nume, prenume, data_nastere, data_angajarii, telefon, id_rol, numar_sala) VALUES
(ANGAJAT_idangajat_SEQ.NEXTVAL,'Dan','Andrei',TO_DATE('25-02-1992', 'DD-MM-YYYY'),TO_DATE('29-05-2020', 'DD-MM-YYYY'),'0724723321',1,5);


commit


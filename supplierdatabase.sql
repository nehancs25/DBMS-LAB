DROP DATABASE IF EXISTS 1BM25CS198;
CREATE DATABASE 1BM25CS198;
USE 1BM25CS198;
CREATE TABLE SUPPLIERS(
SID INT PRIMARY KEY,
SNAME VARCHAR(30),
CITY VARCHAR(30)
);
CREATE TABLE PARTS(
PID INT PRIMARY KEY,
PNAME VARCHAR(30),
COLOR VARCHAR(20)
);
CREATE TABLE CATALOG(
SID INT,
PID INT,
COST INT,
PRIMARY KEY(SID,PID),
FOREIGN KEY (SID) REFERENCES SUPPLIERS(SID),
FOREIGN KEY (PID) REFERENCES PARTS(PID)
);
INSERT INTO SUPPLIERS VALUES
(10001,'Acme Widget Suppliers','Bangalore'), 
(10002,'Johns','Kolkata'),
(10003,'Vimal','Mumbai'),  
(10004,'Reliance','Delhi');
INSERT INTO PARTS VALUES
(20001,'Book','Red'), 
(20002,'Pen','Red'),
(20003,'Pencil','Green'),  
(20004,'Mobile','Green'),
(20005,'Charger','Black');
INSERT INTO CATALOG VALUES
(10001,20001,10),
(10001,20002,20),
(10001,20003,30),
(10001,20004,10),
(10001,20005,10),
(10002,20001,10),
(10002,20002,20),
(10003,20003,30),
(10004,20003,40);

SELECT DISTINCT P.PNAME
FROM PARTS P 
JOIN CATALOG C ON P.PID=C.PID;

SELECT S.SNAME
FROM SUPPLIERS S
WHERE NOT EXISTS(
SELECT P.PID
FROM PARTS P
WHERE NOT EXISTS(
SELECT C.PID
FROM CATALOG C
WHERE C.SID=S.SID
AND C.PID=P.PID
)
);
SELECT S.SNAME
FROM SUPPLIERS S
WHERE NOT EXISTS(
SELECT P.PID
FROM PARTS P                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
WHERE P.COLOR='Red'
AND NOT EXISTS(
SELECT C.PID
FROM CATALOG C
WHERE C.SID=S.SID
AND C.PID=P.PID
)
);

SELECT P.PNAME
FROM PARTS P
JOIN CATALOG C ON P.PID = C.PID
JOIN SUPPLIERS S ON C.SID = S.SID
WHERE S.SNAME = 'Acme Widget Suppliers'
AND NOT EXISTS (
    SELECT C2.PID
    FROM CATALOG C2
    WHERE C2.PID = P.PID
    AND C2.SID <> S.SID
);
SELECT DISTINCT C1.SID
FROM CATALOG C1
WHERE C1.COST>(
SELECT AVG (C2.COST)
FROM CATALOG C2
WHERE C2.PID=C1.PID
);
SELECT P.PNAME, S.SNAME, C1.COST
FROM CATALOG C1
JOIN PARTS P ON C1.PID=P.PID
JOIN SUPPLIERS S ON C1.SID=S.SID
WHERE C1.COST =(
SELECT MAX(C2.COST)
FROM CATALOG C2
WHERE C2.PID=C1.PID
);
SELECT P.PNAME, S.SNAME, C.COST
FROM SUPPLIERS S 
JOIN CATALOG C ON S.SID=C.SID
JOIN PARTS P ON C.PID=P.PID
WHERE C.COST=( SELECT MAX(COST) FROM CATALOG);

SELECT S.SNAME 
FROM SUPPLIERS S
WHERE NOT EXISTS(
SELECT * 
FROM CATALOG C
JOIN PARTS P ON C.PID=P.PID
WHERE C.SID=S.SID
AND P.COLOR='Red'
);

SELECT S.SNAME, SUM(C.COST) AS TOTAL_VALUE
FROM SUPPLIERS S 
LEFT JOIN CATALOG C ON S.SID=C.SID
GROUP BY S.SID, S.SNAME;   

SELECT S.SNAME  
FROM SUPPLIERS S 
JOIN CATALOG C ON S.SID=C.SID
WHERE C.COST<20
GROUP BY S.SID, S.SNAME
HAVING COUNT( DISTINCT C.PID)>=2 ;

SELECT P.PNAME, S.SNAME, C.COST
FROM SUPPLIERS S 
JOIN CATALOG C ON S.SID=C.SID
JOIN PARTS P ON C.PID=P.PID
WHERE C.COST=(
SELECT MIN(C2.COST)
FROM CATALOG C2
WHERE C2.PID=C.PID
);


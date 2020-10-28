/***********************************************************************************/
/*																			       */
/* Date				Programmer		Description									   */
/*---------------------------------------------------------------------------------*/
/* Oct 09, 2020		JSutherland		Initial implementation of Disk Inventory	   */
/* Oct 16, 2020		JSutherland		Added the data								   */
/* Oct 23, 2020		JSutherland		Project 4 started							   */
/* Oct 29, 2020		JSutherland		Project 5 started							   */
/***********************************************************************************/
--Create Database
USE master;
DROP DATABASE IF EXISTS disk_invJS;
GO
CREATE DATABASE disk_invJS;
GO
USE disk_invJS;

--Create Server Login/Database user
IF SUSER_ID ('diskUserJS') IS NULL
	CREATE LOGIN diskUserJS WITH PASSWORD = 'RIPEddieVanHalen2020!!', DEFAULT_DATABASE = disk_invJS;

DROP USER IF EXISTS diskUserJS;
CREATE USER diskUserJS;
ALTER ROLE db_datareader
	ADD MEMBER diskUserJS;
--Create tables
CREATE TABLE artist_type (
	artist_type_id	INT NOT NULL PRIMARY KEY IDENTITY,
	description		NVARCHAR(60) NOT NULL
);
CREATE TABLE disk_type (
	disk_type_id	INT NOT NULL PRIMARY KEY IDENTITY,
	description		NVARCHAR(60) NOT NULL
);
CREATE TABLE status (
	status_id		INT NOT NULL PRIMARY KEY IDENTITY,
	description		NVARCHAR(60) NOT NULL
);
CREATE TABLE genre (
	genre_id		INT NOT NULL PRIMARY KEY IDENTITY,
	description		NVARCHAR(60) NOT NULL
);
CREATE TABLE borrower (
	borrower_id		INT NOT NULL PRIMARY KEY IDENTITY,
	fname			NVARCHAR(60) NOT NULL,
	lname			NVARCHAR(60) NOT NULL,
	phone_num		VARCHAR(15) NOT NULL,
);
CREATE TABLE artist (
	artist_id		INT NOT NULL PRIMARY KEY IDENTITY,
	artist_name		NVARCHAR(60) NOT NULL,
	description		NVARCHAR(60) NOT NULL,
	artist_type_id	INT NOT NULL REFERENCES artist_type(artist_type_id)
);
CREATE TABLE disk (
	disk_id			INT NOT NULL PRIMARY KEY IDENTITY,
	disk_name		NVARCHAR(60) NOT NULL,
	release_date	DATE NOT NULL,
	genre_id		INT NOT NULL REFERENCES genre(genre_id),
	status_id		INT NOT NULL REFERENCES status(status_id),
	disk_type_id	INT NOT NULL REFERENCES disk_type(disk_type_id)
);
CREATE TABLE disk_has_borrower (
	borrower_id		INT NOT NULL REFERENCES borrower(borrower_id),
	disk_id			INT NOT NULL REFERENCES disk(disk_id),
	borrowed_date	DATE NOT NULL,
	returned_date	DATE,
	PRIMARY KEY (borrower_id, disk_id)
);
CREATE TABLE disk_has_artist(
	disk_id			INT NOT NULL REFERENCES disk(disk_id),
	artist_id		INT NOT NULL REFERENCES artist(artist_id),
	PRIMARY KEY (disk_id, artist_id)
);

-- Project 3 begins here
INSERT INTO disk_type (description)
VALUES ('CD'),
		('Vinyl'),
		('8Track'),
		('Cassette'),
		('DVD');

INSERT INTO artist_type (description)
VALUES ('Solo Artist'),
		('Band');

INSERT INTO genre (description)
VALUES 
	  ('Metal'),
	  ('Deathcore'),
	  ('Power Metal'),
	  ('Post-hardcore'),
	  ('Melodic Metal'),
	  ('Thrash Metal'),
	  ('Classic Rock'),
	  ('Funk Rock');
INSERT INTO genre (description)
VALUES 
	('Folk Metal');

--Status
INSERT status
Values ('Available');
INSERT status
Values ('On Loan');
INSERT status
Values ('Damaged');
INSERT status
Values ('Missing');

--Borrowers
INSERT borrower (fname, lname, phone_num)
VALUES ('Donald', 'Glover', '555-555-6052'),
		('Nathan','Explosion','555-555-9715'),
		('Daisy','Ridley','555-555-3497'),
		('John','Jonzz','555-555-5621'),
		('Samwise','Baggins','555-555-4215'),
		('Shrek','Ogreton','555-555-6675'),
		('Ozzy','Osborne','555-555-7584'),
		('Katy','NotPerry','555-555-1957'),
		('Ed','Edd','555-555-3345'),
		('James','Rolfe','555-555-8302'),
		('Jon','Tron','555-555-5216'),
		('Zakk','Wylde','555-555-3916'),
		('Herbie','Carr','555-555-2637'),
		('Mainus','Sheilberg','555-555-7090'),
		('BumBum','Fumpledin','555-555-1264'),
		('Schala','Potato','555-555-2503'),
		('Albus','Dundundun','555-555-2664'),
		('Smeagol','Hobbitses','555-555-9280'),
		('Leanamus','Articulus','555-555-7378'),
		('Cesars','Pizza','555-555-1069');
--Deleting a poor borrower for the grade
DELETE FROM [dbo].[borrower]
      WHERE borrower_id = 20;

--Artist (I'm designing this around the fact that every platform with music/dvd's considers bands/individuals as artists)
INSERT artist (artist_name, description, artist_type_id)
VALUES  ('Amigo the Devil','A man and his banjo',1),
		('Attila','Hard Band from Atlanta',2),
		('Brand of Sacrifice','Metal band from Canada',2),
		('Dance Gavin Dance','Mix of beautiful pop and metally metal',2),
		('A Day to Remember','One of the good things to come from Florida',2),
		('The Ghost Inside','Band from LA',2),
		('In Flames','Swedish band from the early 90s',2),
		('I Prevail','They did the cover of Blank Space',2),
		('Dethklok','Most metal reality show ever',2),
		('Red Hot Chili Peppers','Vibe with your best friends',2),
		('Sylosis','Personal favorite',2),
		('Dragonforce','Shreds for days',2),
		('Metallica','The Big cheese',2),
		('Slipknot','Just go hard',2),
		('Rings of Saturn','Alien like shreds that makes you want to learn guitar',2),
		('Distant','Just when you thought the breakdown was over',2),
		('System of a Down','Arguably the biggest influence in modern metal',2),
		('Suicide Silence','RIP Mitch',2),
		('Van Halen','RIP Eddie',2),
		('Shadow of Intent','Band from New England',2);

--Disk Table inserts
INSERT disk (disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES ('Everything is Fine','10/10/2018',9,1,1),
	('Pizza','5/25/2018',4,2,1),
	('The Interstice','9/6/2018',2,1,1),
	('Artificial Selection','9/3/2018',4,2,1),
	('Common Courtesy','6/23/2013',1,1,1),
	('Dear Youth','6/15/2014',2,1,1),
	('I The Mask','1/25/2019',1,2,1),	--7
	('Blank Space','3/19/2014',1,2,3),	--8
	('Metalocalypse Season 1','10/12/2010',1,4,4),
	('Stadium Arcadium','9/26/2006',8,1,1),
	('Cycle of Suffering','1/28/2020',5,2,1), --11
	('Inhuman Rampage','6/19/2006',3,1,1),
	('Metallica Through the Never','6/6/2013',1,1,4),
	('We Are Not Your Kind','8/19/2019',1,2,1), --14
	('Dingir','3/29/2013',2,1,1),
	('Tyrannotophia','1/1/2019',2,1,1),
	('Toxicity','2/24/2001',1,1,1),
	('The Cleansing','5/5/2008',4,1,1),
	('Best of Volume 1','8/18/1996',7,3,1),
	('Melancholy','11/11/2019',2,2,1); --20

	--Update 1 disk row
	UPDATE disk
	SET release_date = '10/19/2018'
	WHERE disk_name='Everything is Fine';

	--Inserts to disk_has_borrower
	INSERT disk_has_borrower (borrower_id, disk_id, borrowed_date, returned_date)
	VALUES (1, 2, '1-29-2019','2-21-2019'),
			(2,4,'2-14-2019',NULL),
			(3,7,'1-26-2019','2-19-2020'),
			(4,8,'4-19-2020','5-1-2020'),
			(5,11,'1-29-2020',NULL),
			(6,14,'8-29-2020','9-25-2020'),
			(7,20,'10-29-2019',NULL);

	--disk has artist
	INSERT disk_has_artist (disk_id, artist_id)
	VALUES  (1,1),
			(2,2),
			(3,3),
			(4,4),
			(5,5),
			(6,6),
			(7,7),
			(8,8),
			(9,9),
			(10,10),
			(11,11),
			(12,12),
			(13,13),
			(14,14),
			(15,15),
			(16,16),
			(17,17),
			(18,18),
			(19,19),
			(20,20);

--project 4 starts here
--3. individual artists to a disk (join to disk_has_artist, and disk)
SELECT disk_name, release_date, artist_name
FROM artist
JOIN disk_has_artist 
ON disk_has_artist.artist_id = artist.artist_id
JOIN disk ON disk_has_artist.disk_id = disk.disk_id
WHERE artist_type_id = 1
ORDER BY disk_name DESC;

--4. create a view called View_Individual_Artist that shows the artists' names and not group names (All I have are artists, no fnames and lnames so idk how to show that sorry)
CREATE VIEW View_Individual_Artist 
AS 
SELECT artist_id, artist_type_id
FROM artist
WHERE artist_type_id = 1

--5. show the disks in your database and any associated group artists only. use the View_Individual_Artist view. (similar to 3)
SELECT disk_name, release_date, artist_name
FROM artist
JOIN disk_has_artist 
ON disk_has_artist.artist_id = artist.artist_id
JOIN disk ON disk.disk_id = disk_has_artist.disk_id
WHERE artist_type_id = 2
ORDER BY disk_name DESC;

--6. show the borrowed disks and who borrowed them.
SELECT fname AS First, lname AS Last, disk_name AS DiskName, borrowed_date AS BorrowedDate, release_date AS ReturnedDate
FROM borrower
JOIN disk_has_borrower ON disk_has_borrower.borrower_id = borrower.borrower_id
JOIN disk ON disk.disk_id = disk_has_borrower.disk_id
WHERE status_id = 2

--7. Show the number of times a disk has been borrowed
SELECT disk.disk_id, disk_name, count(*) AS 'Times Borrwed'
FROM DISK
JOIN disk_has_borrower ON disk.disk_id = disk_has_borrower.disk_id
GROUP BY disk.disk_id, disk_name
ORDER BY disk.disk_id
go

--8. Show the disks outstanding or on-loan and who has each disk.
SELECT disk_name AS DiskName, borrowed_date AS Borrowed, returned_date AS Returned, lname AS LastName            
FROM disk
JOIN disk_has_borrower ON disk_has_borrower.disk_id = disk.disk_id
JOIN borrower ON borrower.borrower_id = disk_has_borrower.borrower_id
WHERE returned_date IS NULL
GO

--Project 5 starts here
DROP PROC IF EXISTS sp_ins_disk;
GO
CREATE PROC sp_ins_disk
	@disk_name nvarchar(60), @release_date date, @genre_id int, @status_id int, @disk_type_id int
AS
BEGIN TRY
	INSERT disk (disk_name, release_date, genre_id, status_id, disk_type_id)
	VALUES (@disk_name, @release_date, @genre_id, @status_id, @disk_type_id)
END TRY
BEGIN CATCH
	PRINT 'An error occured.';
	PRINT 'Message: ' + CONVERT(varchar(200), ERROR_MESSAGE());
END CATCH
GO
GRANT EXEC sp_ins_disk TO diskUserJS		
GO
EXEC sp_ins_disk 'Countdown to Extinction', '7-20-1993', 1, 1, 1;
GO
EXEC sp_ins_disk 'Countdown to Extinction', '7-20-1993', 1, 1, NULL;
GO

--update disk stored procedure
DROP PROC IF EXISTS sp_upd_disk;
GO
CREATE PROC sp_upd_disk
	@disk_id int, @disk_name nvarchar(60), @release_date date, @genre_id int, @status_id int, @disk_type_id int
AS
BEGIN TRY
UPDATE [dbo].[disk]
   SET [disk_name] = @disk_name
      ,[release_date] = @release_date
      ,[genre_id] =  @genre_id
      ,[status_id] = @status_id
      ,[disk_type_id] = @disk_type_id
 WHERE disk_id = @disk_id
 END TRY
 BEGIN CATCH
	PRINT 'An error occured.';
	PRINT 'Message: ' + CONVERT(varchar(200), ERROR_MESSAGE());
END CATCH
GO
GRANT EXEC sp_upd_disk TO diskUserJS
GO
EXEC sp_upd_disk 21, 'Countdown to Extinction', '7-14-1993', 1, 1, 1;  --release date updates
GO
EXEC sp_upd_disk 21, 'Countdown to Extinction', '7-14-1993', 1, 1, NULL;
GO

--Create delete disk procedure
DROP PROC IF EXISTS sp_del_disk;
GO
CREATE PROC sp_del_disk
	@disk_id int
AS
BEGIN TRY
DELETE FROM [dbo].[disk]
      WHERE disk_id = @disk_id
END TRY
 BEGIN CATCH
	PRINT 'An error occured.';
	PRINT 'Message: ' + CONVERT(varchar(200), ERROR_MESSAGE());
END CATCH
GO
GRANT EXEC sp_del_disk TO diskUserJS
GO
EXEC sp_del_disk 21;
GO
EXEC sp_del_disk 'XXX';
GO
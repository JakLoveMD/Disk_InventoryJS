/***********************************************************************************/
/*																			       */
/* Date				Programmer		Description									   */
/*---------------------------------------------------------------------------------*/
/* Oct 09, 2020		JSutherland		Initial implementation of Disk Inventory	   */
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
	borrowed_date	DATETIME2 NOT NULL,
	returned_date	DATETIME2 NOT NULL,
	PRIMARY KEY (borrower_id, disk_id)
);
CREATE TABLE disk_has_artist(
	disk_id			INT NOT NULL REFERENCES disk(disk_id),
	artist_id		INT NOT NULL REFERENCES artist(artist_id),
	PRIMARY KEY (disk_id, artist_id)
);
USE `essentialmode`;

INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_mafia', 'mafia', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_mafia', 'mafia', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_mafia', 'mafia', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('mafia','mafia')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('mafia',0,'employee','employee',200,'{}','{}'),
	('mafia',1,'employee','employee2',400,'{}','{}'),
	('mafia',2,'employee','employee3',500,'{}','{}'),
	('mafia',3,'boss','Boss',800,'{}','{}')
;

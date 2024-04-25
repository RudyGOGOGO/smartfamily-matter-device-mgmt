USE dmt;

DROP TABLE dmt.account;
DROP TABLE dmt.profile;
DROP TABLE dmt.user;
DROP TABLE dmt.matter;
DROP TABLE dmt.device;
DROP TABLE dmt.matter_device;
DROP TABLE dmt.profile_device;

CREATE TABLE dmt.account (
	id INT AUTO_INCREMENT UNIQUE,
	account_id INT,
	ts TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY(account_id)
);

CREATE TABLE dmt.profile (
	id INT AUTO_INCREMENT UNIQUE,
	profile_id Int,
	name VARCHAR(255) NOT NULL,
	role VARCHAR(255) NOT NULL,
	PRIMARY KEY(profile_id)
);

CREATE TABLE dmt.user (
	id INT AUTO_INCREMENT UNIQUE,
	name VARCHAR(255),
	account_id INT,
	profile_id INT,
	password VARCHAR(255),
	PRIMARY KEY(name)
);

CREATE TABLE dmt.matter (
	id INT AUTO_INCREMENT UNIQUE,
	node_id INT UNIQUE,
	name VARCHAR(255),
	PRIMARY KEY(id),
	INDEX idx_node_id (node_id)
);

CREATE TABLE dmt.device (
	id INT AUTO_INCREMENT UNIQUE,
	device_id INT UNIQUE,
	name VARCHAR(255),
	status VARCHAR(255),
	location VARCHAR(255),
	PRIMARY KEY(id),
	INDEX idx_device_id (device_id)
);

CREATE TABLE dmt.matter_device (
	id INT AUTO_INCREMENT UNIQUE,
	node_id INT,
	device_id INT,
	PRIMARY KEY(node_id, device_id),
	INDEX idx_md_node_id (node_id),
	INDEX idx_md_device_id (device_id)
);

CREATE TABLE dmt.profile_device (
	id INT AUTO_INCREMENT UNIQUE,
	profile_id INT,
	device_id INT,
	node_id INT,
	access BOOLEAN,
	PRIMARY KEY(profile_id, device_id, node_id),
	INDEX idx_pd_profile_id (profile_id),
	INDEX idx_pd_device_id (device_id),
	INDEX idx_pd_node_id (node_id)
);


insert into dmt.account (account_id) values(1001);
insert into dmt.profile (profile_id, name, role) values(1001, 'Rudy', 'PARENT');
insert into dmt.profile (profile_id, name, role) values(1002, 'Grace', 'PARENT');
insert into dmt.profile (profile_id, name, role) values(1003, 'Enu', 'CHILD');
insert into dmt.profile (profile_id, name, role) values(1004, 'Ency', 'CHILD');
insert into dmt.user (name, account_id, profile_id, password) values('1001', 1001, 1001, '1001');
insert into dmt.user (name, account_id, profile_id, password) values('1002', 1001, 1002, '1002');
insert into dmt.user (name, account_id, profile_id, password) values('1003', 1001, 1003, '1003');
insert into dmt.user (name, account_id, profile_id, password) values('1004', 1001, 1004, '1004');
insert into dmt.matter (node_id, name) values(1001, 'M1001');
insert into dmt.matter (node_id, name) values(1002, 'M1002');
insert into dmt.device (device_id, name, status, location) values(1001, 'B1001', 'OFF', 'Main Bedroom');
insert into dmt.device (device_id, name, status, location) values(1002, 'B1002', 'OFF', 'Boy Bedroom');
insert into dmt.device (device_id, name, status, location) values(1003, 'B1003', 'OFF', 'Front Door');
insert into dmt.device (device_id, name, status, location) values(1004, 'B1004', 'OFF', 'Garage');
insert into dmt.device (device_id, name, status, location) values(1005, 'B1005', 'OFF', 'Basement');
insert into dmt.device (device_id, name, status, location) values(1006, 'B1006', 'OFF', 'Girl Bedroom');
insert into dmt.matter_device (node_id,device_id) values(1001, 1001);
insert into dmt.matter_device (node_id,device_id) values(1001, 1002);
insert into dmt.matter_device (node_id,device_id) values(1001, 1003);
insert into dmt.matter_device (node_id,device_id) values(1002, 1004);
insert into dmt.matter_device (node_id,device_id) values(1002, 1005);
insert into dmt.matter_device (node_id,device_id) values(1002, 1006);
insert into dmt.profile_device (profile_id,device_id,node_id,access) values(1001, 1001, 1001, true);
insert into dmt.profile_device (profile_id,device_id,node_id,access) values(1001, 1002, 1001, true);
insert into dmt.profile_device (profile_id,device_id,node_id,access) values(1001, 1003, 1001, true);
insert into dmt.profile_device (profile_id,device_id,node_id,access) values(1001, 1004, 1002, true);
insert into dmt.profile_device (profile_id,device_id,node_id,access) values(1001, 1005, 1002, true);
insert into dmt.profile_device (profile_id,device_id,node_id,access) values(1001, 1006, 1002, true);
insert into dmt.profile_device (profile_id,device_id,node_id,access) values(1002, 1001, 1001, true);
insert into dmt.profile_device (profile_id,device_id,node_id,access) values(1002, 1002, 1001, true);
insert into dmt.profile_device (profile_id,device_id,node_id,access) values(1002, 1003, 1001, true);
insert into dmt.profile_device (profile_id,device_id,node_id,access) values(1002, 1004, 1002, true);
insert into dmt.profile_device (profile_id,device_id,node_id,access) values(1002, 1005, 1002, true);
insert into dmt.profile_device (profile_id,device_id,node_id,access) values(1002, 1006, 1002, true);
insert into dmt.profile_device (profile_id,device_id,node_id,access) values(1003, 1001, 1001, false);
insert into dmt.profile_device (profile_id,device_id,node_id,access) values(1003, 1002, 1001, false);
insert into dmt.profile_device (profile_id,device_id,node_id,access) values(1003, 1003, 1001, false);
insert into dmt.profile_device (profile_id,device_id,node_id,access) values(1003, 1004, 1002, false);
insert into dmt.profile_device (profile_id,device_id,node_id,access) values(1003, 1005, 1002, false);
insert into dmt.profile_device (profile_id,device_id,node_id,access) values(1003, 1006, 1002, false);
insert into dmt.profile_device (profile_id,device_id,node_id,access) values(1004, 1001, 1001, false);
insert into dmt.profile_device (profile_id,device_id,node_id,access) values(1004, 1002, 1001, false);
insert into dmt.profile_device (profile_id,device_id,node_id,access) values(1004, 1003, 1001, false);
insert into dmt.profile_device (profile_id,device_id,node_id,access) values(1004, 1004, 1002, false);
insert into dmt.profile_device (profile_id,device_id,node_id,access) values(1004, 1005, 1002, false);
insert into dmt.profile_device (profile_id,device_id,node_id,access) values(1004, 1006, 1002, false);


DROP PROCEDURE discover_and_pair_new_matter_devices;

DELIMITER //
CREATE PROCEDURE discover_and_pair_new_matter_devices()
BEGIN
	DECLARE new_matter_node_id, new_device_id1, new_device_id2, new_device_id3 int;
  	SET @new_matter_node_id := (select max(node_id) + 1 from dmt.matter);
  	SET @new_device_id1 := (select max(device_id) + 1 from dmt.device);
 	SET @new_device_id2 := (select max(device_id) + 2 from dmt.device);
	SET @new_device_id3 := (select max(device_id) + 3 from dmt.device);
  	insert into dmt.matter (node_id, name) values(@new_matter_node_id, concat('M', @new_matter_node_id));
	insert into dmt.device (device_id, name, status, location) values(@new_device_id1, concat('B', @new_device_id1), 'OFF', 'Not Defined');
	insert into dmt.device (device_id, name, status, location) values(@new_device_id2, concat('B', @new_device_id2), 'OFF', 'Not Defined');
	insert into dmt.device (device_id, name, status, location) values(@new_device_id3, concat('B', @new_device_id3), 'OFF', 'Not Defined');
	insert into dmt.matter_device (node_id,device_id) values(@new_matter_node_id, @new_device_id1);
	insert into dmt.matter_device (node_id,device_id) values(@new_matter_node_id, @new_device_id2);
	insert into dmt.matter_device (node_id,device_id) values(@new_matter_node_id, @new_device_id3);
	insert into dmt.profile_device (profile_id,device_id,node_id,access) values(1001, @new_device_id1, @new_matter_node_id, true);
	insert into dmt.profile_device (profile_id,device_id,node_id,access) values(1001, @new_device_id2, @new_matter_node_id, true);
	insert into dmt.profile_device (profile_id,device_id,node_id,access) values(1001, @new_device_id3, @new_matter_node_id, true);
	insert into dmt.profile_device (profile_id,device_id,node_id,access) values(1002, @new_device_id1, @new_matter_node_id, true);
	insert into dmt.profile_device (profile_id,device_id,node_id,access) values(1002, @new_device_id2, @new_matter_node_id, true);
	insert into dmt.profile_device (profile_id,device_id,node_id,access) values(1002, @new_device_id3, @new_matter_node_id, true);
	insert into dmt.profile_device (profile_id,device_id,node_id,access) values(1003, @new_device_id1, @new_matter_node_id, false);
	insert into dmt.profile_device (profile_id,device_id,node_id,access) values(1003, @new_device_id2, @new_matter_node_id, false);
	insert into dmt.profile_device (profile_id,device_id,node_id,access) values(1003, @new_device_id3, @new_matter_node_id, false);
	insert into dmt.profile_device (profile_id,device_id,node_id,access) values(1004, @new_device_id1, @new_matter_node_id, false);
	insert into dmt.profile_device (profile_id,device_id,node_id,access) values(1004, @new_device_id2, @new_matter_node_id, false);
	insert into dmt.profile_device (profile_id,device_id,node_id,access) values(1004, @new_device_id3, @new_matter_node_id, false);
	commit;
END //

-- select * from dmt.account;
-- select * from dmt.profile;
-- select * from dmt.user;
-- select * from dmt.matter;
-- select * from dmt.device;
-- select * from dmt.profile_device;
-- select * from dmt.matter_device;



-- select pd.device_id, d.name device_name, pd.node_id, m.name node_name, pd.access, d.status from dmt.profile_device pd, dmt.matter m, dmt.device d where pd.node_id = m.node_id and pd.device_id = d.device_id and pd.profile_id = 1001;

-- CALL discover_and_pair_new_matter_devices();
-- DELETE m, md, d, pd FROM dmt.matter AS m LEFT JOIN dmt.matter_device AS md ON m.node_id = md.node_id LEFT JOIN dmt.device AS d ON md.device_id = d.device_id LEFT JOIN dmt.profile_device AS pd ON pd.device_id = d.device_id WHERE m.node_id=1003;
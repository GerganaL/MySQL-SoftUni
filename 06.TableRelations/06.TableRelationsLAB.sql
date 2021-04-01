SELECT * FROM camp.campers;

use camp;
CREATE TABLE `mountains` (
    `id` INT UNSIGNED UNIQUE AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(50) NOT NULL
); 
CREATE TABLE `peaks` (
    `id` INT UNSIGNED UNIQUE AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(50) NOT NULL,
    `mountain_id` INT UNSIGNED UNIQUE,
    CONSTRAINT `fk_peaks_mountains` FOREIGN KEY (`mountain_id`)
        REFERENCES `mountains` (`id`)
);


select `driver_id`, `vehicle_type` , concat(`c`.`first_name`, ' ',  `c`.`last_name`) as driver_name
from `vehicles` as v
join `campers` as c on v.`driver_id` = c.`id`;


select `starting_point` as route_starting_point,
`end_point` as route_ending_point,
`leader_id` , concat(`c`.`first_name`, ' ',  `c`.`last_name`) as leader_name
from `routes` as r
join `campers` as c on r.`leader_id` = c.`id`;

CREATE TABLE `peaks` (
    `id` INT UNSIGNED UNIQUE AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(50) NOT NULL
); 
CREATE TABLE `mountains` (
    `id` INT UNSIGNED UNIQUE AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(50) NOT NULL,
    `mountain_id` INT UNSIGNED UNIQUE,
    CONSTRAINT `fk_mountains_peaks` FOREIGN KEY (`mountain_id`)
        REFERENCES `peaks` (`id`)
);


CREATE DATABASE `company`;
USE `company`;

CREATE TABLE `projects` (
    `id` INT(11) UNSIGNED UNIQUE AUTO_INCREMENT PRIMARY KEY,
    `client_id` INT(11) UNSIGNED,
    `project_lead_id` INT(11) UNSIGNED
);

CREATE TABLE `clients` (
    `id` INT(11) UNSIGNED UNIQUE AUTO_INCREMENT PRIMARY KEY,
    `client_name` VARCHAR(100) NOT NULL,
    `project_id` INT(11) UNSIGNED
);

CREATE TABLE `employees` (
    `id` INT(11) UNSIGNED UNIQUE AUTO_INCREMENT PRIMARY KEY,
    `first_name` VARCHAR(30) NOT NULL,
    `last_name` VARCHAR(30) NOT NULL,
    `project_id` INT(11) UNSIGNED
);


ALTER TABLE `projects` 
ADD CONSTRAINT `fk_projects_clients` 
	FOREIGN KEY (`client_id`)
	REFERENCES `clients` (`id`),
ADD CONSTRAINT `fk_projects_employees`
	FOREIGN KEY (`project_lead_id`)
	REFERENCES `employees` (`id`);

ALTER TABLE `clients`
ADD CONSTRAINT `fk_clients_project`
	FOREIGN KEY (`project_id`)
	REFERENCES `projects` (`project_lead_id`);
    
    ALTER TABLE `employees`
ADD CONSTRAINT `fk_employees_project`
	FOREIGN KEY (`project_id`)
	REFERENCES `projects` (`id`);






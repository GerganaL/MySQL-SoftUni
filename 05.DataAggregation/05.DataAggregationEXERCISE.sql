#1 Records’ Count
SELECT COUNT(`id`) AS  'count' FROM `wizzard_deposits`;

#2 Longest Magic Wand
SELECT MAX(`magic_wand_size`) AS 'longest_magic_wand'
FROM `wizzard_deposits`;

#3 Longest Magic Wand per Deposit Groups
SELECT `deposit_group`, MAX(`magic_wand_size`) AS 'longest_magic_wand'
FROM `wizzard_deposits`
ORDER BY `longest_magic_wand`, `deposit_group`;

#4 Smallest Deposit Group per Magic Wand Size*
SELECT `deposit_group`
FROM`wizzard_deposits`
GROUP BY `deposit_group`
ORDER BY AVG(`magic_wand_size`)
LIMIT 1;

#5  Deposits Sum
SELECT `deposit_group` , SUM(deposit_amount) AS 'total_sum' 
FROM `wizzard_deposits`
GROUP BY `deposit_group`
ORDER BY 'total_sum' ASC;

#6 Deposits Sum for Ollivander family
SELECT `deposit_group` , SUM(deposit_amount) AS 'total_sum' 
FROM `wizzard_deposits`
WHERE `magic_wand_creator` LIKE '%Ollivander%'
GROUP BY  `deposit_group`
ORDER BY  `deposit_group`;

#7 Deposits Filter

SELECT `deposit_group`, SUM(`deposit_amount`) AS 'total_sum'
FROM`wizzard_deposits`
WHERE
`magic_wand_creator` = 'Ollivander family'
GROUP BY `deposit_group`
HAVING `total_sum` < 150000
ORDER BY `total_sum` DESC;

#8 Deposit charge
SELECT `deposit_group`, `magic_wand_creator`, MIN(`deposit_charge`) AS 'min_deposit_charge'
FROM `wizzard_deposits`
GROUP BY `deposit_group`, `magic_wand_creator`
ORDER BY `magic_wand_creator`, `deposit_group` ASC;

#9 Age Groups
SELECT 
case
when age <= 10 THEN '[0-10]'
when age <= 20 THEN '[11-20]'
when age <= 30 THEN '[21-30]'
when age <= 40 THEN '[31-40]'
when age <= 50 THEN '[41-50]'
when age <= 60 THEN '[51-60]'
else '[61+]'
end as 'age_group', count(`id`) as 'wizard_count'
from `wizzard_deposits`
group by `age_group`
order by `wizard_count`;


#10 First letter
select left(`first_name`,1) as 'first_letter'
from `wizzard_deposits`
where `deposit_group` = 'Troll Chest'
group by `first_letter`
order by `first_letter` asc;

#11 Average interest
select `deposit_group`, `is_deposit_expired` as 'is_deposit_expired',
avg(`deposit_interest`) as 'average_interest'
from `wizzard_deposits`
where `deposit_start_date` > '1985-01-01'
group by `deposit_group`, `is_deposit_expired`
order by `deposit_group` desc, `is_deposit_expired`;

#12 Rich Wizard, Poor Wizard*
SELECT 
    SUM(`hw`.`deposit_amount` - `gw`.`deposit_amount`) AS 'sum_difference'
FROM
    `wizzard_deposits` AS `hw`,
    `wizzard_deposits` AS `gw`
WHERE
    `gw`.`id` - `hw`.`id` = 1;
    

SELECT 
    `hw`.`first_name` AS 'host_wizard',
    `hw`.`deposit_amount` AS 'host_wizard_deposit',
    `gw`.`first_name` AS 'guest_wizard',
    `gw`.`deposit_amount` AS 'guest_wizard_deposit',
    (`hw`.`deposit_amount` - `gw`.`deposit_amount`) AS 'difference'
FROM
    `wizzard_deposits` AS `hw`, `wizzard_deposits` AS `gw`
WHERE
     `gw`.`id` - `hw`.`id` = 1;
     
     #13 Employees Minimum Salaries
     
     use soft_uni;
     
     select `department_id`, min(`salary`) as 'minimum_salary'
     from `employees`
     where `department_id` in (2,5,7) and `hire_date` > '2000-01-01'
     group by `department_id`
   #  having `hire_date` > '2000-01-01'
     order by `department_id` asc;
     
     #14 Employees Average Salaries
     
     select `department_id`,
     case
     when `department_id` = 1 then avg(`salary`) + 5000
     else avg(`salary`)
     end as 'avg_salary'
     from `employees`
     where `salary` > 30000 and `manager_id` != 42
     group by `department_id`
     order by `department_id`;
     
     #15 Employees Maximum Salaries
     
select `department_id`, max(`salary`) as 'max_salary'
     from `employees`
     where `salary` NOT BETWEEN 30000 and 70000
     group by `department_id`
     order by `department_id`;


SELECT 
    `department_id`, MAX(`salary`) AS 'max_salary'
FROM
    `employees`
GROUP BY `department_id`
HAVING NOT `max_salary` BETWEEN 30000 AND 70000
ORDER BY `department_id`;

#16 Employees Count Salaries
select count(`salary`) 
from `employees`
where isnull(`manager_id`);

#17 3rd Highest Salary*
SELECT 
    `emp`.`department_id`,
    MAX(`emp`.`salary`) AS 'third_highest_salary'
FROM
    `employees` AS `emp`
        JOIN
    (SELECT 
        `e`.`department_id`, MAX(`e`.`salary`) AS `max_salary`
    FROM
        `employees` AS `e`
    JOIN (SELECT 
        `e`.`department_id`, MAX(`e`.`salary`) AS `max_salary`
    FROM
        `employees` AS `e`
    GROUP BY `e`.`department_id`) AS `first_max_salary` ON `e`.`department_id` = `first_max_salary`.`department_id`
    WHERE
        `e`.`salary` < `first_max_salary`.`max_salary`
    GROUP BY `e`.`department_id`) AS `second_max_salary` ON `emp`.`department_id` = `second_max_salary`.`department_id`
WHERE
    `emp`.`salary` < `second_max_salary`.`max_salary`
GROUP BY `emp`.`department_id`
ORDER BY `emp`.`department_id`;

#18 Salary Challenge**
SELECT `e`.`first_name`, `e`.`last_name`, `e`.`department_id`
FROM`employees` AS `e`
JOIN
(SELECT 
 `department_id`, AVG(`salary`) AS 'dep_avg_salary'
 FROM `employees`
 GROUP BY `department_id`) AS `avrg` ON `e`.`department_id` = `avrg`.`department_id`
WHERE `salary` > `avrg`.`dep_avg_salary`
ORDER BY `department_id`
LIMIT 10; 

#19 Departments Total Salaries
select `department_id` , sum(`salary`) as 'total_salary'
from `employees`
group by `department_id`;

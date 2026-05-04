select * from gym_records.gym_members_exercise_tracking as record_tracking;
# questions
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# q1 -  Find the total number of members grouped by Gender.
select gender,count(*) as total_members_in_the_data from gym_members_exercise_tracking
group by gender;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# q2- Find the average Calories_Burned by all members
select round(avg(Calories_Burned),2) as avg_calories_burned_by_members from gym_members_exercise_tracking;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# q3 - Count members for each Workout_Type,Sort from highest to lowest.
select Workout_Type,count(*) as number_of_people from gym_members_exercise_tracking
group by Workout_Type
order by number_of_people asc,Workout_Type asc;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# q4 - Find average BMI grouped by Gender.
select gender,round(avg(BMI),3) as avg_bmi from gym_members_exercise_tracking
group by gender;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# q5 -Find members who work out more than 4 days per week.
ALTER TABLE gym_members_exercise_tracking
RENAME COLUMN `Workout_Frequency (days/week)` TO workout_frequency;

select count(*) as no_of_peoples,workout_frequency
from gym_members_exercise_tracking
where  workout_frequency >=4
group by workout_frequency;

#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# q6 - Find average Calories_Burned for each Workout_Type.
select avg(Calories_Burned) as avg_cal_burned,Workout_Type from
gym_members_exercise_tracking
group by Workout_Type;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# q7 - Find average Session_Duration_hours for each Experience_Level.
Alter table gym_members_exercise_tracking
rename column `Session_Duration (hours)` to seassion_duration;

select Experience_Level,round(avg(seassion_duration),2) as avg_duration from
gym_members_exercise_tracking
group by Experience_Level
order by Experience_Level;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# q8 -Find members with BMI greater than 30.

select * from 
gym_members_exercise_tracking where BMI >30;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------
# q9 - Find average Water_Intake_liters grouped by Workout_Type.
alter table gym_members_exercise_tracking
rename column `Water_Intake (liters)` to water_intake;

select avg(water_intake) as avg_water_intk,Workout_type
from gym_members_exercise_tracking
group by Workout_Type;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# q10 -Display the top 10 members with highest Calories_Burned.
select * 
from gym_members_exercise_tracking
order by Calories_Burned desc
limit 10;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# q-11 - Find which Workout_Type has the highest average Session_Duration_hours.
select Workout_Type,avg(seassion_duration) as avg_sess_duration
from  gym_members_exercise_tracking
group by Workout_Type
order by avg_sess_duration desc
limit 1;

-------------------------------------------------------------------------------------------------------------------------------------------------
# q-12 Find which Workout_Type has the lowest average Fat_Percentage.
select Workout_Type,min(Fat_Percentage) as lowest_fat_per
from gym_members_exercise_tracking
group by Workout_Type
order by lowest_fat_per asc
limit 1;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# q-13 - Rank Members by Calories Burned

select *,rank()over(order by Calories_Burned desc) as rnk 
from  gym_members_exercise_tracking;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# q-14 - Identify Consistently Active Members
# whose working days is 5 or more and their seassion duration is also more than the avg duration
select *
from gym_members_exercise_tracking
where workout_frequency >=5 and seassion_duration > (select avg(seassion_duration) from gym_members_exercise_tracking);

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# q-15 Top 3 Calorie Burners per Workout Type
# Find top 3 members with highest Calories_Burned within each Workout_Type.
SELECT *
FROM (
    SELECT *,
           DENSE_RANK() OVER (
               PARTITION BY Workout_Type
               ORDER BY Calories_Burned DESC
           ) AS rnk
    FROM gym_members_exercise_tracking
) t
WHERE rnk <= 3;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# q-16 Show each member’s Calories_Burned and compare it with average calories burned for their Workout_Type.

select Calories_Burned,Workout_type,avg(Calories_Burned) over(partition by Workout_Type) as avg_cal_burned,
abs(Calories_Burned - avg(Calories_Burned) over(partition by Workout_Type)) diff_In_cal
from gym_members_exercise_tracking
;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# q-17 Calculate cumulative Calories_Burned ordered by Age.
# for the cumulative sum you have to use the over clause with the presceding and following syntax

select *,sum(Calories_Burned) over( rows between unbounded preceding and current row) as cum_sum
from 
gym_members_exercise_tracking
order by age asc;

# q- 18 Find the most common Workout_Type among Experience_Level = 3 members.
select Work





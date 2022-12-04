--  create table if not exists input(
  --  line text
--  );
--  delete from input;
--  .import ./input.txt input

with matches as (
  select
   substr(line, 1, 1) as them,
   substr(line, 3, 1) as me
  from input
),
scores as (
  select case me
        when 'X' then 1 + (case them
          when 'A' then 3
          when 'B' then 0
          when 'C' then 6
        end)
        when 'Y' then 2 + (case them
          when 'A' then 6
          when 'B' then 3
          when 'C' then 0
        end)
        when 'Z' then 3 + (case them
          when 'A' then 0
          when 'B' then 6
          when 'C' then 3
        end)
    end score
  from matches
)
select sum(score) from scores;

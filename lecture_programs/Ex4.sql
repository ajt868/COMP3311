create or replace function
	seq(lo integer, hi integer, incr integer)
returns setof integer
as $$
declare
	i integer := lo
begin
	while (i <= hi) loop
		return next i;
		i := i + incr
	end loop;
end;
$$
language plpgsql;

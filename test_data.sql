--- checks for non-symmetric routes where the cost is different 
--- depending on the direction
select f.*, b.*
  from edge f,
       edge b
 where f.from_node_id = b.to_node_id
   and f.to_node_id = b.from_node_id
   and f.cost <> b.cost
/

--- such routes may exist in the general case; but i've chosen our example data
--- such that there are NO such paths.  Or at least i've tried to!


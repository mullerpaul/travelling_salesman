SELECT (1 * 2 * 3 * 4 * 5) AS factorial_5,
       (1 * 2 * 3 * 4)     AS factorial_4
  FROM dual
/

SELECT n1.node_id, n2.node_id, n3.node_id, n4.node_id, n5.node_id, n1.node_id
  FROM node n1, node n2, node n3, node n4, node n5
 WHERE n1.node_id <> n2.node_id AND n1.node_id <> n3.node_id AND n1.node_id <> n4.node_id AND n1.node_id <> n5.node_id 
   AND n2.node_id <> n3.node_id AND n2.node_id <> n4.node_id AND n2.node_id <> n5.node_id
   AND n3.node_id <> n4.node_id AND n3.node_id <> n5.node_id
   AND n4.node_id <> n5.node_id
   AND n1.node_id = 1 -- "normalize" all paths by shifting "1" to the first slot.
                      -- This eliminates dupes like 51234 & 45123 since they are the same as 12345,
                      -- and reduces the result count from N! to (N-1)!
/

  WITH hamiltonian_paths -- one row per path
    AS (SELECT ROWNUM AS path_id, 
               n1.node_id AS n1, 
               n2.node_id AS n2, 
               n3.node_id AS n3, 
               n4.node_id AS n4,
               n5.node_id AS n5,
               n1.node_id as n6  --repeat the start node here to make the next step easier
          FROM node n1, node n2, node n3, node n4, node n5
         WHERE n1.node_id <> n2.node_id AND n1.node_id <> n3.node_id AND n1.node_id <> n4.node_id AND n1.node_id <> n5.node_id 
           AND n2.node_id <> n3.node_id AND n2.node_id <> n4.node_id AND n2.node_id <> n5.node_id
           AND n3.node_id <> n4.node_id AND n3.node_id <> n5.node_id
           AND n4.node_id <> n5.node_id
           AND n1.node_id = 1),
       path_legs  -- turn each path into 5 rows for its 5 component legs
    AS (SELECT *
          FROM hamiltonian_paths
       UNPIVOT
         ((from_node, to_node)
            FOR leg
            IN ((n1, n2), (n2, n3), (n3, n4), (n4, n5), (n5, n6))
         ))
SELECT pl.path_id, 
       SUM(e.cost) AS total_cost
  FROM path_legs pl,
       edge e
 WHERE pl.from_node = e.from_node_id
   AND pl.to_node = e.to_node_id
 GROUP BY pl.path_id
 ORDER BY 2;

 

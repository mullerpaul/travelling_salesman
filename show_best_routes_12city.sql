  WITH hamiltonian_paths -- one row per path
    AS (SELECT ROWNUM AS path_id,
               n1.node_id AS n1,
               n2.node_id AS n2,
               n3.node_id AS n3,
               n4.node_id AS n4,
               n5.node_id AS n5,
               n6.node_id AS n6,
               n7.node_id AS n7,
               n8.node_id AS n8,
               n9.node_id as n9,
               n10.node_id as n10,
               n11.node_id as n11,
               n12.node_id as n12,
               n1.node_id as n13  --repeat the start node here to make the next step easier
          FROM node n1, node n2, node n3, node n4, node n5, node n6, node n7, node n8,
               node n9, node n10, node n11, node n12
         WHERE n1.node_id <> n2.node_id AND n1.node_id <> n3.node_id AND n1.node_id <> n4.node_id AND n1.node_id <> n5.node_id AND n1.node_id <> n6.node_id 
           AND n1.node_id <> n7.node_id AND n1.node_id <> n8.node_id AND n1.node_id <> n9.node_id AND n1.node_id <> n10.node_id AND n1.node_id <> n11.node_id
           AND n1.node_id <> n12.node_id 
           AND n2.node_id <> n3.node_id AND n2.node_id <> n4.node_id AND n2.node_id <> n5.node_id AND n2.node_id <> n6.node_id AND n2.node_id <> n7.node_id 
           AND n2.node_id <> n8.node_id AND n2.node_id <> n9.node_id AND n2.node_id <> n10.node_id AND n2.node_id <> n11.node_id AND n2.node_id <> n12.node_id
           AND n3.node_id <> n4.node_id AND n3.node_id <> n5.node_id AND n3.node_id <> n6.node_id AND n3.node_id <> n7.node_id AND n3.node_id <> n8.node_id
           AND n3.node_id <> n9.node_id AND n3.node_id <> n10.node_id AND n3.node_id <> n11.node_id AND n3.node_id <> n12.node_id
           AND n4.node_id <> n5.node_id AND n4.node_id <> n6.node_id AND n4.node_id <> n7.node_id AND n4.node_id <> n8.node_id
           AND n4.node_id <> n9.node_id AND n4.node_id <> n10.node_id AND n4.node_id <> n11.node_id AND n4.node_id <> n12.node_id
           AND n5.node_id <> n6.node_id AND n5.node_id <> n7.node_id AND n5.node_id <> n8.node_id AND n5.node_id <> n9.node_id
           AND n5.node_id <> n10.node_id AND n5.node_id <> n11.node_id AND n5.node_id <> n12.node_id
           AND n6.node_id <> n7.node_id AND n6.node_id <> n8.node_id AND n6.node_id <> n9.node_id AND n6.node_id <> n10.node_id 
           AND n6.node_id <> n11.node_id AND n6.node_id <> n12.node_id
           AND n7.node_id <> n8.node_id AND n7.node_id <> n9.node_id AND n7.node_id <> n10.node_id AND n7.node_id <> n11.node_id 
           AND n7.node_id <> n12.node_id
           AND n8.node_id <> n9.node_id AND n8.node_id <> n10.node_id AND n8.node_id <> n11.node_id AND n8.node_id <> n12.node_id
           AND n9.node_id <> n10.node_id AND n9.node_id <> n11.node_id AND n9.node_id <> n12.node_id
           AND n10.node_id <> n11.node_id AND n10.node_id <> n12.node_id
           AND n11.node_id <> n12.node_id
           AND n1.node_id = 1),
       path_legs  -- turn each path into 8 rows for its 8 component legs
    AS (SELECT *
          FROM hamiltonian_paths
       UNPIVOT
         ((from_node, to_node)   -- unpivot column pairs to rows!
            FOR leg
            IN ((n1, n2), (n2, n3), (n3, n4), (n4, n5), (n5, n6), (n6, n7), 
                (n7, n8), (n8, n9), (n9, n10), (n10, n11), (n11, n12), (n12, n13))
         )
       ),
       best_paths
    AS (SELECT pl.path_id,
               SUM(e.cost) AS total_cost
          FROM path_legs pl,
               edge e
         WHERE pl.from_node = e.from_node_id
           AND pl.to_node = e.to_node_id
         GROUP BY pl.path_id
         ORDER BY 2
         FETCH FIRST 8 ROWS ONLY)   --- this syntax available starting in oracle 12.1 
SELECT bp.total_cost,
       h.*
  FROM best_paths bp,
       hamiltonian_paths h
 WHERE bp.path_id = h.path_id
 ORDER BY bp.total_cost, h.path_id
/

-- 12 citiies led to tempspace error after 8 min 12 sec




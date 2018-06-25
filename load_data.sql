---- insert edge IDs and names ----
INSERT INTO node (node_id, node_label) VALUES (1, 'Denver')
/
INSERT INTO node (node_id, node_label) VALUES (2, 'Austin')
/
INSERT INTO node (node_id, node_label) VALUES (3, 'Chicago')
/
INSERT INTO node (node_id, node_label) VALUES (4, 'New York')
/
INSERT INTO node (node_id, node_label) VALUES (5, 'San Fransisco')
/

---- insert edge costs ----
INSERT INTO edge (from_node_id, to_node_id, cost) VALUES (1, 2, 2)
/
INSERT INTO edge (from_node_id, to_node_id, cost) VALUES (1, 3, 4)
/
INSERT INTO edge (from_node_id, to_node_id, cost) VALUES (1, 4, 7)
/
INSERT INTO edge (from_node_id, to_node_id, cost) VALUES (1, 5, 5)
/

INSERT INTO edge (from_node_id, to_node_id, cost) VALUES (2, 1, 2)
/
INSERT INTO edge (from_node_id, to_node_id, cost) VALUES (2, 3, 5)
/
INSERT INTO edge (from_node_id, to_node_id, cost) VALUES (2, 4, 8)
/
INSERT INTO edge (from_node_id, to_node_id, cost) VALUES (2, 5, 4)
/

INSERT INTO edge (from_node_id, to_node_id, cost) VALUES (3, 1, 4)
/
INSERT INTO edge (from_node_id, to_node_id, cost) VALUES (3, 2, 5)
/
INSERT INTO edge (from_node_id, to_node_id, cost) VALUES (3, 4, 1)
/
INSERT INTO edge (from_node_id, to_node_id, cost) VALUES (3, 5, 3)
/

INSERT INTO edge (from_node_id, to_node_id, cost) VALUES (4, 1, 7)
/
INSERT INTO edge (from_node_id, to_node_id, cost) VALUES (4, 2, 8)
/
INSERT INTO edge (from_node_id, to_node_id, cost) VALUES (4, 3, 1)
/
INSERT INTO edge (from_node_id, to_node_id, cost) VALUES (4, 5, 6)
/

INSERT INTO edge (from_node_id, to_node_id, cost) VALUES (5, 1, 5)
/
INSERT INTO edge (from_node_id, to_node_id, cost) VALUES (5, 2, 4)
/
INSERT INTO edge (from_node_id, to_node_id, cost) VALUES (5, 3, 3)
/
INSERT INTO edge (from_node_id, to_node_id, cost) VALUES (5, 4, 6)
/
---- gotta commit! ----
COMMIT
/


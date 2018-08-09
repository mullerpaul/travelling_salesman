ALTER TABLE edge DISABLE CONSTRAINT edge_fk01
/
ALTER TABLE edge DISABLE CONSTRAINT edge_fk02
/
TRUNCATE TABLE edge
/
TRUNCATE TABLE node
/
ALTER TABLE edge ENABLE CONSTRAINT edge_fk01
/
ALTER TABLE edge ENABLE CONSTRAINT edge_fk02
/

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
INSERT INTO node (node_id, node_label) VALUES (6, 'Los Angeles')
/
INSERT INTO node (node_id, node_label) VALUES (7, 'Dallas')
/
INSERT INTO node (node_id, node_label) VALUES (8, 'Detroit')
/
INSERT INTO node (node_id, node_label) VALUES (9, 'Pickle')
/
INSERT INTO node (node_id, node_label) VALUES (10, 'Mustard')
/

SET TIMING on
SET LINESIZE 156

---- insert edge costs ----
DECLARE
  lv_node_count NUMBER;
  lv_temp_cost  NUMBER;

BEGIN
  SELECT MAX(node_id)
    INTO lv_node_count
    FROM node;

  FOR from_index IN 1 .. lv_node_count LOOP
    FOR to_index IN 1.. lv_node_count LOOP
      IF from_index <> to_index 
      THEN
        BEGIN
          /* See if we have already done the same edge in the opposite direction.
             If so, we want to use the same cost so the graph is non-directed */
          SELECT cost
            INTO lv_temp_cost
            FROM edge
           WHERE from_node_id = to_index
             AND to_node_id = from_index;
        EXCEPTION
          WHEN no_data_found
            THEN
              /* generate new cost value */
              --lv_temp_cost := round(50 + 10 * dbms_random.normal, 1);
              lv_temp_cost := round(44 + 12 * dbms_random.normal, 1);
        END;

        INSERT INTO edge (from_node_id, to_node_id, cost)
        VALUES (from_index, to_index, lv_temp_cost);

      END IF;  --check for self-row

    END LOOP;  --to_index
  END LOOP;  -- from_index

END;
/

---- gotta commit! ----
COMMIT
/


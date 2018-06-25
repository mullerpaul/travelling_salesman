DROP TABLE edge PURGE
/
DROP TABLE node PURGE
/


CREATE TABLE node
  (node_id    NUMBER       NOT NULL,
   node_label VARCHAR2(40) NOT NULL,
   CONSTRAINT node_pk PRIMARY KEY (node_id))
/

CREATE TABLE edge
  (from_node_id  NUMBER NOT NULL,
   to_node_id    NUMBER NOT NULL,
   cost          NUMBER NOT NULL,
   CONSTRAINT edge_pk PRIMARY KEY (from_node_id, to_node_id),
   CONSTRAINT edge_fk01 FOREIGN KEY (from_node_id) REFERENCES node (node_id),
   CONSTRAINT edge_fk02 FOREIGN KEY (to_node_id) REFERENCES node (node_id),
   CONSTRAINT edge_ck01 CHECK (from_node_id <> to_node_id))
/


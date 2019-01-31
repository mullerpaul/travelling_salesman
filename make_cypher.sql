SET LINES 100 PAGES 400 TRIMSPOOL on HEAD off FEEDBACK off
SPOOL load.cql

  with node_data 
    as (select node_id, node_label, lower(chr(64+rownum)) as node_alias
          from node)
select cql_text
  from (
select 0 as statement_order_key,
       'CREATE' as cql_text
  from dual
 union all
select 1 as statement_order_key, 
       '(' || n.node_alias || ':Snack { name: "' || n.node_label || '" } ),' as cql_text
  from node_data n
 union all
select 2 as statement_order_key,
       '(' || f.node_alias 
         || ')-[:Cost {weight: '
         || to_char(cost) 
         || '}]->(' 
         || t.node_alias 
         || '),' as cql_text
  from edge e,
       node_data f,
       node_data t
 where e.from_node_id = f.node_id
   and e.to_node_id = t.node_id)
 order by statement_order_key
/

spool off
exit


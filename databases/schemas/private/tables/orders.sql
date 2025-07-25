CREATE OR ALTER TABLE PRIVATE.JSON_ORDERS_TBL_STG (
  customer varchar,
  order_date date,
  delivery_date date,
  baked_good_type varchar,
  quantity number,
  source_file_name varchar,
  load_ts timestamp
);

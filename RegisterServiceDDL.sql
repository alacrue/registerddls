CREATE EXTENSION "uuid-ossp";

CREATE TABLE product (
  id uuid NOT NULL,
  lookupcode character varying(32) NOT NULL DEFAULT(''),
  count int NOT NULL DEFAULT(0),
  price int NOT NULL DEFAULT(0),
  createdon timestamp without time zone NOT NULL DEFAULT now(),
  CONSTRAINT product_pkey PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);

CREATE TABLE employee (
  record_id uuid NOT NULL,
  f_name char(10) NOT NULL DEFAULT(''),
  l_name char(10) NOT NULL DEFAULT(''),
  employee_id int UNIQUE,
  active char(10) CHECK (active IN ('active','inactive')),
  role char(32) CHECK (role IN ('cashier','shift manager','manager')),
  manager int REFERENCES employee(employee_id),
  password char(15) NOT NULL DEFAULT(''),
  createdon timestamp without time zone NOT NULL DEFAULT now(),
  CONSTRAINT employee_pkey PRIMARY KEY (record_id)
);

INSERT INTO employee VALUES (
  uuid_generate_v4(),
  'John',
  'Doe',
  '1',
  'active',
  'cashier',
  '3',
  'abcd',
  current_timestamp
);

INSERT INTO employee VALUES (
  uuid_generate_v4(),
  'Rachel',
  'Greene',
  '3',
  'active',
  'manager',
  NULL,
  'defg',
  current_timestamp
);

CREATE INDEX ix_product_lookupcode
  ON product
  USING btree
  (lower(lookupcode::text) COLLATE pg_catalog."default");

INSERT INTO product VALUES (
       uuid_generate_v4()
     , 'lookupcode1'
     , 100
     , current_timestamp
);

INSERT INTO product VALUES (
       uuid_generate_v4()
     , 'lookupcode1'
     , 125
     , current_timestamp
);

INSERT INTO product VALUES (
       uuid_generate_v4()
     , 'lookupcode3'
     , 150
     , current_timestamp
);

--
-- PostgreSQL database dump
--

\restrict uPsrvABkFUDtH6hffC8GSShDi0HCDjuP0toE6EMNwWN4ulUSoabgL0TxeduXabA

-- Dumped from database version 16.14 (Ubuntu 16.14-0ubuntu0.24.04.1)
-- Dumped by pg_dump version 18.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: boolean_types; Type: TABLE; Schema: public; Owner: replicator
--

CREATE TABLE public.boolean_types (
    id bigint,
    row_label text,
    col_bool boolean
);


ALTER TABLE public.boolean_types OWNER TO replicator;

--
-- Name: currency_types; Type: TABLE; Schema: public; Owner: replicator
--

CREATE TABLE public.currency_types (
    id bigint,
    row_label text,
    col_currency numeric(19,4)
);


ALTER TABLE public.currency_types OWNER TO replicator;

--
-- Name: datetime_types; Type: TABLE; Schema: public; Owner: replicator
--

CREATE TABLE public.datetime_types (
    id bigint,
    row_label text,
    col_date timestamp without time zone
);


ALTER TABLE public.datetime_types OWNER TO replicator;

--
-- Name: decimal_types; Type: TABLE; Schema: public; Owner: replicator
--

CREATE TABLE public.decimal_types (
    id bigint,
    row_label text,
    col_currency numeric(19,4),
    col_dec_0 numeric,
    col_dec_2 numeric,
    col_dec_6 numeric
);


ALTER TABLE public.decimal_types OWNER TO replicator;

--
-- Name: float_types; Type: TABLE; Schema: public; Owner: replicator
--

CREATE TABLE public.float_types (
    id bigint,
    row_label text,
    col_single real,
    col_double double precision
);


ALTER TABLE public.float_types OWNER TO replicator;

--
-- Name: guid_types; Type: TABLE; Schema: public; Owner: replicator
--

CREATE TABLE public.guid_types (
    id bigint,
    row_label text,
    col_guid uuid
);


ALTER TABLE public.guid_types OWNER TO replicator;

--
-- Name: integer_types; Type: TABLE; Schema: public; Owner: replicator
--

CREATE TABLE public.integer_types (
    id bigint,
    row_label text,
    col_byte smallint,
    col_int integer,
    col_long bigint,
    col_bigint bigint
);


ALTER TABLE public.integer_types OWNER TO replicator;

--
-- Name: text_types; Type: TABLE; Schema: public; Owner: replicator
--

CREATE TABLE public.text_types (
    id bigint,
    row_label text,
    col_text_50 text,
    col_memo text
);


ALTER TABLE public.text_types OWNER TO replicator;

--
-- Data for Name: boolean_types; Type: TABLE DATA; Schema: public; Owner: replicator
--

COPY public.boolean_types (id, row_label, col_bool) FROM stdin;
1	TRUE	t
2	FALSE	f
3	NULL	f
\.


--
-- Data for Name: currency_types; Type: TABLE DATA; Schema: public; Owner: replicator
--

COPY public.currency_types (id, row_label, col_currency) FROM stdin;
1	zero	0.0000
2	positive	12345.6789
3	negative	-99.9900
4	NULL	\N
\.


--
-- Data for Name: datetime_types; Type: TABLE DATA; Schema: public; Owner: replicator
--

COPY public.datetime_types (id, row_label, col_date) FROM stdin;
1	2026-01-15	2026-01-15 12:00:00
2	epoch	1899-12-30 00:00:00
3	NULL	\N
\.


--
-- Data for Name: decimal_types; Type: TABLE DATA; Schema: public; Owner: replicator
--

COPY public.decimal_types (id, row_label, col_currency, col_dec_0, col_dec_2, col_dec_6) FROM stdin;
1	zero	0.0000	0	0.00	0.000000
2	positive	12345.6789	42	123.45	0.123456
3	negative s0	\N	-7	\N	\N
4	negative s2	\N	\N	-99.99	\N
5	negative s6	\N	\N	\N	-0.000001
6	negative currency	-99.9900	\N	\N	\N
7	scale=6 small	\N	\N	\N	1.000001
8	NULL	\N	\N	\N	\N
\.


--
-- Data for Name: float_types; Type: TABLE DATA; Schema: public; Owner: replicator
--

COPY public.float_types (id, row_label, col_single, col_double) FROM stdin;
1	zero	0	0
2	pi	3.14159	3.14159265358979
3	negative	-0.00015	-2.225e-308
4	NULL	\N	\N
\.


--
-- Data for Name: guid_types; Type: TABLE DATA; Schema: public; Owner: replicator
--

COPY public.guid_types (id, row_label, col_guid) FROM stdin;
1	guid1	12345678-abcd-ef01-2345-6789abcdef01
2	zero	00000000-0000-0000-0000-000000000000
3	NULL	\N
\.


--
-- Data for Name: integer_types; Type: TABLE DATA; Schema: public; Owner: replicator
--

COPY public.integer_types (id, row_label, col_byte, col_int, col_long, col_bigint) FROM stdin;
1	zero	0	0	0	0
2	positive typical	128	32767	2147483647	9223372036854775807
3	negative	\N	-32768	-2147483648	-9223372036854775808
4	NULL	\N	\N	\N	\N
\.


--
-- Data for Name: text_types; Type: TABLE DATA; Schema: public; Owner: replicator
--

COPY public.text_types (id, row_label, col_text_50, col_memo) FROM stdin;
1	empty		
2	hello	Hello World	Long memo text
3	NULL	\N	\N
\.


--
-- PostgreSQL database dump complete
--

\unrestrict uPsrvABkFUDtH6hffC8GSShDi0HCDjuP0toE6EMNwWN4ulUSoabgL0TxeduXabA


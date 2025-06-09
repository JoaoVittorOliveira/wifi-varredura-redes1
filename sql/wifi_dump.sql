--
-- PostgreSQL database dump
--

-- Dumped from database version 14.18 (Ubuntu 14.18-0ubuntu0.22.04.1)
-- Dumped by pg_dump version 14.18 (Ubuntu 14.18-0ubuntu0.22.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
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
-- Name: wifi_scan; Type: TABLE; Schema: public; Owner: usuario
--

CREATE TABLE public.wifi_scan (
    id integer NOT NULL,
    ssid character varying(100),
    mac_ap character varying(20),
    quality_link integer,
    signal_level integer,
    channel integer,
    frequency numeric(5,2),
    last_beacon_ms integer,
    beacon_interval integer,
    wifi_security character varying(50),
    scan_time timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.wifi_scan OWNER TO usuario;

--
-- Name: wifi_scan_id_seq; Type: SEQUENCE; Schema: public; Owner: usuario
--

CREATE SEQUENCE public.wifi_scan_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wifi_scan_id_seq OWNER TO usuario;

--
-- Name: wifi_scan_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: usuario
--

ALTER SEQUENCE public.wifi_scan_id_seq OWNED BY public.wifi_scan.id;


--
-- Name: wifi_scan id; Type: DEFAULT; Schema: public; Owner: usuario
--

ALTER TABLE ONLY public.wifi_scan ALTER COLUMN id SET DEFAULT nextval('public.wifi_scan_id_seq'::regclass);


--
-- Data for Name: wifi_scan; Type: TABLE DATA; Schema: public; Owner: usuario
--

COPY public.wifi_scan (id, ssid, mac_ap, quality_link, signal_level, channel, frequency, last_beacon_ms, beacon_interval, wifi_security, scan_time) FROM stdin;
19	Zania	5c:df:89:85:01:c0	100	100	100	5.50	0	0		2025-06-06 17:36:50.916397
20	Zania	5c:df:89:85:01:c0	100	100	100	5.50	0	0		2025-06-06 17:37:51.040512
21	Zania	5c:df:89:85:01:c0	100	100	100	5.50	0	0		2025-06-06 17:38:51.153806
22	Zania	5c:df:89:85:01:c0	100	100	100	5.50	0	0		2025-06-06 17:39:51.276533
23	Zania	5c:df:89:85:01:c0	100	100	100	5.50	0	0		2025-06-06 17:40:51.388925
24	Zania	5c:df:89:85:01:c0	100	100	100	5.50	0	0		2025-06-06 17:41:51.501937
25	Zania	5c:df:89:85:01:c0	100	100	100	5.50	0	0		2025-06-06 17:42:51.616887
26	Raphael	80:86:44:54:9d:35	88	88	11	2.46	0	0		2025-06-06 18:24:03.493647
27	Raphael	80:86:44:54:9d:35	88	88	11	2.46	0	0		2025-06-06 18:25:03.633914
28	Raphael	80:86:44:54:9d:35	86	86	11	2.46	0	0		2025-06-06 18:26:03.763549
29	Raphael	80:86:44:54:9d:35	90	90	11	2.46	0	0		2025-06-06 18:27:03.885645
30	Raphael	80:86:44:54:9d:35	86	86	11	2.46	0	0		2025-06-06 18:28:04.006523
31	Raphael	80:86:44:54:9d:35	86	86	11	2.46	0	0		2025-06-06 18:29:04.118003
32	Raphael	80:86:44:54:9d:35	88	88	11	2.46	0	0		2025-06-06 18:30:04.231875
33	Raphael	80:86:44:54:9d:35	88	88	11	2.46	0	0		2025-06-06 18:31:04.402476
34	Raphael	80:86:44:54:9d:35	88	88	11	2.46	0	0		2025-06-06 18:32:04.522697
35	Raphael	80:86:44:54:9d:35	88	88	11	2.46	0	0		2025-06-06 18:33:04.646427
36	Raphael	80:86:44:54:9d:35	90	90	11	2.46	0	0		2025-06-06 18:34:04.761475
37	Raphael	80:86:44:54:9d:35	88	88	11	2.46	0	0		2025-06-06 18:35:04.880931
38	Raphael	80:86:44:54:9d:35	88	88	11	2.46	0	0		2025-06-06 18:36:04.987395
39	Raphael	80:86:44:54:9d:35	90	90	11	2.46	0	0		2025-06-06 18:37:05.101738
40	Raphael	80:86:44:54:9d:35	90	90	11	2.46	0	0		2025-06-06 18:38:05.217315
41	Raphael	80:86:44:54:9d:35	68	68	11	2.46	0	0		2025-06-06 18:39:05.391838
\.


--
-- Name: wifi_scan_id_seq; Type: SEQUENCE SET; Schema: public; Owner: usuario
--

SELECT pg_catalog.setval('public.wifi_scan_id_seq', 41, true);


--
-- Name: wifi_scan wifi_scan_pkey; Type: CONSTRAINT; Schema: public; Owner: usuario
--

ALTER TABLE ONLY public.wifi_scan
    ADD CONSTRAINT wifi_scan_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--


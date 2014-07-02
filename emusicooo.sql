--
-- PostgreSQL database dump
--

-- Dumped from database version 9.0.1
-- Dumped by pg_dump version 9.0.1
-- Started on 2014-07-02 04:22:50

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- TOC entry 357 (class 2612 OID 11574)
-- Name: plpgsql; Type: PROCEDURAL LANGUAGE; Schema: -; Owner: postgres
--

CREATE OR REPLACE PROCEDURAL LANGUAGE plpgsql;


ALTER PROCEDURAL LANGUAGE plpgsql OWNER TO postgres;

SET search_path = public, pg_catalog;

--
-- TOC entry 18 (class 1255 OID 17387)
-- Dependencies: 357 6
-- Name: fx_agregar_a_coleccion(integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION fx_agregar_a_coleccion(p_user integer, p_can integer, OUT p_result integer) RETURNS SETOF integer
    LANGUAGE plpgsql
    AS $$
DECLARE		
	m_col	record;
	m_result integer;
BEGIN 
	--buscamos si el usuario y l cancion ya estan rgistrados en favorita
	SELECT id_col INTO m_col  FROM "Coleccion" WHERE id_user = p_user AND id_can = p_can;

	IF m_col IS  NULL THEN
		INSERT INTO "Coleccion"(
			    id_user, id_can)
		    VALUES (p_user, p_can);

	END IF;

	
	m_result := 1;
	--RETURN QUERY SELECT m_Snro_exp_completo::text, m_doc_iide::integer;
	RETURN QUERY SELECT m_result::integer;
		
END;
$$;


ALTER FUNCTION public.fx_agregar_a_coleccion(p_user integer, p_can integer, OUT p_result integer) OWNER TO postgres;

--
-- TOC entry 19 (class 1255 OID 17388)
-- Dependencies: 357 6
-- Name: fx_agregar_amigo(integer, integer, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION fx_agregar_amigo(p_id_user integer, p_id_user_amigo integer, p_msg text, OUT p_result integer) RETURNS SETOF integer
    LANGUAGE plpgsql
    AS $$
DECLARE		
	m_user_ide integer;
	m_result integer;
BEGIN 
	
	INSERT INTO "SolicitudAmistad"(
            id_user1, id_user2, flg_sol, fch_envio_sol, fch_acept_sol, msg_sol)
	VALUES (p_id_user, p_id_user_amigo, 1, now(), now(), p_msg);

	--se deberia esperar a que el receptor acepte, por mientras no :)

	INSERT INTO "Amistad"(
	    id_user1, id_user2)
	VALUES (p_id_user, p_id_user_amigo);
	
	m_result := 1;
	

	--RETURN QUERY SELECT m_Snro_exp_completo::text, m_doc_iide::integer;
	RETURN QUERY SELECT m_result::integer;
		
END;
$$;


ALTER FUNCTION public.fx_agregar_amigo(p_id_user integer, p_id_user_amigo integer, p_msg text, OUT p_result integer) OWNER TO postgres;

--
-- TOC entry 20 (class 1255 OID 17389)
-- Dependencies: 357 6
-- Name: fx_agregar_musica(integer, text, text, text, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION fx_agregar_musica(p_id_user integer, p_nom_can text, p_let_can text, p_url_can text, p_id_art integer, p_id_cat integer, OUT p_result integer) RETURNS SETOF integer
    LANGUAGE plpgsql
    AS $$
DECLARE		
	m_user_ide integer;
	m_result integer;
BEGIN 
	SELECT id_user INTO m_user_ide FROM "Usuario" WHERE ema_user =  p_email;

	IF m_user_ide IS NULL THEN

		INSERT INTO "Usuario"(
		    use_user, pas_user, nom_user, ema_user, id_foto)
		VALUES (p_email, md5(p_pass), p_name, p_email, 2);
		
		m_result := 1;
	ELSE
		m_result := -1;
	END IF;	

	--RETURN QUERY SELECT m_Snro_exp_completo::text, m_doc_iide::integer;
	RETURN QUERY SELECT m_result::integer;
		
END;
$$;


ALTER FUNCTION public.fx_agregar_musica(p_id_user integer, p_nom_can text, p_let_can text, p_url_can text, p_id_art integer, p_id_cat integer, OUT p_result integer) OWNER TO postgres;

--
-- TOC entry 21 (class 1255 OID 17390)
-- Dependencies: 6 357
-- Name: fx_buscar_amigos(refcursor, integer, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION fx_buscar_amigos(refcursor, p_id integer, p_nom text) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $_$
DECLARE	
BEGIN
	OPEN $1 FOR SELECT U.id_user, U.nom_user, U.ema_user from "Usuario"  U
		--INNER JOIN "Usuario" U ON U.id_user = A.id_user2  
		WHERE U.nom_user ilike '%' || p_nom || '%' 
		AND U.id_user != p_id
		AND
		U.id_user NOT IN (SELECT U.id_user from "Amistad"  A
			INNER JOIN "Usuario" U ON U.id_user = A.id_user2  
			WHERE A.id_user1 = p_id);
	RETURN NEXT $1;
END;
$_$;


ALTER FUNCTION public.fx_buscar_amigos(refcursor, p_id integer, p_nom text) OWNER TO postgres;

--
-- TOC entry 22 (class 1255 OID 17391)
-- Dependencies: 6 357
-- Name: fx_cancion_registrar(text, text, text, integer, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION fx_cancion_registrar(p_name text, p_letra text, p_url text, p_artista integer, p_categoria integer, p_usuario integer, OUT p_result integer) RETURNS SETOF integer
    LANGUAGE plpgsql
    AS $$
DECLARE		
	m_user_ide integer;
	m_result integer;
BEGIN 
	
		INSERT INTO "Cancion"(
			 nom_can, let_can, id_cat, id_art, id_user, url_can)
			    VALUES (p_name, p_letra, p_categoria, p_artista, p_usuario,  p_url);
		
		
		m_result := 1;
	

	--RETURN QUERY SELECT m_Snro_exp_completo::text, m_doc_iide::integer;
	RETURN QUERY SELECT m_result::integer;
		
END;
$$;


ALTER FUNCTION public.fx_cancion_registrar(p_name text, p_letra text, p_url text, p_artista integer, p_categoria integer, p_usuario integer, OUT p_result integer) OWNER TO postgres;

--
-- TOC entry 23 (class 1255 OID 17392)
-- Dependencies: 6 357
-- Name: fx_listar_amigos(refcursor, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION fx_listar_amigos(refcursor, p_id integer) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $_$
DECLARE	
BEGIN
	OPEN $1 FOR SELECT U.id_user, U.nom_user, U.ema_user from "Amistad"  A
		INNER JOIN "Usuario" U ON U.id_user = A.id_user2  
		WHERE A.id_user1 = p_id;
	RETURN NEXT $1;
END;
$_$;


ALTER FUNCTION public.fx_listar_amigos(refcursor, p_id integer) OWNER TO postgres;

--
-- TOC entry 24 (class 1255 OID 17393)
-- Dependencies: 357 6
-- Name: fx_listar_artistas(refcursor); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION fx_listar_artistas(refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $_$
DECLARE	
	
	m_record record;
BEGIN 
	OPEN $1 FOR SELECT id_art, nom_art
		FROM "Artista" order by nom_art;		
	RETURN NEXT $1;

END;
$_$;


ALTER FUNCTION public.fx_listar_artistas(refcursor) OWNER TO postgres;

--
-- TOC entry 25 (class 1255 OID 17394)
-- Dependencies: 357 6
-- Name: fx_listar_canciones(refcursor); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION fx_listar_canciones(refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $_$
DECLARE	
	
	m_record record;
BEGIN 
	OPEN $1 FOR SELECT id_can, nom_can, let_can, url_can, ART.nom_art , CAT.nom_cat FROM "Cancion"  CAN
	INNER JOIN "Artista" ART ON ART.id_art = CAN.id_art
	INNER JOIN "Categoria" CAT ON CAT.id_cat = CAN.id_cat;		
	RETURN NEXT $1;

END;
$_$;


ALTER FUNCTION public.fx_listar_canciones(refcursor) OWNER TO postgres;

--
-- TOC entry 26 (class 1255 OID 17395)
-- Dependencies: 6 357
-- Name: fx_listar_categorias(refcursor); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION fx_listar_categorias(refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $_$
DECLARE	
	
	m_record record;
BEGIN 
	OPEN $1 FOR SELECT id_cat, nom_cat
		FROM "Categoria" order by nom_cat;		
	RETURN NEXT $1;

END;
$_$;


ALTER FUNCTION public.fx_listar_categorias(refcursor) OWNER TO postgres;

--
-- TOC entry 27 (class 1255 OID 17396)
-- Dependencies: 357 6
-- Name: fx_listar_coleccion(refcursor, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION fx_listar_coleccion(refcursor, p_id_user integer) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $_$
DECLARE	
	
	m_record record;
BEGIN 
	OPEN $1 FOR 

	SELECT * FROM (
		SELECT  CAN.id_can, CAN.pho_can, CAN.nom_can, CAN.let_can, CAN.url_can, ART.nom_art, CAT.nom_cat, FAV.fch_fav::date,
			CASE 
			WHEN FAV.cont_fav > 0 THEN FAV.cont_fav		
			ELSE 0
			END AS cont
		FROM "Coleccion" COL
		INNER JOIN "Cancion"  CAN ON COL.id_can = CAN.id_can
		INNER JOIN "Artista" ART ON ART.id_art = CAN.id_art
		INNER JOIN "Categoria" CAT ON CAT.id_cat = CAN.id_cat
		LEFT JOIN "Favorita" FAV ON FAV.id_user = COL.id_user AND FAV.id_can = COL.id_can
		WHERE COL.id_user = 	p_id_user ) result
	
	ORDER BY result.cont DESC;		
	RETURN NEXT $1;

END;
$_$;


ALTER FUNCTION public.fx_listar_coleccion(refcursor, p_id_user integer) OWNER TO postgres;

--
-- TOC entry 28 (class 1255 OID 17397)
-- Dependencies: 6 357
-- Name: fx_listar_detalle_cancion(refcursor, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION fx_listar_detalle_cancion(refcursor, p_id_can integer) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $_$
DECLARE	
	
	m_record record;
BEGIN 
	OPEN $1 FOR SELECT nom_can, let_can, url_can, ART.nom_art , CAT.nom_cat FROM "Cancion"  CAN
	INNER JOIN "Artista" ART ON ART.id_art = CAN.id_art
	INNER JOIN "Categoria" CAT ON CAT.id_cat = CAN.id_cat
	WHERE id_can = 	p_id_can;		
	RETURN NEXT $1;

END;
$_$;


ALTER FUNCTION public.fx_listar_detalle_cancion(refcursor, p_id_can integer) OWNER TO postgres;

--
-- TOC entry 29 (class 1255 OID 17398)
-- Dependencies: 357 6
-- Name: fx_listar_favoritas(refcursor, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION fx_listar_favoritas(refcursor, p_id_user integer) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $_$
DECLARE	
	
	m_record record;
BEGIN 
	OPEN $1 FOR SELECT FAV.id_fav, FAV.cont_fav, CAN.nom_can, CAN.let_can, CAN.url_can, ART.nom_art, CAT.nom_cat 
	FROM "Favorita" FAV
	INNER JOIN "Cancion"  CAN ON FAV.id_can = CAN.id_can
	INNER JOIN "Artista" ART ON ART.id_art = CAN.id_art
	INNER JOIN "Categoria" CAT ON CAT.id_cat = CAN.id_cat
	INNER JOIN "User" US ON US.id_user = CAN.id_user
	WHERE id_can = 	p_id_can;		
	RETURN NEXT $1;

END;
$_$;


ALTER FUNCTION public.fx_listar_favoritas(refcursor, p_id_user integer) OWNER TO postgres;

--
-- TOC entry 30 (class 1255 OID 17399)
-- Dependencies: 357 6
-- Name: fx_log_reproduccion(integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION fx_log_reproduccion(p_user integer, p_can integer, OUT p_result integer) RETURNS SETOF integer
    LANGUAGE plpgsql
    AS $$
DECLARE		
	m_fav	record;
	m_result integer;
BEGIN 
	--buscamos si el usuario y l cancion ya estan rgistrados en favorita
	SELECT id_fav, cont_fav, fch_fav INTO m_fav m_ide FROM "Favorita" WHERE id_user = p_user AND id_can = p_can;

	IF m_fav IS NOT NULL THEN

		UPDATE "Favorita"
		   SET cont_fav=  cont_fav + 1, fch_fav=now()
		 WHERE id_user = p_user AND id_can = p_can;
	ELSE

		INSERT INTO "Favorita"(
			    id_user, id_can, cont_fav, fch_fav)
		    VALUES (p_user, p_can, 1, now());

	END IF;

	
	m_result := 1;
	--RETURN QUERY SELECT m_Snro_exp_completo::text, m_doc_iide::integer;
	RETURN QUERY SELECT m_result::integer;
		
END;
$$;


ALTER FUNCTION public.fx_log_reproduccion(p_user integer, p_can integer, OUT p_result integer) OWNER TO postgres;

--
-- TOC entry 31 (class 1255 OID 17400)
-- Dependencies: 357 6
-- Name: fx_login(refcursor, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION fx_login(refcursor, p_valias text, p_vclave text) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $_$
DECLARE	
BEGIN
	OPEN $1 FOR SELECT id_user, nom_user from "Usuario" WHERE use_user = p_valias AND pas_user = md5(p_vclave);		
	RETURN NEXT $1;
END;
$_$;


ALTER FUNCTION public.fx_login(refcursor, p_valias text, p_vclave text) OWNER TO postgres;

--
-- TOC entry 32 (class 1255 OID 17401)
-- Dependencies: 6 357
-- Name: fx_user_register(text, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION fx_user_register(p_name text, p_email text, p_pass text, OUT p_result integer) RETURNS SETOF integer
    LANGUAGE plpgsql
    AS $$
DECLARE		
	m_user_ide integer;
	m_result integer;
BEGIN 
	SELECT id_user INTO m_user_ide FROM "Usuario" WHERE ema_user =  p_email;

	IF m_user_ide IS NULL THEN

		INSERT INTO "Usuario"(
		    use_user, pas_user, nom_user, ema_user, id_foto)
		VALUES (p_email, md5(p_pass), p_name, p_email, 2);
		
		m_result := 1;
	ELSE
		m_result := -1;
	END IF;	

	--RETURN QUERY SELECT m_Snro_exp_completo::text, m_doc_iide::integer;
	RETURN QUERY SELECT m_result::integer;
		
END;
$$;


ALTER FUNCTION public.fx_user_register(p_name text, p_email text, p_pass text, OUT p_result integer) OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 1549 (class 1259 OID 17402)
-- Dependencies: 6
-- Name: Amistad; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "Amistad" (
    id_amis integer NOT NULL,
    id_user1 integer,
    id_user2 integer
);


ALTER TABLE public."Amistad" OWNER TO postgres;

--
-- TOC entry 1550 (class 1259 OID 17405)
-- Dependencies: 6 1549
-- Name: Amistad_id_amis_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "Amistad_id_amis_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Amistad_id_amis_seq" OWNER TO postgres;

--
-- TOC entry 1905 (class 0 OID 0)
-- Dependencies: 1550
-- Name: Amistad_id_amis_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "Amistad_id_amis_seq" OWNED BY "Amistad".id_amis;


--
-- TOC entry 1906 (class 0 OID 0)
-- Dependencies: 1550
-- Name: Amistad_id_amis_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"Amistad_id_amis_seq"', 7, true);


--
-- TOC entry 1551 (class 1259 OID 17407)
-- Dependencies: 6
-- Name: Artista; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "Artista" (
    id_art integer NOT NULL,
    nom_art character varying NOT NULL
);


ALTER TABLE public."Artista" OWNER TO postgres;

--
-- TOC entry 1552 (class 1259 OID 17413)
-- Dependencies: 1551 6
-- Name: Artista_id_art_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "Artista_id_art_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Artista_id_art_seq" OWNER TO postgres;

--
-- TOC entry 1907 (class 0 OID 0)
-- Dependencies: 1552
-- Name: Artista_id_art_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "Artista_id_art_seq" OWNED BY "Artista".id_art;


--
-- TOC entry 1908 (class 0 OID 0)
-- Dependencies: 1552
-- Name: Artista_id_art_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"Artista_id_art_seq"', 12, true);


--
-- TOC entry 1553 (class 1259 OID 17415)
-- Dependencies: 6
-- Name: Cancion; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "Cancion" (
    id_can integer NOT NULL,
    nom_can character varying NOT NULL,
    let_can character varying NOT NULL,
    id_cat integer NOT NULL,
    id_art integer NOT NULL,
    id_user integer NOT NULL,
    url_can character varying,
    pho_can character varying
);


ALTER TABLE public."Cancion" OWNER TO postgres;

--
-- TOC entry 1554 (class 1259 OID 17421)
-- Dependencies: 6 1553
-- Name: Cancion_id_can_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "Cancion_id_can_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Cancion_id_can_seq" OWNER TO postgres;

--
-- TOC entry 1909 (class 0 OID 0)
-- Dependencies: 1554
-- Name: Cancion_id_can_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "Cancion_id_can_seq" OWNED BY "Cancion".id_can;


--
-- TOC entry 1910 (class 0 OID 0)
-- Dependencies: 1554
-- Name: Cancion_id_can_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"Cancion_id_can_seq"', 25, true);


--
-- TOC entry 1555 (class 1259 OID 17423)
-- Dependencies: 6
-- Name: Categoria; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "Categoria" (
    id_cat integer NOT NULL,
    nom_cat character varying NOT NULL
);


ALTER TABLE public."Categoria" OWNER TO postgres;

--
-- TOC entry 1556 (class 1259 OID 17429)
-- Dependencies: 1555 6
-- Name: Categoria_id_cat_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "Categoria_id_cat_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Categoria_id_cat_seq" OWNER TO postgres;

--
-- TOC entry 1911 (class 0 OID 0)
-- Dependencies: 1556
-- Name: Categoria_id_cat_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "Categoria_id_cat_seq" OWNED BY "Categoria".id_cat;


--
-- TOC entry 1912 (class 0 OID 0)
-- Dependencies: 1556
-- Name: Categoria_id_cat_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"Categoria_id_cat_seq"', 8, true);


--
-- TOC entry 1557 (class 1259 OID 17431)
-- Dependencies: 6
-- Name: Coleccion; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "Coleccion" (
    id_col integer NOT NULL,
    id_user integer,
    id_can integer
);


ALTER TABLE public."Coleccion" OWNER TO postgres;

--
-- TOC entry 1558 (class 1259 OID 17434)
-- Dependencies: 6 1557
-- Name: Coleccion_id_col_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "Coleccion_id_col_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Coleccion_id_col_seq" OWNER TO postgres;

--
-- TOC entry 1913 (class 0 OID 0)
-- Dependencies: 1558
-- Name: Coleccion_id_col_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "Coleccion_id_col_seq" OWNED BY "Coleccion".id_col;


--
-- TOC entry 1914 (class 0 OID 0)
-- Dependencies: 1558
-- Name: Coleccion_id_col_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"Coleccion_id_col_seq"', 17, true);


--
-- TOC entry 1559 (class 1259 OID 17436)
-- Dependencies: 1851 6
-- Name: Favorita; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "Favorita" (
    id_fav integer NOT NULL,
    id_user integer,
    id_can integer,
    cont_fav integer,
    fch_fav timestamp without time zone DEFAULT now()
);


ALTER TABLE public."Favorita" OWNER TO postgres;

--
-- TOC entry 1560 (class 1259 OID 17440)
-- Dependencies: 6 1559
-- Name: Favorita_id_fav_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "Favorita_id_fav_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Favorita_id_fav_seq" OWNER TO postgres;

--
-- TOC entry 1915 (class 0 OID 0)
-- Dependencies: 1560
-- Name: Favorita_id_fav_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "Favorita_id_fav_seq" OWNED BY "Favorita".id_fav;


--
-- TOC entry 1916 (class 0 OID 0)
-- Dependencies: 1560
-- Name: Favorita_id_fav_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"Favorita_id_fav_seq"', 15, true);


--
-- TOC entry 1561 (class 1259 OID 17442)
-- Dependencies: 6
-- Name: Foto; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "Foto" (
    id_foto integer NOT NULL,
    img_foto bytea,
    "idUser" integer NOT NULL,
    id_can integer NOT NULL
);


ALTER TABLE public."Foto" OWNER TO postgres;

--
-- TOC entry 1562 (class 1259 OID 17448)
-- Dependencies: 6 1561
-- Name: Foto_id_foto_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "Foto_id_foto_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Foto_id_foto_seq" OWNER TO postgres;

--
-- TOC entry 1917 (class 0 OID 0)
-- Dependencies: 1562
-- Name: Foto_id_foto_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "Foto_id_foto_seq" OWNED BY "Foto".id_foto;


--
-- TOC entry 1918 (class 0 OID 0)
-- Dependencies: 1562
-- Name: Foto_id_foto_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"Foto_id_foto_seq"', 1, false);


--
-- TOC entry 1563 (class 1259 OID 17450)
-- Dependencies: 6
-- Name: Parametro; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "Parametro" (
    id_par integer NOT NULL,
    cod_par character varying,
    des_par character varying,
    val_par character varying
);


ALTER TABLE public."Parametro" OWNER TO postgres;

--
-- TOC entry 1564 (class 1259 OID 17456)
-- Dependencies: 6 1563
-- Name: Parametro_id_par_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "Parametro_id_par_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Parametro_id_par_seq" OWNER TO postgres;

--
-- TOC entry 1919 (class 0 OID 0)
-- Dependencies: 1564
-- Name: Parametro_id_par_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "Parametro_id_par_seq" OWNED BY "Parametro".id_par;


--
-- TOC entry 1920 (class 0 OID 0)
-- Dependencies: 1564
-- Name: Parametro_id_par_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"Parametro_id_par_seq"', 2, true);


--
-- TOC entry 1565 (class 1259 OID 17458)
-- Dependencies: 6
-- Name: SolicitudAmistad; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "SolicitudAmistad" (
    id_sol integer NOT NULL,
    id_user1 integer,
    id_user2 integer,
    flg_sol integer,
    fch_envio_sol timestamp without time zone,
    fch_acept_sol timestamp without time zone,
    msg_sol text
);


ALTER TABLE public."SolicitudAmistad" OWNER TO postgres;

--
-- TOC entry 1566 (class 1259 OID 17464)
-- Dependencies: 6 1565
-- Name: SolicitudAmistad_id_sol_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "SolicitudAmistad_id_sol_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."SolicitudAmistad_id_sol_seq" OWNER TO postgres;

--
-- TOC entry 1921 (class 0 OID 0)
-- Dependencies: 1566
-- Name: SolicitudAmistad_id_sol_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "SolicitudAmistad_id_sol_seq" OWNED BY "SolicitudAmistad".id_sol;


--
-- TOC entry 1922 (class 0 OID 0)
-- Dependencies: 1566
-- Name: SolicitudAmistad_id_sol_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"SolicitudAmistad_id_sol_seq"', 4, true);


--
-- TOC entry 1567 (class 1259 OID 17466)
-- Dependencies: 6
-- Name: Usuario; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "Usuario" (
    id_user integer NOT NULL,
    use_user character varying NOT NULL,
    pas_user character varying NOT NULL,
    nom_user character varying,
    ema_user character varying,
    dob_user date,
    id_foto integer NOT NULL
);


ALTER TABLE public."Usuario" OWNER TO postgres;

--
-- TOC entry 1568 (class 1259 OID 17472)
-- Dependencies: 6 1567
-- Name: Usuario_id_user_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "Usuario_id_user_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Usuario_id_user_seq" OWNER TO postgres;

--
-- TOC entry 1923 (class 0 OID 0)
-- Dependencies: 1568
-- Name: Usuario_id_user_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "Usuario_id_user_seq" OWNED BY "Usuario".id_user;


--
-- TOC entry 1924 (class 0 OID 0)
-- Dependencies: 1568
-- Name: Usuario_id_user_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"Usuario_id_user_seq"', 33, true);


--
-- TOC entry 1846 (class 2604 OID 17474)
-- Dependencies: 1550 1549
-- Name: id_amis; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE "Amistad" ALTER COLUMN id_amis SET DEFAULT nextval('"Amistad_id_amis_seq"'::regclass);


--
-- TOC entry 1847 (class 2604 OID 17475)
-- Dependencies: 1552 1551
-- Name: id_art; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE "Artista" ALTER COLUMN id_art SET DEFAULT nextval('"Artista_id_art_seq"'::regclass);


--
-- TOC entry 1848 (class 2604 OID 17476)
-- Dependencies: 1554 1553
-- Name: id_can; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE "Cancion" ALTER COLUMN id_can SET DEFAULT nextval('"Cancion_id_can_seq"'::regclass);


--
-- TOC entry 1849 (class 2604 OID 17477)
-- Dependencies: 1556 1555
-- Name: id_cat; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE "Categoria" ALTER COLUMN id_cat SET DEFAULT nextval('"Categoria_id_cat_seq"'::regclass);


--
-- TOC entry 1850 (class 2604 OID 17478)
-- Dependencies: 1558 1557
-- Name: id_col; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE "Coleccion" ALTER COLUMN id_col SET DEFAULT nextval('"Coleccion_id_col_seq"'::regclass);


--
-- TOC entry 1852 (class 2604 OID 17479)
-- Dependencies: 1560 1559
-- Name: id_fav; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE "Favorita" ALTER COLUMN id_fav SET DEFAULT nextval('"Favorita_id_fav_seq"'::regclass);


--
-- TOC entry 1853 (class 2604 OID 17480)
-- Dependencies: 1562 1561
-- Name: id_foto; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE "Foto" ALTER COLUMN id_foto SET DEFAULT nextval('"Foto_id_foto_seq"'::regclass);


--
-- TOC entry 1854 (class 2604 OID 17481)
-- Dependencies: 1564 1563
-- Name: id_par; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE "Parametro" ALTER COLUMN id_par SET DEFAULT nextval('"Parametro_id_par_seq"'::regclass);


--
-- TOC entry 1855 (class 2604 OID 17482)
-- Dependencies: 1566 1565
-- Name: id_sol; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE "SolicitudAmistad" ALTER COLUMN id_sol SET DEFAULT nextval('"SolicitudAmistad_id_sol_seq"'::regclass);


--
-- TOC entry 1856 (class 2604 OID 17483)
-- Dependencies: 1568 1567
-- Name: id_user; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE "Usuario" ALTER COLUMN id_user SET DEFAULT nextval('"Usuario_id_user_seq"'::regclass);


--
-- TOC entry 1890 (class 0 OID 17402)
-- Dependencies: 1549
-- Data for Name: Amistad; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "Amistad" (id_amis, id_user1, id_user2) FROM stdin;
1	4	19
2	4	20
3	20	4
4	24	25
5	4	5
6	4	27
7	4	25
\.


--
-- TOC entry 1891 (class 0 OID 17407)
-- Dependencies: 1551
-- Data for Name: Artista; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "Artista" (id_art, nom_art) FROM stdin;
1	Stratovarius
2	Sirenia
3	Loquillo y los trogloditas
4	Paramore
5	Adele
6	Plan B
7	Dolores delirio
8	Glut
9	Rio roma
10	Balvin
11	x-dinero
12	Showtek
\.


--
-- TOC entry 1892 (class 0 OID 17415)
-- Dependencies: 1553
-- Data for Name: Cancion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "Cancion" (id_can, nom_can, let_can, id_cat, id_art, id_user, url_can, pho_can) FROM stdin;
22	Mama No Me Quiero Casar	uuuuuuhhhhhhhhh ohhhhhhh \nMamá no quiero mas novia \nmamá no me quiero casar \ndicen que después engordan \ny reniegan peor que papá \n\nun día mi padre me dijo \nque tenga cien novias o mas \nde esas cien yo escoja \na la que el corazón quiera mas \nvoy por la 99 \ny te juro q voy a llegar \nvoy por la 99 viejo \nparece se acerca el altar \n\nmama no quiero mas novia \nmama no me quiero casar \ndicen que después engordan \ny reniegan peor que papá \n\nquiero viajar por el mundo en una balsita \nquiero tocar como el loco de la calesita \nquiero volar como tango el flaco y abuelo \ny ser el rey como charlie y su antena de acero \namor oh amor \n\nmama no me quiero casar \ny reniegan peor que papá \n\nuno de mas de el esta ciego \nle hice perder la cabeza \nse fue al baño y se fumo \ny empezó a sonar las botellas(x2)                     	1	11	4	https://www.youtube.com/embed/yVjZ7uJMsro	\N
3	Lithium and a lover	When all my demons set their sails\nAnd my mind is riding the last train\nDown a one-way track to the final station\nDestination, devastation\n\n[Foreign content]\n\nA thousand demons at my door\nScreaming at my crumbling walls\nMy river's bleeding, my fields are burning\nMy world has stopped turning\n\n[Foreign content]\n\nI will be your lithium\nAnd I'll be your lover\n\nGive me something for my mind\nSomething for the pain inside\nA remedy, a cure for life\nAn elixir for this manica of mine\n\nGive me what I'm deep in need of\nA sanctuary beyond this cruel world\nA peerless cure-all to recover\nLike lithium and a lover\n	2	2	4	https://www.youtube.com/embed/07G2Fzj3riU	\N
6	Black diamond	Again I see you standing there watching me.\nYour gaze, those eyes are tantalizing openly, inviting me to get close to you,\ncan't help myself.\nThere's fascination in the air.\nI try to fight this strong sensation but there's no chance to escape\nfrom this temptation.\nFeels like I've known you before, repeating phrases,\nbut I yearn for something more.\nI know I can't stay by your side forever,\nbut I know I won't forget your beauty,\nmy Black Diamond. 	2	1	4	https://www.youtube.com/embed/lNLdTfwx5ZQ	\N
7	La matare	Yo la sentaba en mi regazo,\nenloquecía sólo a su contacto.\nLa he conservado en la memoria.\nTal como estaba.\nSiempre a mi lado.\nNunca me juró su amor\nlo creía eterno yo.\nY ella me sonreía y\nmiraba hacia el mar.\n\nMe emborrachaba entre sus brazos\nella nunca bebía, ni la vi llorando,\nyo hubiera muerto por su risa.\nHubiera sido su feliz esclavo.\nQué dolor sucio y traidor\nme envenena el corazón.\nSé que ella nunca enloqueció.\nJamás perdió el control.\n\nQuiero verla bailar entre los muertos,\nla cintura morena que me volvió loco,\nllevo un velo de sangre en la mirada,\ny un deseo en el alma,\nque jamás la encuentre.\nSólo quiero que una vez\nalgo la haga conmover.\nQue no la encuentre jamás\no sé que la mataré.\n\nPor favor sólo quiero matarla.\nA punta de navaja\nBesándola una vez más.	1	3	4	https://www.youtube.com/embed/9m5N2Ffi3aI	\N
8	Decode	How can I decide what's right?\nWhen you're clouding up my mind\nI can't win your losing fight all the time\nHow can I ever own what's mine\nWhen you're always taking sides\nBut you won't take away my pride\nNo not this time\nNot this time\n\nHow did we get here?\nWell I used to know you so well\nHow did we get here?\nWell I think I know\n\nThe truth is hiding in your eyes\nAnd its hanging on your tongue\nJust boiling in my blood\nBut you think that I can't see\nWhat kind of man that you are\nIf you're a man at all\nWell I will figure this one out\nOn my own\n(I'm screaming "I love you so")\nOn my own\n(My thoughts you can't decode)\n\nHow did we get here?\nWell I used to know you so well, yeah\nHow did we get here?\nWell I think I know\n\nDo you see what we've done?\nWe've gone and made such fools of ourselves\nDo you see what we've done?\nWe've gone and made such fools of ourselves\n\nYeah...!\n\nHow did we get here?\nWell I used to know you so well, yeah yeah\nHow did we get here?\nWell I used to know you so well\n\nI think I know\nI think I know\n\nOoh, there is something\nI see in you\nIt might kill me\nI want it to be true	5	4	4	https://www.youtube.com/embed/RvnkAtWcKYg	\N
14	Carmen	Carmen se mira al espejo\ny se miente una vez más\nbusca lo que perdió en su decisión.\nY se juzga y se condena\nmil cadenas perpetuas\nsu vientre vacío a golpe de sangre y acero.\nCarmen confusa de amor\nen una noche de alcohol\nhizo una fiesta en el jardín.\nA medianoche es tan fácil\nes tan fácil caer, y luego el miedo\nmejor muerte al intruso\nque aún me queda tiempo de ser feliz.\nCarmen se mira al espejo y ve su ombligo\ntan grande, tan vacío\nun campo donde perdió la libertad.\nY se juzga y se condena\nmil cadenas perpetuas\nsu vientre vacío\na golpe de sangre y acero.\nCarmen maldice el calendario\njuega sola, llora y se derrota.\nCarmen se mira al espejo\ny se miente una vez más\nbusca lo que perdió en su decisión.\nY se juzga y se condena\nmil cadenas perpetuas\nsu vientre vacío a golpe de sangre y acero.\nCarmen confusa de amor\nen una noche de alcohol\nhizo una fiesta en el jardín.\nA medianoche es tan fácil\nes tan fácil caer, y luego el miedo\nmejor muerte al intruso\nque aún me queda tiempo de ser feliz.\nCarmen se mira al espejo y ve su ombligo\ntan grande, tan vacío\nun campo donde perdió la libertad.\nY se juzga y se condena\nmil cadenas perpetuas\nsu vientre vacío\na golpe de sangre y acero.\nCarmen maldice el calendario\njuega sola, llora y se derrota.	1	7	4	https://www.youtube.com/embed/n9BKG-__IDo	\N
23	Ella besa asi	a pelearr.......... \neh eh eh eh eh..... \nsoy un borracho \ny me duele ser así \nsoy un adicto \ny me apena ser así \nesta vida me ha tratado con dureza \nporque nunca me ensañaron a mentir \nhan pasado mil mujeres por mi vida \npero nunca nunca me olvide de ti ohhhhhhh \n\nporque ella besa así \nyo no puedo olvidarla oye yo no \nporque ella besa así \nsi yo no quiero recordala oye ya no \nporque ella besa así \nhan pasado mil mujeres por mi vida \nporque ella besa así \n\nsoy un enfermo \ny no hay remedios para mi \nsoy muy ardiente \nporque llevo algo de ti \nhan pasado ya los años de esta vida \nentre juergas malhechores y canciones \nya no fumo ya no bebo demasiado \ny esto solo yo lo quiero hacer por mi \n\nporque ella besa así \nyo no puedo olvidarla oye yo no \nporque ella besa así \nya no quiero recordala oye ya no \nporque ella besa así \nhan pasado mil mujeres por mi vida \nporque ella besa así \nesta vida ya deje de toda joda \nporque ella besa así \nla verdad yo ya no puedo oye flaco \nporque ella besa así \nya no quiero cruzarla en mi trabajo \nporque ella besa así \nya no aguanto toa una vida flaco \nporque ella besa así \nuoohh ohhh \nporque ella besa así (x ..)                         	1	11	4	https://www.youtube.com/embed/Lq_04zWv5ZM	\N
10	Someone Like You	I heard that you're settled down\nThat you found a girl and you're married now.\nI heard that your dreams came true.\nGuess she gave you things I didn't give to you.\n\nOld friend, why are you so shy?\nAin't like you to hold back or hide from the light.\n\nI hate to turn up out of the blue uninvited\nBut I couldn't stay away, I couldn't fight it.\nI had hoped you'd see my face and that you'd be reminded\nThat for me it isn't over.\n\nNever mind, I'll find someone like you\nI wish nothing but the best for you too\nDon't forget me, I beg\nI'll remember you said,\n"Sometimes it lasts in love but sometimes it hurts instead,\nSometimes it lasts in love but sometimes it hurts instead"\n\nYou know how the time flies\nOnly yesterday was the time of our lives\nWe were born and raised\nIn a summer haze\nBound by the surprise of our glory days\n\nI hate to turn up out of the blue uninvited\nBut I couldn't stay away, I couldn't fight it.\nI'd hoped you'd see my face and that you'd be reminded\nThat for me it isn't over.\n\nNever mind, I'll find someone like you\nI wish nothing but the best for you too\nDon't forget me, I beg\nI'll remember you said,\n"Sometimes it lasts in love but sometimes it hurts instead."\n\nNothing compares\nNo worries or cares\nRegrets and mistakes\nThey are memories made.\nWho would have known how bittersweet this would taste?\n\nNever mind, I'll find someone like you\nI wish nothing but the best for you too\nDon't forget me, I beg\nI'll remember you said,\n"Sometimes it lasts in love but sometimes it hurts instead."\n\nNever mind, I'll find someone like you\nI wish nothing but the best for you too\nDon't forget me, I beg\nI'll remember you said,\n"Sometimes it lasts in love but sometimes it hurts instead,\nSometimes it lasts in love but sometimes it hurts instead	6	5	4	https://www.youtube.com/embed/hLQl3WQQoQ0	\N
12	Candy	"Candy, candy, candy"\nEy, ella le gusta vacilar todos los weekends irse janguear,\nElla es loquita pero es dulce como Candy,\nSus pai la quieren ver casada que ella termine la escuela,\nPero ella cambia más de novio que de panty (x2)\n\nLe gusta a lo kirking notty y aunque sea fancy,\nSe pone cranky si lo hago romantic,\nLe gusta el sexo en exceso,\nY en el proceso me pide un beso.\n\nKirking notty y aunque sea fancy,\nSe pone cranky si lo hago romantic,\nLe gusta el sexo en exceso,\nY en el proceso me pide un beso.\n\nLa veo en la disco casi todos los weekends,\nAl parecer en su casa no hay quien la frene,\nEl vacilón de ella comienza desde el jueves,\nTiene un amigo en el barrio al parecer no la entretiene.\n\nSe hace la boba sabe que lo que le conviene,\nSu abuela le da money cada vez que quiere,\nEstá solita ella no quiere que la celen,\nMuchos la han querido para serio pero a ella le va y le viene.\n\nPide que la empuje, que el pelo le desordene,\nQue la encadene que a la cama la condene,\nEl comentario se ha regado que ella gana por knock out,\nAl parecer ella invicta se mantiene.\n\nLe gusta a lo kirking notty y aunque sea fancy,\nSe pone cranky si lo hago romantic,\nLe gusta el sexo en exceso,\nY en el proceso me pide un beso.\n\nKirking notty y aunque sea fancy,\nSe pone cranky si lo hago romantic,\nLe gusta el sexo en exceso,\nY en el proceso me pide un beso.\n\nElla es diferente no vive con la gente,\nY no le hace caso si le saca el expediente,\nY todos quieren probarla porque dicen que es caliente,\nUn filling una cerveza para entrar en ambiente.\n\nBaila todas las canciones y tiene un swing cuando se mueve,\nY no tiene amigas deja que todas la envidian,\nDice maldita la mujer en que otra mujer confía,\nPor eso se rodea de amiguitos todos los días.\n\nEsa nena que tu ves ya no es una chamaquita,\nAunque la veas con carita de nenita,\nYa medio barrio la ha probado dicen que el novio esta trancado\nEn la calle por eso es que anda bien loquita.\n\nLa abuela de ella jura que es una angelita,\nInsulta a todo el que hable mal de su nietecita,\nAunque al medio la han tirado a ella no le ha importado,\nSigue con el vacilón y no se quita.\n\nLe gusta a lo kirking notty y aunque sea fancy,\nSe pone cranky si lo hago romantic,\nLe gusta el sexo en exceso,\nY en el proceso me pide un beso.\n\nKirking notty y aunque sea fancy,\nSe pone cranky si lo hago romantic,\nLe gusta el sexo en exceso,\nY en el proceso me pide un beso.\n\nChencho y Maldy Plan B, Plan B, Plan B,\nLuny, Luny, Luny, Luny, Luny, Luny Tunes, Tunes...\nLa sociedad, una vez más se enciende el party...\n\nY vamos para la calle, el dúo de sex,\nLove and Sex, la Society, lo que saben bien,\nCon un poco de Reggaetonton, con un poco de Reggaetonton,\nCon el Luny, Luny, Luny Tunes, Tunes,\nDile, Dile, Dile Duran The Coach..\nChencho y Maldy Plan B\nPina Records... Le gusta, Le gusta, Le gusta..."Candy, candy, candy"\nElla le gusta vacilar todos los weekends y sanguear,\nElla es loquita pero es dulce como Candy,\nSu pai la quiere en mi casa que ella termine la escuela,\nPero ella cambia más de novio que de panty (x2)\n\nLe gusta a lo Kirking Natty y aunque sea fancy,\nSe pone tranqui si lo hago romanti,\nLe gusta el sexo en exceso,\nY en el proceso me pide un beso.\n\nKirking Natty y aunque sea fancy,\nSe pone tranqui si lo hago romanti,\nLe gusta el sexo en exceso,\nY en el proceso me pide un beso.\n\nLa veo en la disco casi todos los weekends,\nAl parecer en su casa no hay quien la frene,\nEl vacilón de ella comienza desde el jueves,\nTiene un amigo en el barrio al parecer no la entretiene.\n\nSe hace la boba sabe que lo que le conviene,\nSu abuela le da money cada vez que quiere,\nEstá solita ella no quiere que la celen,\nMuchos la han querido para serio pero a ella le va y le viene.\n\nPide que la empuje, que el pelo le desordene,\nQue la encadene que a la cama la condene,\nEl comentario se ha regado que ella gana por knock out,\nAl parecer ella invicta se mantiene.\n\nLe gusta a lo Kirking Natty y aunque sea fancy,\nSe pone tranqui si lo hago romanti,\nLe gusta el sexo en exceso,\nY en el proceso me pide un beso.\n\nKirking Natty y aunque sea fancy,\nSe pone tranqui si lo hago romanti,\nLe gusta el sexo en exceso,\nY en el proceso me pide un beso.\n\nElla es diferente no vive con la gente,\nY no le hace caso si le saca el expediente,\nY todos quieren probarla porque dicen que es caliente,\nUn filling una cerveza para entrar en ambiente.\n\nBaila todas las canciones y tiene un swing cuando se mueve,\nY no tiene amigas deja que todas la envidian,\nDice maldita la mujer en que otra mujer confía,\nPor eso se rodea de amiguitos todos los días.\n\nEsa nena que tu ves ya no es una chamaquita,\nAunque la veas con carita de nenita,\nYa medio barrio la ha probado dicen que el novio esta trancado\nEn la calle por eso es que anda bien loquita.\n\nLa abuela de ella jura que es una angelita,\nInsulta a todo el que hable mal de su nietecita,\nAunque al medio la han tirado a ella no le ha importado,\nSigue con el vacilón y no se quita.\n\nLe gusta a lo Kirking Natty y aunque sea fancy,\nSe pone tranqui si lo hago romanti,\nLe gusta el sexo en exceso,\nY en el proceso me pide un beso.\n\nKirking Natty y aunque sea fancy,\nSe pone tranqui si lo hago romanti,\nLe gusta el sexo en exceso,\nY en el proceso me pide un beso.\n\nChencho y Maldy Plan B, Plan B, Plan B,\nLuny, Luny, Luny, Luny, Luny, Tunes Tunes...\nLa sociedad una vez más se enciende el party...\n\nY vamos para la calle, el dúo de sex,\nLove and Sex, The Society, lo que saben bien,\nCon un poco de Reggaetonton, con un poco de Reggaetonton,\nCon el Luny, Luny, Luny Tunes, Tunes,\nDile, Dile, Dile Duran The Coach..\nChencho y Maldy Plan B\nPina Records... Le gusta, Le gusta, Le gusta...	7	6	4	https://www.youtube.com/embed/9FWgcBfs5A0	\N
15	Enamorado de ti	Hay amores en la vida que no se puede olvidar\nhay lugares en la vida que no se deben olvidar\ny ahi estoy yo con mis ojos\ny ahi estoy yo con mi cara de tonto\ny ahi estoy yo junto a ti!\n\nenamorado de ti mi amor\nenamorado de ti my love\nenamorado de ti ma chérie\nenamorado de tus ojos..woohohoh\n\nhay personas en la vida que no se pueden olvidar\nhay cariños en la vida que no se quieren olvidar\ny ai estoy yo con mis ojos\ny ahi estoy yo con mi cara de tonto\ny ahi estoy yo junto a ti\n\nenamorado de ti mi amor\nenamorado de ti my love\nenamorado de ti ma chérie(mon cherri)\nenamorado de tus ojos..woohohoh\n\n(trompetas)\n\ny ai estoy yo con mis ojos\ny ahi estoy yo con mi cara de tonto\ny ahi estoy yo junto a ti\n\nenamorado de ti mi amor\nenamorado de ti my love\nenamorado de ti ma chérie\nenamorado de ti mi amor\nenamorado de ti my love\nenamorado de ti ma chérie\nenamorado de tus ojos..woohohoh\n\nenamorado de ti mi amor\nenamorado de ti my love\nenamorado de ti ma chérie\nenamorado de tus ojos..woohohoh	1	8	4	https://www.youtube.com/embed/jbS_-fpcIC4	\N
18	Tu me cambiaste la vida	Fue un día como cualquiera, nunca olvidaré la fecha\nCoincidimos sin pensar en tiempo y en lugar\nAlgo mágico pasó, tu sonrisa me atrapó\nSin permiso me robaste el corazón\nY así sin decirnos nada con una simple mirada comenzaba nuestro amor\nTú me cambiaste la vida desde que llegaste a mi\nEres el sol que ilumina todo mi existir\nEres un sueño perfecto, todo lo encuentro en ti\nTú me cambiaste la vida por ti es que he vuelto a creer\nAhora sólo tus labios encienden mi piel\nHoy ya no hay dudas aquí, el miedo se fue de mí\nY todo gracias a ti\n\nTan hermosa eres por fuera como nadie en la tierra\nY en tu interior habita la nobleza y la bondad\nHoy la palabra amor tiene otra dimensión\nDía y noche pido el cielo por los dos\nAhora todo es tan claro es a ti a quien yo amo\nMe devolviste la ilusión\nTú me cambiaste la vida desde que llegaste a mi\nEres el sol que ilumina todo mi existir\nEres un sueño perfecto, todo lo encuentro en ti\nTú me cambiaste la vida por ti es que he vuelto a creer\nAhora sólo tus labios encienden mi piel\nHoy ya no hay dudas aquí, el miedo se fue de mí\nY todo gracias a ti	6	9	4	https://www.youtube.com/embed/_X3PPuF_yOE	\N
19	6 am	Ya esta amaneciendo, el sol saliendo \nYo amanezco a lado tuyo, bebe \nY aun no recuerdo lo que sucedió ayer \nQuisiera saber cuál es tu nombre, mujer \n\nPero que clase de rumba pa pa pa \nLa que yo cogí anoche que que que \nNo recuerdo lo que sucedió \nPero que clase de rumba pa pa pa \nLa que yo cogí anoche que que que \nNo recuerdo lo que sucedió \n\nPero que hora son, qué fue lo que paso \nPor qué Farru tiene el carro aparcado en la habitación \nYo no recuerdo, solo se que amaneció \nY que tenia un tatuaje que decía "Peace & Love" \nPero que confusión, creo que cometí un error \nY mezcle los tragos y una pastillitas de color \nQue sentimiento creo que tenia un medicamento \nDe esos que te noquean duro contra el pavimento \nYa son las 6 de la mañana \nY todavía no recuerdo nada \nNi siquiera conozco tu cara \nPero amaneciste aquí en mi cama \nYa son las 6 de la mañana \nY todavía no recuerdo nada \nNi siquiera conozco tu cara \nPero amaneciste aquí en mi cama \n\nPero que clase de rumba pa pa pa \nLa que yo cogí anoche que que que \nNo recuerdo lo que sucedió \n[ De: http://www.dicelacancion.com/letra-6-am-j-balvin ] \nPero que clase de rumba pa pa pa \nLa que yo cogí anoche que que que \nNo recuerdo lo que sucedió \n\nY ya no me acuerdo de nada, no tengo nada en la mente \nSolo que estaba tomando mucho ron con aguardiente \nRumbiando en la disco estaba prendido el ambiente \nEse es mi único recuerdo hasta donde estuve consciente \nSe acababa la botella y de camino ya venia \nJ Balvin me estaba hablando y no sabia lo que decía \nCreo que nos presentaron, aun no lo se todavía \nQue no recuerdo tu nombre mala suerte la mía \n\nYa son las 6 de la mañana \nY todavía no recuerdo nada \nNi siquiera conozco tu cara \nPero amaneciste aquí en mi cama \nYa son las 6 de la mañana \nY todavía no recuerdo nada \nNi siquiera conozco tu cara \nPero amaneciste aquí en mi cama \n\nYa esta amaneciendo, el sol saliendo \nYo amanezco a lado tuyo, bebe \nY aun no recuerdo lo que sucedió ayer \nQuisiera saber cuál es tu nombre, mujer \n\nPero que clase de rumba pa pa pa \nLa que yo cogí anoche que que que \nNo recuerdo lo que sucedió \nPero que clase de rumba pa pa pa \nLa que yo cogí anoche que que que \nNo recuerdo lo que sucedió	7	10	4	https://www.youtube.com/embed/yUV9JwiQLog	\N
24	Kim Dracula	\t  The earth\nWill see\nOur lives go blank tonight\nThe earth will rot away\nWell blink tonight\n\nI really wish these snakes were your arm\nI... I really wish you'd make up your mind\n\nThe earth disguised a way\nDon't blink tonight\nThe earth will see our eyes\nGo blank tonight\n\nI really wish these snakes were your arm\nI... I really wish you'd make up your mind\n\nI know... know... know...                             	1	2	4	https://www.youtube.com/embed/FYgtCNaICUg	\N
25	Booyah	Yes all we care about is dem party\r\nKeeping dem good vibes, good vibes in the air now\r\n\r\nSing along now\r\n\r\nI put that rock in ya body, now bounce all night\r\nKeep them guns outta da club, dei killin dis vibe\r\nThrow it up for the party, I'll make'em feel good\r\nGoes out to every club, city and hood\r\nNow put that rock in your body now, yeah\r\n\r\nJust keep on rockin and don't take it easy\r\nGots to get out of the club if you don't feel me \r\nGive it up, ain't no stopping\r\nEveryone up in the club is down with this rocking\r\n\r\nAnd that's all it is now\r\nYou better get on da dance floor now\r\nGet on that riddim now\r\nI'ma say booyah!\r\n\r\nBooyah!\r\n\r\nI'ma say what\r\n\r\nYes all we care about is dem party\r\nKeeping dem good vibes, good vibes in the air now\r\nSing along now\r\n\r\nI put that rock in ya body, now bounce all night\r\nKeep them guns outta di club, dei killin dis vibe\r\nThrow it up for the party, I make'em feel good\r\nGoes out to every club, city and hood\r\nNow put that rock in ya body now yeah\r\nI'm saying\r\nPut that rock in ya body now yeah\r\n\r\nJust keep on rockin and don't take it easy\r\nGots to get out of the club if you don't feel me \r\nGive it up, ain't no stopping\r\nEveryone up in the club is down with this rocking\r\n\r\nAnd that's all it is now\r\nYou better get on da dance floor now\r\nGet on that riddim now\r\nI'ma say booyah!\r\n\r\nI'ma say booyah!	8	12	20	https://www.youtube.com/embed/py_XYMf6XR8	\N
\.


--
-- TOC entry 1893 (class 0 OID 17423)
-- Dependencies: 1555
-- Data for Name: Categoria; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "Categoria" (id_cat, nom_cat) FROM stdin;
1	Rock
2	Metal
3	Power Metal
4	Salsa
5	Alternativo
6	Baladas
7	Regueton
8	Electro
\.


--
-- TOC entry 1894 (class 0 OID 17431)
-- Dependencies: 1557
-- Data for Name: Coleccion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "Coleccion" (id_col, id_user, id_can) FROM stdin;
1	4	3
2	4	6
3	4	7
4	4	8
5	4	10
6	4	12
7	4	14
8	4	15
9	4	18
10	4	19
11	4	22
12	4	23
13	4	24
14	20	3
15	20	14
16	20	25
17	20	12
\.


--
-- TOC entry 1895 (class 0 OID 17436)
-- Dependencies: 1559
-- Data for Name: Favorita; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "Favorita" (id_fav, id_user, id_can, cont_fav, fch_fav) FROM stdin;
4	20	15	1	2014-07-01 11:20:29.959
5	20	22	1	2014-07-01 11:27:28.649
7	4	23	2	2014-07-01 12:09:55.321
8	4	12	2	2014-07-01 12:13:06.334
2	4	6	8	2014-07-01 12:16:27.785
9	4	14	4	2014-07-01 12:18:33.808
6	4	7	5	2014-07-01 12:19:11.736
10	4	18	1	2014-07-01 12:19:34.319
15	4	25	2	2014-07-01 21:40:33.517
1	4	3	4	2014-07-01 21:43:06.393
3	4	15	3	2014-07-01 21:46:23.816
12	20	12	4	2014-07-01 22:23:54.075
11	20	14	3	2014-07-01 22:31:24.515
13	20	25	4	2014-07-01 22:32:07.329
14	20	3	2	2014-07-02 03:56:10.721
\.


--
-- TOC entry 1896 (class 0 OID 17442)
-- Dependencies: 1561
-- Data for Name: Foto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "Foto" (id_foto, img_foto, "idUser", id_can) FROM stdin;
\.


--
-- TOC entry 1897 (class 0 OID 17450)
-- Dependencies: 1563
-- Data for Name: Parametro; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "Parametro" (id_par, cod_par, des_par, val_par) FROM stdin;
1	001	Ruta servidor de archivos con fotos de usuarios	//192.169.1.35/photos_user/
2	002	Ruta de servidor de archivos con fotos de canciones	//192.169.1.35/photos_song/
\.


--
-- TOC entry 1898 (class 0 OID 17458)
-- Dependencies: 1565
-- Data for Name: SolicitudAmistad; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "SolicitudAmistad" (id_sol, id_user1, id_user2, flg_sol, fch_envio_sol, fch_acept_sol, msg_sol) FROM stdin;
1	24	25	1	2014-06-09 22:31:23.292	\N	\N
2	4	5	1	2014-06-09 22:37:48.125	2014-06-09 22:37:48.125	\N
3	4	27	1	2014-06-09 22:42:18.494	2014-06-09 22:42:18.494	\t           hola :)                    
4	4	25	1	2014-06-09 22:42:38.202	2014-06-09 22:42:38.202	\t                               
\.


--
-- TOC entry 1899 (class 0 OID 17466)
-- Dependencies: 1567
-- Data for Name: Usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "Usuario" (id_user, use_user, pas_user, nom_user, ema_user, dob_user, id_foto) FROM stdin;
4	enriquefirst@gmail.com	202cb962ac59075b964b07152d234b70	Vicente Enrique	enriquefirst@gmail.com	\N	2
5	vicente.m@tcs.com	202cb962ac59075b964b07152d234b70	Vicente	enriquefirst@gmail.com	\N	5
19	arnold@gmail.com	202cb962ac59075b964b07152d234b70	arnold	arnold@gmail.com	\N	2
20	elian@gmail.com	202cb962ac59075b964b07152d234b70	elian	elian@gmail.com	\N	2
21	alvaro@gmail.com	202cb962ac59075b964b07152d234b70	alvaro	alvaro@gmail.com	\N	2
22	test@gmail.com	202cb962ac59075b964b07152d234b70	test	test@gmail.com	\N	2
23	test2@gmail.com	202cb962ac59075b964b07152d234b70	test2	test2@gmail.com	\N	2
24	test3@gmail.com	202cb962ac59075b964b07152d234b70	test3	test3@gmail.com	\N	2
25	test4@gmail.com	202cb962ac59075b964b07152d234b70	test4	test4@gmail.com	\N	2
26	test5@gmail.com	202cb962ac59075b964b07152d234b70	test5	test5@gmail.com	\N	2
27	test6@gmail.com	202cb962ac59075b964b07152d234b70	test6	test6@gmail.com	\N	2
28	profe@gmail.com	202cb962ac59075b964b07152d234b70	profe	profe@gmail.com	\N	2
29	miguel@gmail.com	202cb962ac59075b964b07152d234b70	miguel	miguel@gmail.com	\N	2
30	jorge@gmail.com	202cb962ac59075b964b07152d234b70	jorge	jorge@gmail.com	\N	2
31	jorge2@gmail.com	202cb962ac59075b964b07152d234b70	jorge2	jorge2@gmail.com	\N	2
32	jose@gmail.com	202cb962ac59075b964b07152d234b70	jose	jose@gmail.com	\N	2
33	mary@gmail.com	202cb962ac59075b964b07152d234b70	mary	mary@gmail.com	\N	2
\.


--
-- TOC entry 1858 (class 2606 OID 17485)
-- Dependencies: 1549 1549
-- Name: Amistad_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "Amistad"
    ADD CONSTRAINT "Amistad_pkey" PRIMARY KEY (id_amis);


--
-- TOC entry 1860 (class 2606 OID 17487)
-- Dependencies: 1551 1551
-- Name: Artista_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "Artista"
    ADD CONSTRAINT "Artista_pkey" PRIMARY KEY (id_art);


--
-- TOC entry 1862 (class 2606 OID 17489)
-- Dependencies: 1553 1553
-- Name: Cancion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "Cancion"
    ADD CONSTRAINT "Cancion_pkey" PRIMARY KEY (id_can);


--
-- TOC entry 1864 (class 2606 OID 17491)
-- Dependencies: 1555 1555
-- Name: Categoria_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "Categoria"
    ADD CONSTRAINT "Categoria_pkey" PRIMARY KEY (id_cat);


--
-- TOC entry 1866 (class 2606 OID 17493)
-- Dependencies: 1557 1557
-- Name: Coleccion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "Coleccion"
    ADD CONSTRAINT "Coleccion_pkey" PRIMARY KEY (id_col);


--
-- TOC entry 1868 (class 2606 OID 17495)
-- Dependencies: 1559 1559
-- Name: Favorita_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "Favorita"
    ADD CONSTRAINT "Favorita_pkey" PRIMARY KEY (id_fav);


--
-- TOC entry 1870 (class 2606 OID 17497)
-- Dependencies: 1561 1561
-- Name: Foto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "Foto"
    ADD CONSTRAINT "Foto_pkey" PRIMARY KEY (id_foto);


--
-- TOC entry 1872 (class 2606 OID 17499)
-- Dependencies: 1563 1563
-- Name: Parametro_id_par; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "Parametro"
    ADD CONSTRAINT "Parametro_id_par" PRIMARY KEY (id_par);


--
-- TOC entry 1874 (class 2606 OID 17501)
-- Dependencies: 1565 1565
-- Name: SolicitudAmistad_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "SolicitudAmistad"
    ADD CONSTRAINT "SolicitudAmistad_pkey" PRIMARY KEY (id_sol);


--
-- TOC entry 1876 (class 2606 OID 17503)
-- Dependencies: 1567 1567
-- Name: Usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "Usuario"
    ADD CONSTRAINT "Usuario_pkey" PRIMARY KEY (id_user);


--
-- TOC entry 1879 (class 2606 OID 17504)
-- Dependencies: 1551 1553 1859
-- Name: Ref_Cancion_to_Artista; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Cancion"
    ADD CONSTRAINT "Ref_Cancion_to_Artista" FOREIGN KEY (id_art) REFERENCES "Artista"(id_art);


--
-- TOC entry 1880 (class 2606 OID 17509)
-- Dependencies: 1553 1555 1863
-- Name: Ref_Cancion_to_Categoria; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Cancion"
    ADD CONSTRAINT "Ref_Cancion_to_Categoria" FOREIGN KEY (id_cat) REFERENCES "Categoria"(id_cat);


--
-- TOC entry 1881 (class 2606 OID 17514)
-- Dependencies: 1567 1875 1553
-- Name: Ref_Cancion_to_Usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Cancion"
    ADD CONSTRAINT "Ref_Cancion_to_Usuario" FOREIGN KEY (id_user) REFERENCES "Usuario"(id_user);


--
-- TOC entry 1886 (class 2606 OID 17519)
-- Dependencies: 1861 1561 1553
-- Name: Ref_Foto_to_Cancion; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Foto"
    ADD CONSTRAINT "Ref_Foto_to_Cancion" FOREIGN KEY (id_can) REFERENCES "Cancion"(id_can);


--
-- TOC entry 1887 (class 2606 OID 17524)
-- Dependencies: 1875 1561 1567
-- Name: Ref_Foto_to_Usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Foto"
    ADD CONSTRAINT "Ref_Foto_to_Usuario" FOREIGN KEY ("idUser") REFERENCES "Usuario"(id_user);


--
-- TOC entry 1877 (class 2606 OID 17529)
-- Dependencies: 1549 1567 1875
-- Name: fkey_amigo1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Amistad"
    ADD CONSTRAINT fkey_amigo1 FOREIGN KEY (id_user1) REFERENCES "Usuario"(id_user);


--
-- TOC entry 1878 (class 2606 OID 17534)
-- Dependencies: 1549 1875 1567
-- Name: fkey_amigo2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Amistad"
    ADD CONSTRAINT fkey_amigo2 FOREIGN KEY (id_user2) REFERENCES "Usuario"(id_user);


--
-- TOC entry 1884 (class 2606 OID 17539)
-- Dependencies: 1553 1861 1559
-- Name: fkey_favoritas_cancion; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Favorita"
    ADD CONSTRAINT fkey_favoritas_cancion FOREIGN KEY (id_can) REFERENCES "Cancion"(id_can);


--
-- TOC entry 1882 (class 2606 OID 17544)
-- Dependencies: 1861 1557 1553
-- Name: fkey_favoritas_cancion; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Coleccion"
    ADD CONSTRAINT fkey_favoritas_cancion FOREIGN KEY (id_can) REFERENCES "Cancion"(id_can);


--
-- TOC entry 1885 (class 2606 OID 17549)
-- Dependencies: 1559 1875 1567
-- Name: fkey_favoritas_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Favorita"
    ADD CONSTRAINT fkey_favoritas_usuario FOREIGN KEY (id_user) REFERENCES "Usuario"(id_user);


--
-- TOC entry 1883 (class 2606 OID 17554)
-- Dependencies: 1557 1875 1567
-- Name: fkey_favoritas_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Coleccion"
    ADD CONSTRAINT fkey_favoritas_usuario FOREIGN KEY (id_user) REFERENCES "Usuario"(id_user);


--
-- TOC entry 1888 (class 2606 OID 17559)
-- Dependencies: 1565 1875 1567
-- Name: fkey_solicitud_amigo1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "SolicitudAmistad"
    ADD CONSTRAINT fkey_solicitud_amigo1 FOREIGN KEY (id_user1) REFERENCES "Usuario"(id_user);


--
-- TOC entry 1889 (class 2606 OID 17564)
-- Dependencies: 1875 1565 1567
-- Name: fkey_solicitud_amigo2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "SolicitudAmistad"
    ADD CONSTRAINT fkey_solicitud_amigo2 FOREIGN KEY (id_user2) REFERENCES "Usuario"(id_user);


--
-- TOC entry 1904 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2014-07-02 04:22:50

--
-- PostgreSQL database dump complete
--


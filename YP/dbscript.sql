--
-- PostgreSQL database dump
--

\restrict kE8zafdsIJ2BoB7UytwZj7aYM0Qvvp6hCj1TbSqkSKmCSvbVmX27nkyO8jGYEwk

-- Dumped from database version 18.6
-- Dumped by pg_dump version 18.6

-- Started on 2026-11-12 14:09:20

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
-- TOC entry 222 (class 1259 OID 28238)
-- Name: category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.category (
    name character varying(50),
    id integer CONSTRAINT categories_id_not_null NOT NULL
);


ALTER TABLE public.category OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 28237)
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categories_id_seq OWNER TO postgres;

--
-- TOC entry 5015 (class 0 OID 0)
-- Dependencies: 221
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.category.id;


--
-- TOC entry 228 (class 1259 OID 28279)
-- Name: manufacturer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.manufacturer (
    name character varying(100),
    id integer NOT NULL
);


ALTER TABLE public.manufacturer OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 28278)
-- Name: manufacturer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.manufacturer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.manufacturer_id_seq OWNER TO postgres;

--
-- TOC entry 5016 (class 0 OID 0)
-- Dependencies: 227
-- Name: manufacturer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.manufacturer_id_seq OWNED BY public.manufacturer.id;


--
-- TOC entry 236 (class 1259 OID 28332)
-- Name: order; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."order" (
    date date,
    user_id integer NOT NULL,
    id integer NOT NULL
);


ALTER TABLE public."order" OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 28341)
-- Name: orderProducts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."orderProducts" (
    order_id integer NOT NULL,
    product_id integer NOT NULL,
    size double precision,
    quantity integer,
    price double precision,
    id integer NOT NULL,
    total double precision GENERATED ALWAYS AS (((quantity)::double precision * price)) STORED
);


ALTER TABLE public."orderProducts" OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 28340)
-- Name: orderProducts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."orderProducts_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."orderProducts_id_seq" OWNER TO postgres;

--
-- TOC entry 5017 (class 0 OID 0)
-- Dependencies: 237
-- Name: orderProducts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."orderProducts_id_seq" OWNED BY public."orderProducts".id;


--
-- TOC entry 235 (class 1259 OID 28331)
-- Name: order_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.order_id_seq OWNER TO postgres;

--
-- TOC entry 5018 (class 0 OID 0)
-- Dependencies: 235
-- Name: order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.order_id_seq OWNED BY public."order".id;


--
-- TOC entry 232 (class 1259 OID 28312)
-- Name: product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product (
    subcategory_id integer NOT NULL,
    img character varying,
    name character varying(200),
    manufacturer_id integer,
    description character varying(400),
    content character varying(400),
    price double precision,
    id integer NOT NULL
);


ALTER TABLE public.product OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 28311)
-- Name: product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.product_id_seq OWNER TO postgres;

--
-- TOC entry 5019 (class 0 OID 0)
-- Dependencies: 231
-- Name: product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.product_id_seq OWNED BY public.product.id;


--
-- TOC entry 224 (class 1259 OID 28262)
-- Name: role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role (
    name character varying(50),
    id integer CONSTRAINT roles_id_not_null NOT NULL
);


ALTER TABLE public.role OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 28261)
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.roles_id_seq OWNER TO postgres;

--
-- TOC entry 5020 (class 0 OID 0)
-- Dependencies: 223
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.role.id;


--
-- TOC entry 220 (class 1259 OID 28230)
-- Name: size; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.size (
    name double precision CONSTRAINT sizes_name_not_null NOT NULL
);


ALTER TABLE public.size OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 28229)
-- Name: sizes_name_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sizes_name_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sizes_name_seq OWNER TO postgres;

--
-- TOC entry 5021 (class 0 OID 0)
-- Dependencies: 219
-- Name: sizes_name_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sizes_name_seq OWNED BY public.size.name;


--
-- TOC entry 234 (class 1259 OID 28323)
-- Name: stock; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stock (
    product_id integer NOT NULL,
    size double precision,
    quantity integer,
    id integer NOT NULL
);


ALTER TABLE public.stock OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 28322)
-- Name: stock_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.stock_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.stock_id_seq OWNER TO postgres;

--
-- TOC entry 5022 (class 0 OID 0)
-- Dependencies: 233
-- Name: stock_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.stock_id_seq OWNED BY public.stock.id;


--
-- TOC entry 239 (class 1259 OID 28413)
-- Name: subcategorie_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.subcategorie_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.subcategorie_id_seq OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 28270)
-- Name: subcategory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.subcategory (
    name character varying(50),
    category_id integer CONSTRAINT subcategories_category_id_not_null NOT NULL,
    id integer CONSTRAINT subcategories_id_not_null NOT NULL
);


ALTER TABLE public.subcategory OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 28269)
-- Name: subcategories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.subcategories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.subcategories_id_seq OWNER TO postgres;

--
-- TOC entry 5023 (class 0 OID 0)
-- Dependencies: 225
-- Name: subcategories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.subcategories_id_seq OWNED BY public.subcategory.id;


--
-- TOC entry 230 (class 1259 OID 28287)
-- Name: user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."user" (
    surname character varying(50),
    name character varying(50),
    patronymic character varying(50),
    login character varying(50),
    role_id integer CONSTRAINT users_role_id_not_null NOT NULL,
    id integer CONSTRAINT users_id_not_null NOT NULL
);


ALTER TABLE public."user" OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 28286)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- TOC entry 5024 (class 0 OID 0)
-- Dependencies: 229
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public."user".id;


--
-- TOC entry 4802 (class 2604 OID 28241)
-- Name: category id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- TOC entry 4805 (class 2604 OID 28282)
-- Name: manufacturer id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.manufacturer ALTER COLUMN id SET DEFAULT nextval('public.manufacturer_id_seq'::regclass);


--
-- TOC entry 4809 (class 2604 OID 28335)
-- Name: order id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."order" ALTER COLUMN id SET DEFAULT nextval('public.order_id_seq'::regclass);


--
-- TOC entry 4810 (class 2604 OID 28344)
-- Name: orderProducts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."orderProducts" ALTER COLUMN id SET DEFAULT nextval('public."orderProducts_id_seq"'::regclass);


--
-- TOC entry 4807 (class 2604 OID 28315)
-- Name: product id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product ALTER COLUMN id SET DEFAULT nextval('public.product_id_seq'::regclass);


--
-- TOC entry 4803 (class 2604 OID 28265)
-- Name: role id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- TOC entry 4801 (class 2604 OID 28245)
-- Name: size name; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.size ALTER COLUMN name SET DEFAULT nextval('public.sizes_name_seq'::regclass);


--
-- TOC entry 4808 (class 2604 OID 28326)
-- Name: stock id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stock ALTER COLUMN id SET DEFAULT nextval('public.stock_id_seq'::regclass);


--
-- TOC entry 4804 (class 2604 OID 28414)
-- Name: subcategory id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subcategory ALTER COLUMN id SET DEFAULT nextval('public.subcategories_id_seq'::regclass);


--
-- TOC entry 4806 (class 2604 OID 28290)
-- Name: user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 4992 (class 0 OID 28238)
-- Dependencies: 222
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.category (name, id) VALUES ('Детская обувь', 1);
INSERT INTO public.category (name, id) VALUES ('Женская обувь', 2);
INSERT INTO public.category (name, id) VALUES ('Мужская обувь', 3);


--
-- TOC entry 4998 (class 0 OID 28279)
-- Dependencies: 228
-- Data for Name: manufacturer; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.manufacturer (name, id) VALUES ('Малыш-Спорт', 1);
INSERT INTO public.manufacturer (name, id) VALUES ('Топ-Топ', 2);
INSERT INTO public.manufacturer (name, id) VALUES ('Лапушка', 3);
INSERT INTO public.manufacturer (name, id) VALUES ('Тёплые ножки', 4);
INSERT INTO public.manufacturer (name, id) VALUES ('Северята', 5);
INSERT INTO public.manufacturer (name, id) VALUES ('Весна', 6);
INSERT INTO public.manufacturer (name, id) VALUES ('Здоровый шаг', 7);
INSERT INTO public.manufacturer (name, id) VALUES ('Карапуз', 8);
INSERT INTO public.manufacturer (name, id) VALUES ('Маленький франт', 9);
INSERT INTO public.manufacturer (name, id) VALUES ('Барбари', 10);
INSERT INTO public.manufacturer (name, id) VALUES ('Твой комфорт', 11);
INSERT INTO public.manufacturer (name, id) VALUES ('Стиль и комфорт', 12);
INSERT INTO public.manufacturer (name, id) VALUES ('Кожевенные традиции', 13);
INSERT INTO public.manufacturer (name, id) VALUES ('Модный силуэт', 14);
INSERT INTO public.manufacturer (name, id) VALUES ('Азимут', 15);
INSERT INTO public.manufacturer (name, id) VALUES ('Берестов', 16);


--
-- TOC entry 5006 (class 0 OID 28332)
-- Dependencies: 236
-- Data for Name: order; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."order" (date, user_id, id) VALUES ('2026-04-02', 3, 1);
INSERT INTO public."order" (date, user_id, id) VALUES ('2026-04-05', 17, 2);
INSERT INTO public."order" (date, user_id, id) VALUES ('2026-04-08', 7, 3);
INSERT INTO public."order" (date, user_id, id) VALUES ('2026-04-12', 15, 4);
INSERT INTO public."order" (date, user_id, id) VALUES ('2026-04-18', 12, 5);
INSERT INTO public."order" (date, user_id, id) VALUES ('2026-04-22', 9, 6);
INSERT INTO public."order" (date, user_id, id) VALUES ('2026-04-25', 14, 7);
INSERT INTO public."order" (date, user_id, id) VALUES ('2026-04-28', 20, 8);
INSERT INTO public."order" (date, user_id, id) VALUES ('2026-05-05', 5, 9);
INSERT INTO public."order" (date, user_id, id) VALUES ('2026-05-08', 17, 10);
INSERT INTO public."order" (date, user_id, id) VALUES ('2026-11-12', 21, 13);
INSERT INTO public."order" (date, user_id, id) VALUES ('2026-11-12', 21, 14);
INSERT INTO public."order" (date, user_id, id) VALUES ('2026-11-12', 21, 16);


--
-- TOC entry 5008 (class 0 OID 28341)
-- Dependencies: 238
-- Data for Name: orderProducts; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."orderProducts" (order_id, product_id, size, quantity, price, id) VALUES (1, 1, 20, 1, 2190, 1);
INSERT INTO public."orderProducts" (order_id, product_id, size, quantity, price, id) VALUES (1, 7, 21, 1, 2790, 2);
INSERT INTO public."orderProducts" (order_id, product_id, size, quantity, price, id) VALUES (2, 10, 36, 1, 25000, 3);
INSERT INTO public."orderProducts" (order_id, product_id, size, quantity, price, id) VALUES (2, 13, 36, 1, 7500, 4);
INSERT INTO public."orderProducts" (order_id, product_id, size, quantity, price, id) VALUES (3, 12, 37, 1, 17000, 5);
INSERT INTO public."orderProducts" (order_id, product_id, size, quantity, price, id) VALUES (3, 20, 37, 1, 8565, 6);
INSERT INTO public."orderProducts" (order_id, product_id, size, quantity, price, id) VALUES (3, 22, 35, 1, 7795, 7);
INSERT INTO public."orderProducts" (order_id, product_id, size, quantity, price, id) VALUES (4, 17, 36, 1, 7757, 8);
INSERT INTO public."orderProducts" (order_id, product_id, size, quantity, price, id) VALUES (4, 16, 36, 1, 12340, 9);
INSERT INTO public."orderProducts" (order_id, product_id, size, quantity, price, id) VALUES (4, 15, 37, 1, 7130, 10);
INSERT INTO public."orderProducts" (order_id, product_id, size, quantity, price, id) VALUES (4, 21, 35, 1, 8765, 11);
INSERT INTO public."orderProducts" (order_id, product_id, size, quantity, price, id) VALUES (4, 11, 39, 1, 15000, 12);
INSERT INTO public."orderProducts" (order_id, product_id, size, quantity, price, id) VALUES (5, 25, 41, 1, 9567, 13);
INSERT INTO public."orderProducts" (order_id, product_id, size, quantity, price, id) VALUES (5, 29, 41, 1, 21500, 14);
INSERT INTO public."orderProducts" (order_id, product_id, size, quantity, price, id) VALUES (5, 24, 38, 1, 7890, 15);
INSERT INTO public."orderProducts" (order_id, product_id, size, quantity, price, id) VALUES (6, 26, 40, 1, 24569, 16);
INSERT INTO public."orderProducts" (order_id, product_id, size, quantity, price, id) VALUES (6, 30, 42, 1, 14567, 17);
INSERT INTO public."orderProducts" (order_id, product_id, size, quantity, price, id) VALUES (6, 31, 41, 1, 15670, 18);
INSERT INTO public."orderProducts" (order_id, product_id, size, quantity, price, id) VALUES (7, 6, 18, 1, 4290, 19);
INSERT INTO public."orderProducts" (order_id, product_id, size, quantity, price, id) VALUES (7, 1, 20, 2, 2190, 20);
INSERT INTO public."orderProducts" (order_id, product_id, size, quantity, price, id) VALUES (7, 8, 27, 1, 1690, 21);
INSERT INTO public."orderProducts" (order_id, product_id, size, quantity, price, id) VALUES (8, 28, 44, 1, 25625, 22);
INSERT INTO public."orderProducts" (order_id, product_id, size, quantity, price, id) VALUES (8, 24, 38, 3, 7890, 23);
INSERT INTO public."orderProducts" (order_id, product_id, size, quantity, price, id) VALUES (8, 23, 41.5, 2, 6550, 24);
INSERT INTO public."orderProducts" (order_id, product_id, size, quantity, price, id) VALUES (9, 2, 33, 1, 2490, 25);
INSERT INTO public."orderProducts" (order_id, product_id, size, quantity, price, id) VALUES (9, 5, 21, 2, 3190, 26);
INSERT INTO public."orderProducts" (order_id, product_id, size, quantity, price, id) VALUES (10, 18, 35, 1, 7550, 27);
INSERT INTO public."orderProducts" (order_id, product_id, size, quantity, price, id) VALUES (10, 15, 37, 1, 7130, 28);
INSERT INTO public."orderProducts" (order_id, product_id, size, quantity, price, id) VALUES (10, 16, 36, 1, 12340, 29);
INSERT INTO public."orderProducts" (order_id, product_id, size, quantity, price, id) VALUES (10, 21, 35, 2, 8765, 30);
INSERT INTO public."orderProducts" (order_id, product_id, size, quantity, price, id) VALUES (13, 1, 24, 3, NULL, 31);
INSERT INTO public."orderProducts" (order_id, product_id, size, quantity, price, id) VALUES (14, 1, 22, 2, 1642.5, 32);
INSERT INTO public."orderProducts" (order_id, product_id, size, quantity, price, id) VALUES (14, 2, 37.5, 2, 1867.5, 33);
INSERT INTO public."orderProducts" (order_id, product_id, size, quantity, price, id) VALUES (16, 1, 21, 2, 1642.5, 34);


--
-- TOC entry 5002 (class 0 OID 28312)
-- Dependencies: 232
-- Data for Name: product; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.product (subcategory_id, img, name, manufacturer_id, description, content, price, id) VALUES (1, 'IMG_KS_195213.png', 'Кроссовки детские «Гонщик» экокожа', 2, 'Кроссовки детские «Гонщик» экокожа. Производитель: Фабрика «Топ-Топ», г. Киров', 'Верх — экокожа (микрофибра), подкладка — текстиль сетчатый (полиэстер), подошва — термопластичная резина (ТЭП)', 2490, 2);
INSERT INTO public.product (subcategory_id, img, name, manufacturer_id, description, content, price, id) VALUES (1, 'IMG_KS_195222.png', 'Кроссовки детские «Радуга» экокожа перфорированная', 3, 'Кроссовки детские «Радуга» экокожа перфорированная. Производитель: ИП Смирнова Л.В. (бренд «Лапушка»), г. Вологда', 'Верх — экокожа перфорированная, вставки — нейлон, стелька — ортопедическая с латексной подушкой, подошва — ЭВА', 1990, 3);
INSERT INTO public.product (subcategory_id, img, name, manufacturer_id, description, content, price, id) VALUES (2, 'IMG_KB_185501.png', 'Сапожки детские «Снежинка» зимние на меху', 4, 'Сапожки детские «Снежинка» зимние на меху. Производитель: ООО «Тёплые ножки», г. Новосибирск', 'Верх — экокожа морозостойкая, утеплитель — искусственный мех (акрил 70%, полиэстер 30%), подкладка — флис, подошва — термоэластопласт (ТЭП)', 3490, 4);
INSERT INTO public.product (subcategory_id, img, name, manufacturer_id, description, content, price, id) VALUES (2, 'IMG_KB_164816.png', 'Сапожки детские «Медвежонок» демисезонные непромокаемые', 5, 'Сапожки детские «Медвежонок» демисезонные непромокаемые. Производитель: Компания «Северята», г. Архангельск', 'Верх — плащёвая ткань с водоотталкивающей пропиткой (полиэстер 100%), отделка — экокожа, подкладка — микрофибра, мембрана — AirTex, подошва — резина', 3190, 5);
INSERT INTO public.product (subcategory_id, img, name, manufacturer_id, description, content, price, id) VALUES (2, 'IMG_KB_164811.png', 'Сапожки детские «Принцесса» кожаные', 6, 'Сапожки детские «Принцесса» кожаные. Производитель: Мастерская «Весна», г. Тула', 'Верх — натуральная кожа (КРС), подкладка — шерсть натуральная (70%), байка (30%), стелька — войлочная, подошва — полиуретан', 4290, 6);
INSERT INTO public.product (subcategory_id, img, name, manufacturer_id, description, content, price, id) VALUES (3, 'IMG_KSd_195207.png', 'Сандалии детские «Пчёлка» ортопедические летние', 7, 'Сандалии детские «Пчёлка» ортопедические летние. Производитель: ООО «Здоровый шаг», г. Воронеж', 'Верх — нубук натуральный, подкладка — кожа растительного дубления, стелька — анатомическая с супинатором (латекс + пробка), подошва — каучук', 2790, 7);
INSERT INTO public.product (subcategory_id, img, name, manufacturer_id, description, content, price, id) VALUES (3, 'IMG_KSd_185508.png', 'Сандалии детские «Морячок» текстильные с фиксатором', 8, 'Сандалии детские «Морячок» текстильные с фиксатором. Производитель: ИП Кузнецов А.Д. (бренд «Карапуз»), г. Краснодар', 'Верх — джинсовая ткань (хлопок 100%), окантовка — искусственная кожа, подкладка — хлопок, подошва — ЭВА лёгкая', 1690, 8);
INSERT INTO public.product (subcategory_id, img, name, manufacturer_id, description, content, price, id) VALUES (4, 'IMG_KSho_185512.png', 'Туфли детские «Бантик» лаковые праздничные', 9, 'Туфли детские «Бантик» лаковые праздничные. Производитель: Дом обуви «Маленький франт», г. Москва', 'Верх — искусственная лаковая кожа (ПВХ), носок усиленный — термопластичный полиуретан, подкладка — кожа искусственная дышащая, стелька — анатомическая с амортизацией, подошва — полиуретан', 2390, 9);
INSERT INTO public.product (subcategory_id, img, name, manufacturer_id, description, content, price, id) VALUES (5, 'IMG_WB_170905.png', 'Сапоги зимние натуральная кожа', 10, 'Сапоги женские зимние, нескользящая, устойчивая подошва, натуральный мех. Производитель: Дом обуви «Барбари», г. Новороссийск ', 'Верх — натуральная кожа, подкладка — евромех, натуральный мех, текстильный утеплитель, подошва — резина', 25000, 10);
INSERT INTO public.product (subcategory_id, img, name, manufacturer_id, description, content, price, id) VALUES (5, 'IMG_WB_170859.png', 'Сапоги осенние натуральная кожа', 10, 'Сапоги женские демисезонные из высококачественной натуральной кожи. Производитель: Дом обуви «Барбари», г. Новороссийск ', 'Верх — натуральная кожа, подкладка — текстильный утеплитель, стелька — текстиль, подошва — ТПР', 15000, 11);
INSERT INTO public.product (subcategory_id, img, name, manufacturer_id, description, content, price, id) VALUES (5, 'IMG_WB_170906.png', 'Сапоги трубы демисезонные замшевые', 11, 'Сапоги женские демисезонные замшевые. Производитель: ОАО «Твой комфорт», г. Ярославль', 'Верх — натуральная замша, утепленные, тракторная подошва, стелька — байка, подошва — резина', 17000, 12);
INSERT INTO public.product (subcategory_id, img, name, manufacturer_id, description, content, price, id) VALUES (6, 'IMG_WSd_174332.png', 'Босоножки «Песчаный берег» коричневые', 12, 'Коричневая кожаная модель с открытым носком, боковой пряжкой и закрытым каблуком. Производитель: ИП «Стиль и комфорт», г. Санкт-Петербург', 'Верх — 100% козья кожа, подкладка — 100% кожа; подошва: 100% кожа', 7500, 13);
INSERT INTO public.product (subcategory_id, img, name, manufacturer_id, description, content, price, id) VALUES (6, 'IMG_WSd_185156.png', 'Женские босоножки «Черный кофе» со скульптурным каблуком', 13, 'Открытый носок и ремешок со сборной пряжкой, низкий каблук и резиновая подошва гарантируют комфорт. Производитель: ЗАО «Кожевенные традиции», г. Вятка', 'Верх — кожа собственного производств, подкладка — кожа; подошва: резина', 5600, 14);
INSERT INTO public.product (subcategory_id, img, name, manufacturer_id, description, content, price, id) VALUES (6, 'IMG_WSd_185551.png', 'Босоножки женские «Летний бриз»', 14, 'Босоножки женские кожаные белые, регулируемый ремешок, закрытый каблук и кожаная подошва. Производитель: ООО «Модный силуэт», г. Кострома', 'Верх — натуральная кожа, подкладка — натуральная кожа, подошва — кожа', 7130, 15);
INSERT INTO public.product (subcategory_id, img, name, manufacturer_id, description, content, price, id) VALUES (7, 'IMG_WSho_174409.png', 'Демисезонные туфли натуральная кожа', 14, 'Комфортные лаконичные лодочки, классический дизайна с современными акцентами. Производитель: ООО «Модный силуэт», г. Кострома', 'Верх — натуральная овечья кожа, подкладка и стелька — натуральная овечья кожа, подошва — резина', 12340, 16);
INSERT INTO public.product (subcategory_id, img, name, manufacturer_id, description, content, price, id) VALUES (7, 'IMG_WSho_185202.png', 'Туфли женские натуральная кожа с металлическими вставками', 13, 'Стильные туфли для весеннего и летнего сезона. Производитель: ЗАО «Кожевенные традиции», г. Вятка', 'Верх — натуральная телячьей кожа, металлическая пряжка, подкладка и стелька— натуральная овечья кожа, подошва — резина', 7757, 17);
INSERT INTO public.product (subcategory_id, img, name, manufacturer_id, description, content, price, id) VALUES (7, 'IMG_WSho_185545.png', 'Туфли классические лодочки натуральная кожа', 12, 'Модель из натуральной кожи, классический острый носок и изящная шпилька. Производитель: ИП «Стиль и комфорт», г. Санкт-Петербург', 'Верх — натуральная кожа, подкладка и стелька — натуральная кожа, подошва — тунит', 7550, 18);
INSERT INTO public.product (subcategory_id, img, name, manufacturer_id, description, content, price, id) VALUES (8, 'IMG_WS_174110.png', 'Кроссовки белые с оранжевым и красным', 2, 'Многослойный верх из кожи и текстиля. Производитель: Фабрика «Топ-Топ», г. Киров', 'Верх — 70% кожа, 30% текстиль, подкладка — текстиль, подошва — резина', 9450, 19);
INSERT INTO public.product (subcategory_id, img, name, manufacturer_id, description, content, price, id) VALUES (8, 'IMG_WS_185528.png', 'Кроссовки летние кожаные', 2, 'Уверенность на каждом шагу. Материал обеспечивает долговечность и комфорт при носке. Производитель: Фабрика «Топ-Топ», г. Киров', 'Верх — 87% кожа, 11% текстиль, 2% синтетика; подкладка: 100% текстиль; подошва: резина, пластик', 8565, 20);
INSERT INTO public.product (subcategory_id, img, name, manufacturer_id, description, content, price, id) VALUES (8, 'IMG_WS_185535.png', 'Кроссовки кожаные', 12, 'Кроссовки женские из натуральной кожи. Производитель: ИП «Стиль и комфорт», г. Санкт-Петербург', 'Верх — натуральная кожа, подкладка — кожа, подошва — полиуретан', 8765, 21);
INSERT INTO public.product (subcategory_id, img, name, manufacturer_id, description, content, price, id) VALUES (8, 'IMG_WS_185538.png', 'Кроссовки «Стиль и комфорт»', 12, 'Кроссовки женские из натуральной кожи и синтетических материалов, сетчатые вставки. Производитель: ИП «Стиль и комфорт», г. Санкт-Петербург', 'Верх — 70% кожа, 20% полиамид, 10% полиуретан; подкладка — текстиль, подошва — ТПУ', 7795, 22);
INSERT INTO public.product (subcategory_id, img, name, manufacturer_id, description, content, price, id) VALUES (9, 'IMG_MS_185531.png', 'Кроссовки для бега «Драйв»', 15, 'Сочетание стиля, комфорта и современных технологий. Производитель: Фабрика «Азимут», г. Санкт-Петербург', 'Верх —  сетка, подкладка — текстиль, подошва —  резина', 6550, 23);
INSERT INTO public.product (subcategory_id, img, name, manufacturer_id, description, content, price, id) VALUES (9, 'IMG_MS_185532.png', 'Кроссовки «Азимут Бег» ', 15, 'Универсальный выбор для повседневного использования. Производитель: Фабрика «Азимут», г. Санкт-Петербург', 'Верх — 6% кожа, 29% текстиль, 15% полимерные материалы; подкладка — 100% текстиль; подошва — полимерные материалы, резина', 7890, 24);
INSERT INTO public.product (subcategory_id, img, name, manufacturer_id, description, content, price, id) VALUES (9, 'IMG_MS_185533.png', 'Кроссовки', 2, 'Кроссовки для мужчин, идеальное сочетание стиля и комфорта. Производитель: Фабрика «Топ-Топ», г. Киров', 'Верх — 56% кожа, 29% текстиль, 15% полимерные материалы; подкладка — 100% текстиль; подошва — полимерные материалы, резина', 9567, 25);
INSERT INTO public.product (subcategory_id, img, name, manufacturer_id, description, content, price, id) VALUES (10, 'IMG_MSho_190514.png', 'Черные туфли в классическом стиле — база для деловых образов', 10, 'Модель выполнена из натуральной кожи, на резиновой подошве. Производитель: Дом обуви «Барбари», г. Новороссийск ', 'Верх — натуральная кожа, подкладка — текстиль, стелька — натуральная кожа, подошва — резина', 24569, 26);
INSERT INTO public.product (subcategory_id, img, name, manufacturer_id, description, content, price, id) VALUES (10, 'IMG_MSho_190518.png', 'Туфли мужские светлые классика демисезонные', 16, 'Туфли на низком каблуке кожаные', 'Верх — натуральная кожа, подкладка — текстиль, стелька — натуральная кожа, подошва — ТЭП', 10155, 27);
INSERT INTO public.product (subcategory_id, img, name, manufacturer_id, description, content, price, id) VALUES (10, 'IMG_MSho_191612.png', 'Туфли из натуральной кожи', 16, 'Модель выполнена из натуральной кожи, на резиновой подошве, поддеживает классический и деловой стиль образов. Производитель: Дом обуви «Берестов», г. Москва', 'Верх — натуральная кожа, подкладка — натуральная кожа, стелька — натуральная кожа, подошва — резина', 25625, 28);
INSERT INTO public.product (subcategory_id, img, name, manufacturer_id, description, content, price, id) VALUES (11, 'IMG_MB_174349.png', 'Ботинки мужские демисезонные', 10, 'Ботинки из натуральной кожи темно-коричневого и черного цвета на шнурках. Производитель: Дом обуви «Берестов», г. Москва', 'Верх — натуральная кожа, подкладка — текстиль, подошва — искусственный материал', 21500, 29);
INSERT INTO public.product (subcategory_id, img, name, manufacturer_id, description, content, price, id) VALUES (11, 'IMG_MB_191200.png', 'Ботинки черные из натуральной кожи', 13, 'Ботинки представляют баланс традиций и современности. Выполнены из натуральной кожи насыщенного черного цвета. Производитель: ЗАО «Кожевенные традиции», г. Вятка', 'Верх — натуральная кожа, подкладка — ворсин, стелька — ворсин, подошва — тунит', 14567, 30);
INSERT INTO public.product (subcategory_id, img, name, manufacturer_id, description, content, price, id) VALUES (11, 'IMG_MB_191205.png', 'Ботинки зимние классические', 10, 'Выбор на каждый день — натуральная кожа, натуральный мех. Производитель: Дом обуви «Барбари», г. Новороссийск ', 'Верх — натуральная кожа, подкладка — натуральный мех, стелька — натуральный мех, подошва — ТЭП', 15670, 31);
INSERT INTO public.product (subcategory_id, img, name, manufacturer_id, description, content, price, id) VALUES (1, NULL, 'Кроссовки детские «Звёздочка» экокожа', 1, 'Кроссовки детские «Звёздочка» экокожа. Производитель: ООО «Малыш-Спорт», г. Смоленск', 'Верх — экокожа (полиуретан на хлопковой основе), подкладка — хлопок 100%, подошва — ПВХ', 2190, 1);


--
-- TOC entry 4994 (class 0 OID 28262)
-- Dependencies: 224
-- Data for Name: role; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.role (name, id) VALUES ('Администратор', 1);
INSERT INTO public.role (name, id) VALUES ('Менеджер', 2);
INSERT INTO public.role (name, id) VALUES ('Авторизованный пользователь', 3);


--
-- TOC entry 4990 (class 0 OID 28230)
-- Dependencies: 220
-- Data for Name: size; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.size (name) VALUES (18);
INSERT INTO public.size (name) VALUES (19);
INSERT INTO public.size (name) VALUES (20);
INSERT INTO public.size (name) VALUES (21);
INSERT INTO public.size (name) VALUES (22);
INSERT INTO public.size (name) VALUES (23);
INSERT INTO public.size (name) VALUES (24);
INSERT INTO public.size (name) VALUES (25);
INSERT INTO public.size (name) VALUES (26);
INSERT INTO public.size (name) VALUES (27);
INSERT INTO public.size (name) VALUES (28);
INSERT INTO public.size (name) VALUES (29);
INSERT INTO public.size (name) VALUES (30);
INSERT INTO public.size (name) VALUES (31);
INSERT INTO public.size (name) VALUES (32);
INSERT INTO public.size (name) VALUES (33);
INSERT INTO public.size (name) VALUES (34);
INSERT INTO public.size (name) VALUES (35);
INSERT INTO public.size (name) VALUES (36);
INSERT INTO public.size (name) VALUES (36.5);
INSERT INTO public.size (name) VALUES (37);
INSERT INTO public.size (name) VALUES (37.5);
INSERT INTO public.size (name) VALUES (38);
INSERT INTO public.size (name) VALUES (38.5);
INSERT INTO public.size (name) VALUES (39);
INSERT INTO public.size (name) VALUES (39.5);
INSERT INTO public.size (name) VALUES (40);
INSERT INTO public.size (name) VALUES (40.5);
INSERT INTO public.size (name) VALUES (41);
INSERT INTO public.size (name) VALUES (41.5);
INSERT INTO public.size (name) VALUES (42);
INSERT INTO public.size (name) VALUES (42.5);
INSERT INTO public.size (name) VALUES (43);
INSERT INTO public.size (name) VALUES (44);
INSERT INTO public.size (name) VALUES (45);


--
-- TOC entry 5004 (class 0 OID 28323)
-- Dependencies: 234
-- Data for Name: stock; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.stock (product_id, size, quantity, id) VALUES (1, 20, 20, 1);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (1, 21, 20, 2);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (1, 22, 20, 3);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (1, 23, 20, 4);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (1, 24, 20, 5);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (1, 25, 20, 6);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (2, 33, 2, 7);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (2, 34, 2, 8);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (3, 19, 30, 9);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (3, 20, 30, 10);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (4, 19, 15, 11);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (4, 20, 15, 12);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (5, 21, 5, 13);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (5, 22, 5, 14);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (5, 23, 5, 15);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (6, 18, 4, 16);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (6, 19, 4, 17);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (6, 20, 4, 18);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (7, 21, 4, 19);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (7, 22, 4, 20);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (7, 23, 4, 21);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (7, 24, 4, 22);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (8, 27, 7, 23);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (8, 28, 7, 24);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (8, 29, 7, 25);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (8, 30, 7, 26);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (9, 18, 7, 27);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (9, 19, 7, 28);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (9, 20, 7, 29);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (10, 36, 12, 30);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (10, 37, 12, 31);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (11, 39, 2, 32);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (11, 40, 2, 33);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (12, 37, 5, 34);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (12, 39, 5, 35);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (12, 40, 5, 36);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (13, 36, 10, 37);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (13, 37, 10, 38);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (13, 38, 10, 39);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (13, 39, 10, 40);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (13, 40, 10, 41);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (14, 35, 3, 42);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (15, 37, 23, 43);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (15, 39, 23, 44);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (15, 40, 23, 45);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (16, 36, 25, 46);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (16, 37, 25, 47);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (16, 38, 25, 48);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (17, 36, 4, 49);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (17, 38, 4, 50);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (17, 39, 4, 51);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (17, 40, 4, 52);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (18, 35, 9, 53);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (18, 38, 9, 54);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (19, 35, 2, 55);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (19, 36, 2, 56);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (20, 37, 5, 57);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (20, 37.5, 5, 58);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (20, 38, 5, 59);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (20, 38.5, 5, 60);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (21, 35, 16, 61);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (21, 36, 16, 62);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (21, 38, 16, 63);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (21, 39, 16, 64);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (22, 35, 3, 65);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (22, 38, 3, 66);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (23, 41.5, 18, 67);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (23, 42, 18, 68);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (23, 42.5, 18, 69);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (23, 43, 18, 70);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (24, 38, 50, 71);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (24, 38.5, 50, 72);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (24, 39, 50, 73);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (24, 39.5, 50, 74);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (24, 40, 50, 75);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (24, 41, 50, 76);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (25, 41, 3, 77);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (25, 42, 3, 78);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (25, 44, 3, 79);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (26, 40, 23, 80);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (26, 41, 23, 81);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (26, 43, 23, 82);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (27, 42, 15, 83);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (27, 43, 15, 84);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (27, 44, 15, 85);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (28, 44, 3, 86);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (29, 41, 1, 87);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (29, 42, 1, 88);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (30, 42, 20, 89);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (30, 43, 20, 90);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (31, 41, 30, 91);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (31, 42, 30, 92);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (1, 20, 22, 93);
INSERT INTO public.stock (product_id, size, quantity, id) VALUES (2, 37.5, 2, 94);


--
-- TOC entry 4996 (class 0 OID 28270)
-- Dependencies: 226
-- Data for Name: subcategory; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.subcategory (name, category_id, id) VALUES ('Кроссовки', 1, 1);
INSERT INTO public.subcategory (name, category_id, id) VALUES ('Сапоги', 1, 2);
INSERT INTO public.subcategory (name, category_id, id) VALUES ('Босоножки', 1, 3);
INSERT INTO public.subcategory (name, category_id, id) VALUES ('Туфли', 1, 4);
INSERT INTO public.subcategory (name, category_id, id) VALUES ('Сапоги', 2, 5);
INSERT INTO public.subcategory (name, category_id, id) VALUES ('Босоножки', 2, 6);
INSERT INTO public.subcategory (name, category_id, id) VALUES ('Туфли', 2, 7);
INSERT INTO public.subcategory (name, category_id, id) VALUES ('Кроссовки', 2, 8);
INSERT INTO public.subcategory (name, category_id, id) VALUES ('Кроссовки', 3, 9);
INSERT INTO public.subcategory (name, category_id, id) VALUES ('Туфли', 3, 10);
INSERT INTO public.subcategory (name, category_id, id) VALUES ('Ботинки', 3, 11);


--
-- TOC entry 5000 (class 0 OID 28287)
-- Dependencies: 230
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."user" (surname, name, patronymic, login, role_id, id) VALUES ('Иванов', 'Иван', 'Сергеевич', 'isivanov', 1, 1);
INSERT INTO public."user" (surname, name, patronymic, login, role_id, id) VALUES ('Петров', 'Пётр', 'Алексеевич', 'papetrov', 2, 2);
INSERT INTO public."user" (surname, name, patronymic, login, role_id, id) VALUES ('Сидорова', 'Анна', 'Дмитриевна', 'asidorova', 3, 3);
INSERT INTO public."user" (surname, name, patronymic, login, role_id, id) VALUES ('Кузнецова', 'Екатерина', 'Андреевна', 'ekuznetsova', 2, 4);
INSERT INTO public."user" (surname, name, patronymic, login, role_id, id) VALUES ('Смирнов', 'Дмитрий', 'Владимирович', 'dsmirnov', 3, 5);
INSERT INTO public."user" (surname, name, patronymic, login, role_id, id) VALUES ('Попов', 'Алексей', 'Николаевич', 'apopov', 1, 6);
INSERT INTO public."user" (surname, name, patronymic, login, role_id, id) VALUES ('Васильева', 'Ольга', 'Игоревна', 'ovasileva', 3, 7);
INSERT INTO public."user" (surname, name, patronymic, login, role_id, id) VALUES ('Соколов', 'Павел', 'Викторович', 'psokolov', 2, 8);
INSERT INTO public."user" (surname, name, patronymic, login, role_id, id) VALUES ('Михайлова', 'Татьяна', 'Юрьевна', 'tmikhailova', 3, 9);
INSERT INTO public."user" (surname, name, patronymic, login, role_id, id) VALUES ('Новикова', 'Наталья', 'Сергеевна', 'nnovikova', 2, 10);
INSERT INTO public."user" (surname, name, patronymic, login, role_id, id) VALUES ('Фёдоров', 'Андрей', 'Максимович', 'afedorov', 1, 11);
INSERT INTO public."user" (surname, name, patronymic, login, role_id, id) VALUES ('Морозов', 'Сергей', 'Павлович', 'smorozov', 3, 12);
INSERT INTO public."user" (surname, name, patronymic, login, role_id, id) VALUES ('Волкова', 'Юлия', 'Александровна', 'jvolkova', 2, 13);
INSERT INTO public."user" (surname, name, patronymic, login, role_id, id) VALUES ('Алексеев', 'Артём', 'Евгеньевич', 'aalekseev', 3, 14);
INSERT INTO public."user" (surname, name, patronymic, login, role_id, id) VALUES ('Лебедева', 'Ирина', 'Владимировна', 'ilebedeva', 3, 15);
INSERT INTO public."user" (surname, name, patronymic, login, role_id, id) VALUES ('Егоров', 'Никита', 'Денисович', 'negorov', 2, 16);
INSERT INTO public."user" (surname, name, patronymic, login, role_id, id) VALUES ('Павлова', 'Елена', 'Петровна', 'epavlova', 3, 17);
INSERT INTO public."user" (surname, name, patronymic, login, role_id, id) VALUES ('Козлов', 'Роман', 'Олегович', 'rkozlov', 1, 18);
INSERT INTO public."user" (surname, name, patronymic, login, role_id, id) VALUES ('Степанова', 'Виктория', 'Романовна', 'vstepanova', 2, 19);
INSERT INTO public."user" (surname, name, patronymic, login, role_id, id) VALUES ('Николаев', 'Владимир', 'Иванович', 'vnikolaev', 3, 20);
INSERT INTO public."user" (surname, name, patronymic, login, role_id, id) VALUES ('admin', 'admin', 'admin', 'admin', 1, 21);


--
-- TOC entry 5025 (class 0 OID 0)
-- Dependencies: 221
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_id_seq', 1, false);


--
-- TOC entry 5026 (class 0 OID 0)
-- Dependencies: 227
-- Name: manufacturer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.manufacturer_id_seq', 1, false);


--
-- TOC entry 5027 (class 0 OID 0)
-- Dependencies: 237
-- Name: orderProducts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."orderProducts_id_seq"', 34, true);


--
-- TOC entry 5028 (class 0 OID 0)
-- Dependencies: 235
-- Name: order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_id_seq', 16, true);


--
-- TOC entry 5029 (class 0 OID 0)
-- Dependencies: 231
-- Name: product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.product_id_seq', 1, false);


--
-- TOC entry 5030 (class 0 OID 0)
-- Dependencies: 223
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_id_seq', 1, false);


--
-- TOC entry 5031 (class 0 OID 0)
-- Dependencies: 219
-- Name: sizes_name_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sizes_name_seq', 1, false);


--
-- TOC entry 5032 (class 0 OID 0)
-- Dependencies: 233
-- Name: stock_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.stock_id_seq', 1, true);


--
-- TOC entry 5033 (class 0 OID 0)
-- Dependencies: 239
-- Name: subcategorie_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.subcategorie_id_seq', 1, false);


--
-- TOC entry 5034 (class 0 OID 0)
-- Dependencies: 225
-- Name: subcategories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.subcategories_id_seq', 11, true);


--
-- TOC entry 5035 (class 0 OID 0)
-- Dependencies: 229
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 2, true);


--
-- TOC entry 4815 (class 2606 OID 28244)
-- Name: category categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- TOC entry 4821 (class 2606 OID 28285)
-- Name: manufacturer manufacturer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.manufacturer
    ADD CONSTRAINT manufacturer_pkey PRIMARY KEY (id);


--
-- TOC entry 4831 (class 2606 OID 28350)
-- Name: orderProducts orderProducts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."orderProducts"
    ADD CONSTRAINT "orderProducts_pkey" PRIMARY KEY (id);


--
-- TOC entry 4829 (class 2606 OID 28339)
-- Name: order order_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT order_pkey PRIMARY KEY (id);


--
-- TOC entry 4825 (class 2606 OID 28321)
-- Name: product product_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_pkey PRIMARY KEY (id);


--
-- TOC entry 4817 (class 2606 OID 28268)
-- Name: role roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- TOC entry 4813 (class 2606 OID 28247)
-- Name: size sizes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.size
    ADD CONSTRAINT sizes_pkey PRIMARY KEY (name);


--
-- TOC entry 4827 (class 2606 OID 28330)
-- Name: stock stock_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stock
    ADD CONSTRAINT stock_pkey PRIMARY KEY (id);


--
-- TOC entry 4819 (class 2606 OID 28407)
-- Name: subcategory subcategories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subcategory
    ADD CONSTRAINT subcategories_pkey PRIMARY KEY (id);


--
-- TOC entry 4823 (class 2606 OID 28294)
-- Name: user users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 4839 (class 2606 OID 28382)
-- Name: orderProducts orderProducts_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."orderProducts"
    ADD CONSTRAINT "orderProducts_order_id_fkey" FOREIGN KEY (order_id) REFERENCES public."order"(id) NOT VALID;


--
-- TOC entry 4840 (class 2606 OID 28377)
-- Name: orderProducts orderProducts_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."orderProducts"
    ADD CONSTRAINT "orderProducts_product_id_fkey" FOREIGN KEY (product_id) REFERENCES public.product(id) NOT VALID;


--
-- TOC entry 4841 (class 2606 OID 28392)
-- Name: orderProducts orderProducts_size_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."orderProducts"
    ADD CONSTRAINT "orderProducts_size_fkey" FOREIGN KEY (size) REFERENCES public.size(name) NOT VALID;


--
-- TOC entry 4838 (class 2606 OID 28372)
-- Name: order order_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT order_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id) NOT VALID;


--
-- TOC entry 4834 (class 2606 OID 28362)
-- Name: product product_manufacturer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_manufacturer_id_fkey FOREIGN KEY (manufacturer_id) REFERENCES public.manufacturer(id) NOT VALID;


--
-- TOC entry 4835 (class 2606 OID 28415)
-- Name: product product_subcategory_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_subcategory_id_fkey FOREIGN KEY (subcategory_id) REFERENCES public.subcategory(id);


--
-- TOC entry 4836 (class 2606 OID 28367)
-- Name: stock stock_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stock
    ADD CONSTRAINT stock_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.product(id) NOT VALID;


--
-- TOC entry 4837 (class 2606 OID 28387)
-- Name: stock stock_size_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stock
    ADD CONSTRAINT stock_size_fkey FOREIGN KEY (size) REFERENCES public.size(name) NOT VALID;


--
-- TOC entry 4832 (class 2606 OID 28352)
-- Name: subcategory subcategory_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subcategory
    ADD CONSTRAINT subcategory_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.category(id) NOT VALID;


--
-- TOC entry 4833 (class 2606 OID 28295)
-- Name: user users_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT users_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.role(id);


-- Completed on 2026-11-12 14:09:20

--
-- PostgreSQL database dump complete
--

\unrestrict kE8zafdsIJ2BoB7UytwZj7aYM0Qvvp6hCj1TbSqkSKmCSvbVmX27nkyO8jGYEwk


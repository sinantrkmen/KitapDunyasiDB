PGDMP     )    5                y            kitapKiralama    13.3    13.3 ?    ?           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            ?           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            ?           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            ?           1262    16944    kitapKiralama    DATABASE     l   CREATE DATABASE "kitapKiralama" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Turkish_Turkey.1254';
    DROP DATABASE "kitapKiralama";
                postgres    false            ?            1255    17584    kayitEkleTR1()    FUNCTION     G  CREATE FUNCTION public."kayitEkleTR1"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.adi = UPPER(NEW."soyadi"); -- büyük harfe dönüştürdükten sonra ekle
    IF NEW."telefonNo" IS NULL THEN
            RAISE EXCEPTION 'Telefon Numarası alanı boş bırakılamaz!';  
    END IF;
    RETURN NEW;
END;
$$;
 '   DROP FUNCTION public."kayitEkleTR1"();
       public          postgres    false            ?            1255    17583    kdvli(double precision)    FUNCTION     ?   CREATE FUNCTION public.kdvli(fiyat double precision) RETURNS double precision
    LANGUAGE plpgsql
    AS $$
BEGIN
fiyat:=fiyat*0.08+fiyat;
RETURN fiyat;
END;
$$;
 4   DROP FUNCTION public.kdvli(fiyat double precision);
       public          postgres    false            ?            1255    17582    kitapgetir(character varying)    FUNCTION     O  CREATE FUNCTION public.kitapgetir(parametre character varying) RETURNS TABLE(kitapid integer, kitapadi character varying, kiralamafiyati numeric, "kiralamasuresi_gün" integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
	RETURN Query
	Select "kitapId", adi, "kiralamaFiyatı","kiralamaSuresi"
	FROM kitap
	WHERE adi like parametre;
END;
$$;
 >   DROP FUNCTION public.kitapgetir(parametre character varying);
       public          postgres    false            ?            1255    17579 "   magazamusterilerinigoster(integer)    FUNCTION     d  CREATE FUNCTION public.magazamusterilerinigoster(magazano integer) RETURNS TABLE(magazaid integer, isim character varying, soyisim character varying, "telefonnumarası" character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY 
	SELECT "magazaId", adi, soyadi, "telefonNo" FROM musteri
                 WHERE "magazaId" = magazaNo;
END;
$$;
 B   DROP FUNCTION public.magazamusterilerinigoster(magazano integer);
       public          postgres    false            ?            1255    17580    personelbul(integer)    FUNCTION     ?  CREATE FUNCTION public.personelbul(personelno integer) RETURNS TABLE(personelid integer, personeladi character varying, personelsoyadi character varying, songuncellemetarihi timestamp without time zone)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY 
	SELECT "personelId", adi, soyadi, "sonGuncellemeTarihi" FROM personel
                 WHERE "personelId" = personelNo;
END;
$$;
 6   DROP FUNCTION public.personelbul(personelno integer);
       public          postgres    false            ?            1259    17408    adres    TABLE     /  CREATE TABLE public.adres (
    "adresId" integer NOT NULL,
    "sehirId" integer NOT NULL,
    adres1 character varying(100) NOT NULL,
    adres2 character varying(100),
    ilce character varying(30) NOT NULL,
    "postaKodu" integer,
    "sonGuncellemeTarihi" timestamp without time zone NOT NULL
);
    DROP TABLE public.adres;
       public         heap    postgres    false            ?            1259    17404    adres_adresId_seq    SEQUENCE     ?   CREATE SEQUENCE public."adres_adresId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public."adres_adresId_seq";
       public          postgres    false    230            ?           0    0    adres_adresId_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public."adres_adresId_seq" OWNED BY public.adres."adresId";
          public          postgres    false    228            ?            1259    17406    adres_sehirId_seq    SEQUENCE     ?   CREATE SEQUENCE public."adres_sehirId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public."adres_sehirId_seq";
       public          postgres    false    230            ?           0    0    adres_sehirId_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public."adres_sehirId_seq" OWNED BY public.adres."sehirId";
          public          postgres    false    229            ?            1259    17288    dil    TABLE     ?   CREATE TABLE public.dil (
    dilid integer NOT NULL,
    "dilAdi" character(30) NOT NULL,
    "sonGuncellemeTarihi" timestamp without time zone NOT NULL
);
    DROP TABLE public.dil;
       public         heap    postgres    false            ?            1259    17382    envanter    TABLE     ?   CREATE TABLE public.envanter (
    "envanterId" integer NOT NULL,
    kitapid integer NOT NULL,
    "magazaId" integer NOT NULL,
    "sonGuncellemeTarihi" timestamp without time zone DEFAULT now() NOT NULL
);
    DROP TABLE public.envanter;
       public         heap    postgres    false            ?            1259    17376    envanter_envanterId_seq    SEQUENCE     ?   CREATE SEQUENCE public."envanter_envanterId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public."envanter_envanterId_seq";
       public          postgres    false    223            ?           0    0    envanter_envanterId_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public."envanter_envanterId_seq" OWNED BY public.envanter."envanterId";
          public          postgres    false    220            ?            1259    17378    envanter_kitapId_seq    SEQUENCE     ?   CREATE SEQUENCE public."envanter_kitapId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public."envanter_kitapId_seq";
       public          postgres    false    223            ?           0    0    envanter_kitapId_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public."envanter_kitapId_seq" OWNED BY public.envanter.kitapid;
          public          postgres    false    221            ?            1259    17380    envanter_magazaId_seq    SEQUENCE     ?   CREATE SEQUENCE public."envanter_magazaId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public."envanter_magazaId_seq";
       public          postgres    false    223            ?           0    0    envanter_magazaId_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public."envanter_magazaId_seq" OWNED BY public.envanter."magazaId";
          public          postgres    false    222            ?            1259    17273    kategori    TABLE     ?   CREATE TABLE public.kategori (
    "kategoriId" integer NOT NULL,
    "kategoriAdi" character varying(30) NOT NULL,
    "sonGuncellemeTarihi" timestamp without time zone NOT NULL
);
    DROP TABLE public.kategori;
       public         heap    postgres    false            ?            1259    17367    kiralama    TABLE     7  CREATE TABLE public.kiralama (
    "kiralamaId" integer NOT NULL,
    "envanterId" integer NOT NULL,
    "musteriId" integer NOT NULL,
    "personelId" integer NOT NULL,
    "kiralamaTarihi" date NOT NULL,
    "teslimTarihi" date,
    "sonGuncellemeTarihi" timestamp without time zone DEFAULT now() NOT NULL
);
    DROP TABLE public.kiralama;
       public         heap    postgres    false            ?            1259    17361    kiralama_envanterId_seq    SEQUENCE     ?   CREATE SEQUENCE public."kiralama_envanterId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public."kiralama_envanterId_seq";
       public          postgres    false    219            ?           0    0    kiralama_envanterId_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public."kiralama_envanterId_seq" OWNED BY public.kiralama."envanterId";
          public          postgres    false    216            ?            1259    17359    kiralama_kiralamaId_seq    SEQUENCE     ?   CREATE SEQUENCE public."kiralama_kiralamaId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public."kiralama_kiralamaId_seq";
       public          postgres    false    219            ?           0    0    kiralama_kiralamaId_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public."kiralama_kiralamaId_seq" OWNED BY public.kiralama."kiralamaId";
          public          postgres    false    215            ?            1259    17363    kiralama_musteriId_seq    SEQUENCE     ?   CREATE SEQUENCE public."kiralama_musteriId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public."kiralama_musteriId_seq";
       public          postgres    false    219            ?           0    0    kiralama_musteriId_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public."kiralama_musteriId_seq" OWNED BY public.kiralama."musteriId";
          public          postgres    false    217            ?            1259    17365    kiralama_personelId_seq    SEQUENCE     ?   CREATE SEQUENCE public."kiralama_personelId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public."kiralama_personelId_seq";
       public          postgres    false    219            ?           0    0    kiralama_personelId_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public."kiralama_personelId_seq" OWNED BY public.kiralama."personelId";
          public          postgres    false    218            ?            1259    17283    kitap    TABLE     K  CREATE TABLE public.kitap (
    kitapid integer NOT NULL,
    dilid integer,
    adi character varying(255) NOT NULL,
    isbn bigint,
    sayfa_sayisi integer,
    basim_tarihi date,
    kiralama_fiyati numeric(6,2) NOT NULL,
    kiralama_suresi integer NOT NULL,
    son_guncelleme_tarihi timestamp without time zone NOT NULL
);
    DROP TABLE public.kitap;
       public         heap    postgres    false            ?            1259    17278    kitapKategori    TABLE     ?   CREATE TABLE public."kitapKategori" (
    kitapid integer NOT NULL,
    "kategoriId" integer NOT NULL,
    "sonGuncellemeTarihi" timestamp without time zone NOT NULL
);
 #   DROP TABLE public."kitapKategori";
       public         heap    postgres    false            ?            1259    17313 
   kitapYazar    TABLE     ?   CREATE TABLE public."kitapYazar" (
    "kitapId" integer NOT NULL,
    "yazarId" integer NOT NULL,
    "sonGuncellemeTarihi" timestamp without time zone NOT NULL
);
     DROP TABLE public."kitapYazar";
       public         heap    postgres    false            ?            1259    17444    magaza    TABLE       CREATE TABLE public.magaza (
    "magazaId" integer NOT NULL,
    "calisanYoneticiId" integer NOT NULL,
    "adresId" integer NOT NULL,
    "magazaAdi" character varying(40) NOT NULL,
    "sonGuncellemeTarihi" timestamp without time zone DEFAULT now() NOT NULL
);
    DROP TABLE public.magaza;
       public         heap    postgres    false            ?            1259    17442    magaza_adresId_seq    SEQUENCE     ?   CREATE SEQUENCE public."magaza_adresId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public."magaza_adresId_seq";
       public          postgres    false    239            ?           0    0    magaza_adresId_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public."magaza_adresId_seq" OWNED BY public.magaza."adresId";
          public          postgres    false    238            ?            1259    17440    magaza_calisanYoneticiId_seq    SEQUENCE     ?   CREATE SEQUENCE public."magaza_calisanYoneticiId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE public."magaza_calisanYoneticiId_seq";
       public          postgres    false    239            ?           0    0    magaza_calisanYoneticiId_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE public."magaza_calisanYoneticiId_seq" OWNED BY public.magaza."calisanYoneticiId";
          public          postgres    false    237            ?            1259    17438    magaza_magazaId_seq    SEQUENCE     ?   CREATE SEQUENCE public."magaza_magazaId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public."magaza_magazaId_seq";
       public          postgres    false    239            ?           0    0    magaza_magazaId_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public."magaza_magazaId_seq" OWNED BY public.magaza."magazaId";
          public          postgres    false    236            ?            1259    17396    musteri    TABLE     ?  CREATE TABLE public.musteri (
    "musteriId" integer NOT NULL,
    "magazaId" integer NOT NULL,
    "adresId" integer NOT NULL,
    adi character varying(30) NOT NULL,
    soyadi character varying(30) NOT NULL,
    "telefonNo" character varying(40) NOT NULL,
    "kayitTarihi" date NOT NULL,
    durum boolean NOT NULL,
    "sonGuncellemeTarihi" timestamp without time zone DEFAULT now() NOT NULL
);
    DROP TABLE public.musteri;
       public         heap    postgres    false            ?            1259    17394    musteri_adresId_seq    SEQUENCE     ?   CREATE SEQUENCE public."musteri_adresId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public."musteri_adresId_seq";
       public          postgres    false    227            ?           0    0    musteri_adresId_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public."musteri_adresId_seq" OWNED BY public.musteri."adresId";
          public          postgres    false    226            ?            1259    17392    musteri_magazaId_seq    SEQUENCE     ?   CREATE SEQUENCE public."musteri_magazaId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public."musteri_magazaId_seq";
       public          postgres    false    227            ?           0    0    musteri_magazaId_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public."musteri_magazaId_seq" OWNED BY public.musteri."magazaId";
          public          postgres    false    225            ?            1259    17390    musteri_musteriId_seq    SEQUENCE     ?   CREATE SEQUENCE public."musteri_musteriId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public."musteri_musteriId_seq";
       public          postgres    false    227            ?           0    0    musteri_musteriId_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public."musteri_musteriId_seq" OWNED BY public.musteri."musteriId";
          public          postgres    false    224            ?            1259    17350    odeme    TABLE       CREATE TABLE public.odeme (
    "odemeId" integer NOT NULL,
    "musteriId" integer NOT NULL,
    "personelId" integer NOT NULL,
    "kiralamaId" integer NOT NULL,
    "odemeTutari" numeric(6,2) NOT NULL,
    "odemeTarihi" timestamp without time zone NOT NULL
);
    DROP TABLE public.odeme;
       public         heap    postgres    false            ?            1259    17348    odeme_kiralamaId_seq    SEQUENCE     ?   CREATE SEQUENCE public."odeme_kiralamaId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public."odeme_kiralamaId_seq";
       public          postgres    false    214            ?           0    0    odeme_kiralamaId_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public."odeme_kiralamaId_seq" OWNED BY public.odeme."kiralamaId";
          public          postgres    false    213            ?            1259    17344    odeme_musteriId_seq    SEQUENCE     ?   CREATE SEQUENCE public."odeme_musteriId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public."odeme_musteriId_seq";
       public          postgres    false    214            ?           0    0    odeme_musteriId_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public."odeme_musteriId_seq" OWNED BY public.odeme."musteriId";
          public          postgres    false    211            ?            1259    17342    odeme_odemeId_seq    SEQUENCE     ?   CREATE SEQUENCE public."odeme_odemeId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public."odeme_odemeId_seq";
       public          postgres    false    214            ?           0    0    odeme_odemeId_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public."odeme_odemeId_seq" OWNED BY public.odeme."odemeId";
          public          postgres    false    210            ?            1259    17346    odeme_personelId_seq    SEQUENCE     ?   CREATE SEQUENCE public."odeme_personelId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public."odeme_personelId_seq";
       public          postgres    false    214            ?           0    0    odeme_personelId_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public."odeme_personelId_seq" OWNED BY public.odeme."personelId";
          public          postgres    false    212            ?            1259    17334    personel    TABLE     ?  CREATE TABLE public.personel (
    "personelId" integer NOT NULL,
    "magazaId" integer NOT NULL,
    "adresId" bigint NOT NULL,
    "TCKimlikNo" character varying(11) NOT NULL,
    adi character varying(30) NOT NULL,
    soyadi character varying(30) NOT NULL,
    "telefonNo" character varying(20),
    "kullaniciAdi" character varying(20) NOT NULL,
    parola character varying(20),
    "sonGuncellemeTarihi" timestamp without time zone DEFAULT now()
);
    DROP TABLE public.personel;
       public         heap    postgres    false            ?            1259    17332    personel_adresId_seq    SEQUENCE        CREATE SEQUENCE public."personel_adresId_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public."personel_adresId_seq";
       public          postgres    false    209            ?           0    0    personel_adresId_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public."personel_adresId_seq" OWNED BY public.personel."adresId";
          public          postgres    false    208            ?            1259    17330    personel_magazaId_seq    SEQUENCE     ?   CREATE SEQUENCE public."personel_magazaId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public."personel_magazaId_seq";
       public          postgres    false    209            ?           0    0    personel_magazaId_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public."personel_magazaId_seq" OWNED BY public.personel."magazaId";
          public          postgres    false    207            ?            1259    17328    personel_personelId_seq    SEQUENCE     ?   CREATE SEQUENCE public."personel_personelId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public."personel_personelId_seq";
       public          postgres    false    209            ?           0    0    personel_personelId_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public."personel_personelId_seq" OWNED BY public.personel."personelId";
          public          postgres    false    206            ?            1259    17422    sehir    TABLE     ?   CREATE TABLE public.sehir (
    "sehirId" integer NOT NULL,
    "ulkeId" integer NOT NULL,
    sehir character varying(50) NOT NULL,
    "sonGuncellemeTarihi" timestamp without time zone NOT NULL
);
    DROP TABLE public.sehir;
       public         heap    postgres    false            ?            1259    17416    sehir_sehirId_seq    SEQUENCE     ?   CREATE SEQUENCE public."sehir_sehirId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public."sehir_sehirId_seq";
       public          postgres    false    233            ?           0    0    sehir_sehirId_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public."sehir_sehirId_seq" OWNED BY public.sehir."sehirId";
          public          postgres    false    231            ?            1259    17418    sehir_ulkeId_seq    SEQUENCE     ?   CREATE SEQUENCE public."sehir_ulkeId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public."sehir_ulkeId_seq";
       public          postgres    false    233            ?           0    0    sehir_ulkeId_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public."sehir_ulkeId_seq" OWNED BY public.sehir."ulkeId";
          public          postgres    false    232            ?            1259    17432    ulke    TABLE     ?   CREATE TABLE public.ulke (
    "ulkeId" integer NOT NULL,
    ulke character varying(50) NOT NULL,
    "sonGuncellemeTarihi" timestamp without time zone NOT NULL
);
    DROP TABLE public.ulke;
       public         heap    postgres    false            ?            1259    17430    ulke_ulkeId_seq    SEQUENCE     ?   CREATE SEQUENCE public."ulke_ulkeId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public."ulke_ulkeId_seq";
       public          postgres    false    235            ?           0    0    ulke_ulkeId_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public."ulke_ulkeId_seq" OWNED BY public.ulke."ulkeId";
          public          postgres    false    234            ?            1259    17298    yazar    TABLE     ?   CREATE TABLE public.yazar (
    "yazarId" integer NOT NULL,
    adi character varying(50) NOT NULL,
    soyadi character varying(45) NOT NULL,
    "sonGuncellemeTarihi" timestamp without time zone NOT NULL
);
    DROP TABLE public.yazar;
       public         heap    postgres    false            ?           2604    17411    adres adresId    DEFAULT     r   ALTER TABLE ONLY public.adres ALTER COLUMN "adresId" SET DEFAULT nextval('public."adres_adresId_seq"'::regclass);
 >   ALTER TABLE public.adres ALTER COLUMN "adresId" DROP DEFAULT;
       public          postgres    false    228    230    230            ?           2604    17412    adres sehirId    DEFAULT     r   ALTER TABLE ONLY public.adres ALTER COLUMN "sehirId" SET DEFAULT nextval('public."adres_sehirId_seq"'::regclass);
 >   ALTER TABLE public.adres ALTER COLUMN "sehirId" DROP DEFAULT;
       public          postgres    false    229    230    230            ?           2604    17385    envanter envanterId    DEFAULT     ~   ALTER TABLE ONLY public.envanter ALTER COLUMN "envanterId" SET DEFAULT nextval('public."envanter_envanterId_seq"'::regclass);
 D   ALTER TABLE public.envanter ALTER COLUMN "envanterId" DROP DEFAULT;
       public          postgres    false    223    220    223            ?           2604    17386    envanter kitapid    DEFAULT     v   ALTER TABLE ONLY public.envanter ALTER COLUMN kitapid SET DEFAULT nextval('public."envanter_kitapId_seq"'::regclass);
 ?   ALTER TABLE public.envanter ALTER COLUMN kitapid DROP DEFAULT;
       public          postgres    false    223    221    223            ?           2604    17387    envanter magazaId    DEFAULT     z   ALTER TABLE ONLY public.envanter ALTER COLUMN "magazaId" SET DEFAULT nextval('public."envanter_magazaId_seq"'::regclass);
 B   ALTER TABLE public.envanter ALTER COLUMN "magazaId" DROP DEFAULT;
       public          postgres    false    222    223    223            ?           2604    17370    kiralama kiralamaId    DEFAULT     ~   ALTER TABLE ONLY public.kiralama ALTER COLUMN "kiralamaId" SET DEFAULT nextval('public."kiralama_kiralamaId_seq"'::regclass);
 D   ALTER TABLE public.kiralama ALTER COLUMN "kiralamaId" DROP DEFAULT;
       public          postgres    false    219    215    219            ?           2604    17371    kiralama envanterId    DEFAULT     ~   ALTER TABLE ONLY public.kiralama ALTER COLUMN "envanterId" SET DEFAULT nextval('public."kiralama_envanterId_seq"'::regclass);
 D   ALTER TABLE public.kiralama ALTER COLUMN "envanterId" DROP DEFAULT;
       public          postgres    false    219    216    219            ?           2604    17372    kiralama musteriId    DEFAULT     |   ALTER TABLE ONLY public.kiralama ALTER COLUMN "musteriId" SET DEFAULT nextval('public."kiralama_musteriId_seq"'::regclass);
 C   ALTER TABLE public.kiralama ALTER COLUMN "musteriId" DROP DEFAULT;
       public          postgres    false    219    217    219            ?           2604    17373    kiralama personelId    DEFAULT     ~   ALTER TABLE ONLY public.kiralama ALTER COLUMN "personelId" SET DEFAULT nextval('public."kiralama_personelId_seq"'::regclass);
 D   ALTER TABLE public.kiralama ALTER COLUMN "personelId" DROP DEFAULT;
       public          postgres    false    219    218    219            ?           2604    17447    magaza magazaId    DEFAULT     v   ALTER TABLE ONLY public.magaza ALTER COLUMN "magazaId" SET DEFAULT nextval('public."magaza_magazaId_seq"'::regclass);
 @   ALTER TABLE public.magaza ALTER COLUMN "magazaId" DROP DEFAULT;
       public          postgres    false    239    236    239            ?           2604    17448    magaza calisanYoneticiId    DEFAULT     ?   ALTER TABLE ONLY public.magaza ALTER COLUMN "calisanYoneticiId" SET DEFAULT nextval('public."magaza_calisanYoneticiId_seq"'::regclass);
 I   ALTER TABLE public.magaza ALTER COLUMN "calisanYoneticiId" DROP DEFAULT;
       public          postgres    false    239    237    239            ?           2604    17449    magaza adresId    DEFAULT     t   ALTER TABLE ONLY public.magaza ALTER COLUMN "adresId" SET DEFAULT nextval('public."magaza_adresId_seq"'::regclass);
 ?   ALTER TABLE public.magaza ALTER COLUMN "adresId" DROP DEFAULT;
       public          postgres    false    239    238    239            ?           2604    17399    musteri musteriId    DEFAULT     z   ALTER TABLE ONLY public.musteri ALTER COLUMN "musteriId" SET DEFAULT nextval('public."musteri_musteriId_seq"'::regclass);
 B   ALTER TABLE public.musteri ALTER COLUMN "musteriId" DROP DEFAULT;
       public          postgres    false    224    227    227            ?           2604    17400    musteri magazaId    DEFAULT     x   ALTER TABLE ONLY public.musteri ALTER COLUMN "magazaId" SET DEFAULT nextval('public."musteri_magazaId_seq"'::regclass);
 A   ALTER TABLE public.musteri ALTER COLUMN "magazaId" DROP DEFAULT;
       public          postgres    false    227    225    227            ?           2604    17401    musteri adresId    DEFAULT     v   ALTER TABLE ONLY public.musteri ALTER COLUMN "adresId" SET DEFAULT nextval('public."musteri_adresId_seq"'::regclass);
 @   ALTER TABLE public.musteri ALTER COLUMN "adresId" DROP DEFAULT;
       public          postgres    false    227    226    227            ?           2604    17353    odeme odemeId    DEFAULT     r   ALTER TABLE ONLY public.odeme ALTER COLUMN "odemeId" SET DEFAULT nextval('public."odeme_odemeId_seq"'::regclass);
 >   ALTER TABLE public.odeme ALTER COLUMN "odemeId" DROP DEFAULT;
       public          postgres    false    210    214    214            ?           2604    17354    odeme musteriId    DEFAULT     v   ALTER TABLE ONLY public.odeme ALTER COLUMN "musteriId" SET DEFAULT nextval('public."odeme_musteriId_seq"'::regclass);
 @   ALTER TABLE public.odeme ALTER COLUMN "musteriId" DROP DEFAULT;
       public          postgres    false    211    214    214            ?           2604    17355    odeme personelId    DEFAULT     x   ALTER TABLE ONLY public.odeme ALTER COLUMN "personelId" SET DEFAULT nextval('public."odeme_personelId_seq"'::regclass);
 A   ALTER TABLE public.odeme ALTER COLUMN "personelId" DROP DEFAULT;
       public          postgres    false    212    214    214            ?           2604    17356    odeme kiralamaId    DEFAULT     x   ALTER TABLE ONLY public.odeme ALTER COLUMN "kiralamaId" SET DEFAULT nextval('public."odeme_kiralamaId_seq"'::regclass);
 A   ALTER TABLE public.odeme ALTER COLUMN "kiralamaId" DROP DEFAULT;
       public          postgres    false    214    213    214            ?           2604    17337    personel personelId    DEFAULT     ~   ALTER TABLE ONLY public.personel ALTER COLUMN "personelId" SET DEFAULT nextval('public."personel_personelId_seq"'::regclass);
 D   ALTER TABLE public.personel ALTER COLUMN "personelId" DROP DEFAULT;
       public          postgres    false    209    206    209            ?           2604    17338    personel magazaId    DEFAULT     z   ALTER TABLE ONLY public.personel ALTER COLUMN "magazaId" SET DEFAULT nextval('public."personel_magazaId_seq"'::regclass);
 B   ALTER TABLE public.personel ALTER COLUMN "magazaId" DROP DEFAULT;
       public          postgres    false    209    207    209            ?           2604    17339    personel adresId    DEFAULT     x   ALTER TABLE ONLY public.personel ALTER COLUMN "adresId" SET DEFAULT nextval('public."personel_adresId_seq"'::regclass);
 A   ALTER TABLE public.personel ALTER COLUMN "adresId" DROP DEFAULT;
       public          postgres    false    209    208    209            ?           2604    17425    sehir sehirId    DEFAULT     r   ALTER TABLE ONLY public.sehir ALTER COLUMN "sehirId" SET DEFAULT nextval('public."sehir_sehirId_seq"'::regclass);
 >   ALTER TABLE public.sehir ALTER COLUMN "sehirId" DROP DEFAULT;
       public          postgres    false    231    233    233            ?           2604    17426    sehir ulkeId    DEFAULT     p   ALTER TABLE ONLY public.sehir ALTER COLUMN "ulkeId" SET DEFAULT nextval('public."sehir_ulkeId_seq"'::regclass);
 =   ALTER TABLE public.sehir ALTER COLUMN "ulkeId" DROP DEFAULT;
       public          postgres    false    233    232    233            ?           2604    17435    ulke ulkeId    DEFAULT     n   ALTER TABLE ONLY public.ulke ALTER COLUMN "ulkeId" SET DEFAULT nextval('public."ulke_ulkeId_seq"'::regclass);
 <   ALTER TABLE public.ulke ALTER COLUMN "ulkeId" DROP DEFAULT;
       public          postgres    false    234    235    235            ?          0    17408    adres 
   TABLE DATA           o   COPY public.adres ("adresId", "sehirId", adres1, adres2, ilce, "postaKodu", "sonGuncellemeTarihi") FROM stdin;
    public          postgres    false    230   j?       e          0    17288    dil 
   TABLE DATA           E   COPY public.dil (dilid, "dilAdi", "sonGuncellemeTarihi") FROM stdin;
    public          postgres    false    203   ??       y          0    17382    envanter 
   TABLE DATA           \   COPY public.envanter ("envanterId", kitapid, "magazaId", "sonGuncellemeTarihi") FROM stdin;
    public          postgres    false    223   ?       b          0    17273    kategori 
   TABLE DATA           V   COPY public.kategori ("kategoriId", "kategoriAdi", "sonGuncellemeTarihi") FROM stdin;
    public          postgres    false    200   M?       u          0    17367    kiralama 
   TABLE DATA           ?   COPY public.kiralama ("kiralamaId", "envanterId", "musteriId", "personelId", "kiralamaTarihi", "teslimTarihi", "sonGuncellemeTarihi") FROM stdin;
    public          postgres    false    219   ??       d          0    17283    kitap 
   TABLE DATA           ?   COPY public.kitap (kitapid, dilid, adi, isbn, sayfa_sayisi, basim_tarihi, kiralama_fiyati, kiralama_suresi, son_guncelleme_tarihi) FROM stdin;
    public          postgres    false    202   ?       c          0    17278    kitapKategori 
   TABLE DATA           W   COPY public."kitapKategori" (kitapid, "kategoriId", "sonGuncellemeTarihi") FROM stdin;
    public          postgres    false    201   ??       g          0    17313 
   kitapYazar 
   TABLE DATA           S   COPY public."kitapYazar" ("kitapId", "yazarId", "sonGuncellemeTarihi") FROM stdin;
    public          postgres    false    205   ?       ?          0    17444    magaza 
   TABLE DATA           p   COPY public.magaza ("magazaId", "calisanYoneticiId", "adresId", "magazaAdi", "sonGuncellemeTarihi") FROM stdin;
    public          postgres    false    239   m?       }          0    17396    musteri 
   TABLE DATA           ?   COPY public.musteri ("musteriId", "magazaId", "adresId", adi, soyadi, "telefonNo", "kayitTarihi", durum, "sonGuncellemeTarihi") FROM stdin;
    public          postgres    false    227   ??       p          0    17350    odeme 
   TABLE DATA           q   COPY public.odeme ("odemeId", "musteriId", "personelId", "kiralamaId", "odemeTutari", "odemeTarihi") FROM stdin;
    public          postgres    false    214   ??       k          0    17334    personel 
   TABLE DATA           ?   COPY public.personel ("personelId", "magazaId", "adresId", "TCKimlikNo", adi, soyadi, "telefonNo", "kullaniciAdi", parola, "sonGuncellemeTarihi") FROM stdin;
    public          postgres    false    209   ?       ?          0    17422    sehir 
   TABLE DATA           R   COPY public.sehir ("sehirId", "ulkeId", sehir, "sonGuncellemeTarihi") FROM stdin;
    public          postgres    false    233   ??       ?          0    17432    ulke 
   TABLE DATA           E   COPY public.ulke ("ulkeId", ulke, "sonGuncellemeTarihi") FROM stdin;
    public          postgres    false    235   0?       f          0    17298    yazar 
   TABLE DATA           N   COPY public.yazar ("yazarId", adi, soyadi, "sonGuncellemeTarihi") FROM stdin;
    public          postgres    false    204   ??       ?           0    0    adres_adresId_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public."adres_adresId_seq"', 1, false);
          public          postgres    false    228            ?           0    0    adres_sehirId_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public."adres_sehirId_seq"', 1, false);
          public          postgres    false    229            ?           0    0    envanter_envanterId_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public."envanter_envanterId_seq"', 1, false);
          public          postgres    false    220            ?           0    0    envanter_kitapId_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public."envanter_kitapId_seq"', 1, false);
          public          postgres    false    221            ?           0    0    envanter_magazaId_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public."envanter_magazaId_seq"', 1, false);
          public          postgres    false    222            ?           0    0    kiralama_envanterId_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public."kiralama_envanterId_seq"', 1, false);
          public          postgres    false    216            ?           0    0    kiralama_kiralamaId_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public."kiralama_kiralamaId_seq"', 1, false);
          public          postgres    false    215            ?           0    0    kiralama_musteriId_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public."kiralama_musteriId_seq"', 1, false);
          public          postgres    false    217            ?           0    0    kiralama_personelId_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public."kiralama_personelId_seq"', 1, false);
          public          postgres    false    218            ?           0    0    magaza_adresId_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public."magaza_adresId_seq"', 1, false);
          public          postgres    false    238            ?           0    0    magaza_calisanYoneticiId_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public."magaza_calisanYoneticiId_seq"', 1, false);
          public          postgres    false    237            ?           0    0    magaza_magazaId_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public."magaza_magazaId_seq"', 1, false);
          public          postgres    false    236            ?           0    0    musteri_adresId_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public."musteri_adresId_seq"', 1, false);
          public          postgres    false    226            ?           0    0    musteri_magazaId_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public."musteri_magazaId_seq"', 1, false);
          public          postgres    false    225            ?           0    0    musteri_musteriId_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public."musteri_musteriId_seq"', 1, false);
          public          postgres    false    224            ?           0    0    odeme_kiralamaId_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public."odeme_kiralamaId_seq"', 1, false);
          public          postgres    false    213            ?           0    0    odeme_musteriId_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public."odeme_musteriId_seq"', 1, false);
          public          postgres    false    211            ?           0    0    odeme_odemeId_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public."odeme_odemeId_seq"', 1, false);
          public          postgres    false    210            ?           0    0    odeme_personelId_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public."odeme_personelId_seq"', 1, false);
          public          postgres    false    212            ?           0    0    personel_adresId_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public."personel_adresId_seq"', 1, false);
          public          postgres    false    208            ?           0    0    personel_magazaId_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public."personel_magazaId_seq"', 1, false);
          public          postgres    false    207            ?           0    0    personel_personelId_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public."personel_personelId_seq"', 1, false);
          public          postgres    false    206            ?           0    0    sehir_sehirId_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public."sehir_sehirId_seq"', 1, false);
          public          postgres    false    231            ?           0    0    sehir_ulkeId_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public."sehir_ulkeId_seq"', 1, false);
          public          postgres    false    232            ?           0    0    ulke_ulkeId_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public."ulke_ulkeId_seq"', 1, false);
          public          postgres    false    234            ?           2606    17414    adres adres_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY public.adres
    ADD CONSTRAINT adres_pkey PRIMARY KEY ("adresId");
 :   ALTER TABLE ONLY public.adres DROP CONSTRAINT adres_pkey;
       public            postgres    false    230            ?           2606    17292    dil dilId_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY public.dil
    ADD CONSTRAINT "dilId_pkey" PRIMARY KEY (dilid);
 :   ALTER TABLE ONLY public.dil DROP CONSTRAINT "dilId_pkey";
       public            postgres    false    203            ?           2606    17389    envanter envanter_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.envanter
    ADD CONSTRAINT envanter_pkey PRIMARY KEY ("envanterId");
 @   ALTER TABLE ONLY public.envanter DROP CONSTRAINT envanter_pkey;
       public            postgres    false    223            ?           2606    17277    kategori kategori_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.kategori
    ADD CONSTRAINT kategori_pkey PRIMARY KEY ("kategoriId");
 @   ALTER TABLE ONLY public.kategori DROP CONSTRAINT kategori_pkey;
       public            postgres    false    200            ?           2606    17375    kiralama kiralama_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.kiralama
    ADD CONSTRAINT kiralama_pkey PRIMARY KEY ("kiralamaId");
 @   ALTER TABLE ONLY public.kiralama DROP CONSTRAINT kiralama_pkey;
       public            postgres    false    219            ?           2606    17282     kitapKategori kitapKategori_pkey 
   CONSTRAINT     u   ALTER TABLE ONLY public."kitapKategori"
    ADD CONSTRAINT "kitapKategori_pkey" PRIMARY KEY (kitapid, "kategoriId");
 N   ALTER TABLE ONLY public."kitapKategori" DROP CONSTRAINT "kitapKategori_pkey";
       public            postgres    false    201    201            ?           2606    17317    kitapYazar kitapYazar_pk 
   CONSTRAINT     l   ALTER TABLE ONLY public."kitapYazar"
    ADD CONSTRAINT "kitapYazar_pk" PRIMARY KEY ("kitapId", "yazarId");
 F   ALTER TABLE ONLY public."kitapYazar" DROP CONSTRAINT "kitapYazar_pk";
       public            postgres    false    205    205            ?           2606    17287    kitap kitap_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.kitap
    ADD CONSTRAINT kitap_pkey PRIMARY KEY (kitapid);
 :   ALTER TABLE ONLY public.kitap DROP CONSTRAINT kitap_pkey;
       public            postgres    false    202            ?           2606    17451    magaza magaza_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.magaza
    ADD CONSTRAINT magaza_pkey PRIMARY KEY ("magazaId");
 <   ALTER TABLE ONLY public.magaza DROP CONSTRAINT magaza_pkey;
       public            postgres    false    239            ?           2606    17403    musteri musteri_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public.musteri
    ADD CONSTRAINT musteri_pkey PRIMARY KEY ("musteriId");
 >   ALTER TABLE ONLY public.musteri DROP CONSTRAINT musteri_pkey;
       public            postgres    false    227            ?           2606    17358    odeme odeme_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY public.odeme
    ADD CONSTRAINT odeme_pkey PRIMARY KEY ("odemeId");
 :   ALTER TABLE ONLY public.odeme DROP CONSTRAINT odeme_pkey;
       public            postgres    false    214            ?           2606    17341    personel personel_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.personel
    ADD CONSTRAINT personel_pkey PRIMARY KEY ("personelId");
 @   ALTER TABLE ONLY public.personel DROP CONSTRAINT personel_pkey;
       public            postgres    false    209            ?           2606    17429    sehir sehir_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY public.sehir
    ADD CONSTRAINT sehir_pkey PRIMARY KEY ("sehirId");
 :   ALTER TABLE ONLY public.sehir DROP CONSTRAINT sehir_pkey;
       public            postgres    false    233            ?           2606    17437    ulke ulke_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.ulke
    ADD CONSTRAINT ulke_pkey PRIMARY KEY ("ulkeId");
 8   ALTER TABLE ONLY public.ulke DROP CONSTRAINT ulke_pkey;
       public            postgres    false    235            ?           2606    17302    yazar yazar_pk 
   CONSTRAINT     S   ALTER TABLE ONLY public.yazar
    ADD CONSTRAINT yazar_pk PRIMARY KEY ("yazarId");
 8   ALTER TABLE ONLY public.yazar DROP CONSTRAINT yazar_pk;
       public            postgres    false    204            ?           2620    17585    musteri kayitKontrol    TRIGGER        CREATE TRIGGER "kayitKontrol" BEFORE INSERT OR UPDATE ON public.musteri FOR EACH ROW EXECUTE FUNCTION public."kayitEkleTR1"();
 /   DROP TRIGGER "kayitKontrol" ON public.musteri;
       public          postgres    false    227    244            ?           2606    17492    adres adresSehirId_fk    FK CONSTRAINT        ALTER TABLE ONLY public.adres
    ADD CONSTRAINT "adresSehirId_fk" FOREIGN KEY ("sehirId") REFERENCES public.sehir("sehirId");
 A   ALTER TABLE ONLY public.adres DROP CONSTRAINT "adresSehirId_fk";
       public          postgres    false    233    3014    230            ?           2606    17512    kitap dilId_fk    FK CONSTRAINT     ?   ALTER TABLE ONLY public.kitap
    ADD CONSTRAINT "dilId_fk" FOREIGN KEY (dilid) REFERENCES public.dil(dilid) ON UPDATE CASCADE ON DELETE RESTRICT;
 :   ALTER TABLE ONLY public.kitap DROP CONSTRAINT "dilId_fk";
       public          postgres    false    2996    202    203            ?           2606    17527    envanter envanterKitapId_fk    FK CONSTRAINT     ?   ALTER TABLE ONLY public.envanter
    ADD CONSTRAINT "envanterKitapId_fk" FOREIGN KEY (kitapid) REFERENCES public.kitap(kitapid) ON UPDATE CASCADE ON DELETE RESTRICT;
 G   ALTER TABLE ONLY public.envanter DROP CONSTRAINT "envanterKitapId_fk";
       public          postgres    false    2994    202    223            ?           2606    17555    envanter envanterMagazaId_fk    FK CONSTRAINT     ?   ALTER TABLE ONLY public.envanter
    ADD CONSTRAINT "envanterMagazaId_fk" FOREIGN KEY ("magazaId") REFERENCES public.magaza("magazaId") ON UPDATE CASCADE ON DELETE RESTRICT;
 H   ALTER TABLE ONLY public.envanter DROP CONSTRAINT "envanterMagazaId_fk";
       public          postgres    false    239    223    3018            ?           2606    17517    kiralama kiralamaEnvanterId_fk    FK CONSTRAINT     ?   ALTER TABLE ONLY public.kiralama
    ADD CONSTRAINT "kiralamaEnvanterId_fk" FOREIGN KEY ("envanterId") REFERENCES public.envanter("envanterId") ON UPDATE CASCADE ON DELETE RESTRICT;
 J   ALTER TABLE ONLY public.kiralama DROP CONSTRAINT "kiralamaEnvanterId_fk";
       public          postgres    false    223    219    3008            ?           2606    17522    kiralama kiralamaMusteriId_fk    FK CONSTRAINT     ?   ALTER TABLE ONLY public.kiralama
    ADD CONSTRAINT "kiralamaMusteriId_fk" FOREIGN KEY ("musteriId") REFERENCES public.musteri("musteriId") ON UPDATE CASCADE ON DELETE RESTRICT;
 I   ALTER TABLE ONLY public.kiralama DROP CONSTRAINT "kiralamaMusteriId_fk";
       public          postgres    false    227    3010    219            ?           2606    17452    kiralama kiralamaPersonelId_fk    FK CONSTRAINT     ?   ALTER TABLE ONLY public.kiralama
    ADD CONSTRAINT "kiralamaPersonelId_fk" FOREIGN KEY ("personelId") REFERENCES public.personel("personelId");
 J   ALTER TABLE ONLY public.kiralama DROP CONSTRAINT "kiralamaPersonelId_fk";
       public          postgres    false    209    3002    219            ?           2606    17507 "   kitapKategori kitKat_kategoriId_fk    FK CONSTRAINT     ?   ALTER TABLE ONLY public."kitapKategori"
    ADD CONSTRAINT "kitKat_kategoriId_fk" FOREIGN KEY ("kategoriId") REFERENCES public.kategori("kategoriId") ON UPDATE CASCADE ON DELETE RESTRICT;
 P   ALTER TABLE ONLY public."kitapKategori" DROP CONSTRAINT "kitKat_kategoriId_fk";
       public          postgres    false    200    201    2990            ?           2606    17502    kitapKategori kitKat_kitapId_fk    FK CONSTRAINT     ?   ALTER TABLE ONLY public."kitapKategori"
    ADD CONSTRAINT "kitKat_kitapId_fk" FOREIGN KEY (kitapid) REFERENCES public.kitap(kitapid) ON UPDATE CASCADE ON DELETE RESTRICT;
 M   ALTER TABLE ONLY public."kitapKategori" DROP CONSTRAINT "kitKat_kitapId_fk";
       public          postgres    false    201    202    2994            ?           2606    17318     kitapYazar kitapYazar_kitapid_fk    FK CONSTRAINT     ?   ALTER TABLE ONLY public."kitapYazar"
    ADD CONSTRAINT "kitapYazar_kitapid_fk" FOREIGN KEY ("kitapId") REFERENCES public.kitap(kitapid) ON UPDATE CASCADE ON DELETE RESTRICT;
 N   ALTER TABLE ONLY public."kitapYazar" DROP CONSTRAINT "kitapYazar_kitapid_fk";
       public          postgres    false    205    202    2994            ?           2606    17323     kitapYazar kitapYazar_yazarId_fk    FK CONSTRAINT     ?   ALTER TABLE ONLY public."kitapYazar"
    ADD CONSTRAINT "kitapYazar_yazarId_fk" FOREIGN KEY ("yazarId") REFERENCES public.yazar("yazarId") ON UPDATE CASCADE ON DELETE RESTRICT;
 N   ALTER TABLE ONLY public."kitapYazar" DROP CONSTRAINT "kitapYazar_yazarId_fk";
       public          postgres    false    205    2998    204            ?           2606    17467    magaza magazaAdres_fk    FK CONSTRAINT     ?   ALTER TABLE ONLY public.magaza
    ADD CONSTRAINT "magazaAdres_fk" FOREIGN KEY ("adresId") REFERENCES public.adres("adresId") ON UPDATE CASCADE ON DELETE RESTRICT;
 A   ALTER TABLE ONLY public.magaza DROP CONSTRAINT "magazaAdres_fk";
       public          postgres    false    239    230    3012            ?           2606    17462    magaza mudurAdres_fk    FK CONSTRAINT     ?   ALTER TABLE ONLY public.magaza
    ADD CONSTRAINT "mudurAdres_fk" FOREIGN KEY ("calisanYoneticiId") REFERENCES public.personel("personelId") ON UPDATE CASCADE ON DELETE RESTRICT;
 @   ALTER TABLE ONLY public.magaza DROP CONSTRAINT "mudurAdres_fk";
       public          postgres    false    3002    239    209            ?           2606    17497    musteri musteriAdresId_fk    FK CONSTRAINT     ?   ALTER TABLE ONLY public.musteri
    ADD CONSTRAINT "musteriAdresId_fk" FOREIGN KEY ("adresId") REFERENCES public.adres("adresId") ON UPDATE CASCADE ON DELETE RESTRICT;
 E   ALTER TABLE ONLY public.musteri DROP CONSTRAINT "musteriAdresId_fk";
       public          postgres    false    3012    227    230            ?           2606    17532    musteri musteriMagazaId_fk    FK CONSTRAINT     ?   ALTER TABLE ONLY public.musteri
    ADD CONSTRAINT "musteriMagazaId_fk" FOREIGN KEY ("magazaId") REFERENCES public.magaza("magazaId") ON UPDATE CASCADE ON DELETE RESTRICT;
 F   ALTER TABLE ONLY public.musteri DROP CONSTRAINT "musteriMagazaId_fk";
       public          postgres    false    3018    227    239            ?           2606    17482    odeme odemeKiralamaId_fk    FK CONSTRAINT     ?   ALTER TABLE ONLY public.odeme
    ADD CONSTRAINT "odemeKiralamaId_fk" FOREIGN KEY ("kiralamaId") REFERENCES public.kiralama("kiralamaId") ON UPDATE CASCADE ON DELETE SET NULL;
 D   ALTER TABLE ONLY public.odeme DROP CONSTRAINT "odemeKiralamaId_fk";
       public          postgres    false    214    219    3006            ?           2606    17472    odeme odemeMusteriId_fk    FK CONSTRAINT     ?   ALTER TABLE ONLY public.odeme
    ADD CONSTRAINT "odemeMusteriId_fk" FOREIGN KEY ("musteriId") REFERENCES public.musteri("musteriId") ON UPDATE CASCADE ON DELETE RESTRICT;
 C   ALTER TABLE ONLY public.odeme DROP CONSTRAINT "odemeMusteriId_fk";
       public          postgres    false    227    214    3010            ?           2606    17477    odeme odemePersonelId_fk    FK CONSTRAINT     ?   ALTER TABLE ONLY public.odeme
    ADD CONSTRAINT "odemePersonelId_fk" FOREIGN KEY ("personelId") REFERENCES public.personel("personelId") ON UPDATE CASCADE ON DELETE RESTRICT;
 D   ALTER TABLE ONLY public.odeme DROP CONSTRAINT "odemePersonelId_fk";
       public          postgres    false    3002    209    214            ?           2606    17457    personel personelAdres_fk    FK CONSTRAINT     ?   ALTER TABLE ONLY public.personel
    ADD CONSTRAINT "personelAdres_fk" FOREIGN KEY ("adresId") REFERENCES public.adres("adresId") ON UPDATE CASCADE ON DELETE RESTRICT;
 E   ALTER TABLE ONLY public.personel DROP CONSTRAINT "personelAdres_fk";
       public          postgres    false    230    209    3012            ?           2606    17487    sehir sehirUlkeId    FK CONSTRAINT     x   ALTER TABLE ONLY public.sehir
    ADD CONSTRAINT "sehirUlkeId" FOREIGN KEY ("ulkeId") REFERENCES public.ulke("ulkeId");
 =   ALTER TABLE ONLY public.sehir DROP CONSTRAINT "sehirUlkeId";
       public          postgres    false    233    3016    235            ?     x?mбn?0??<?_ ?L	e???ԩ?)X?Ld?м@?cg?l????4(?2???? ?A?\tKKl????????Xӗ!c@??o&-߅?μ?A??7 lG?OxF?΄?????0?!??3?-?1[V??f???u?'ݡ??qFHe-u@+%??sRe?e??E?YI??:
M+?R.uh?"i?D?5?3???(?b??v??????Ar߷m?/?ݙ????>??:??Z?9(~??Pb????e?S?Q?g?????M?j???҇?=Ľ?x???]|?      e   `   x?3?9??(???T?????@??T??D???????Ȑˈ?Ȇ??̜̪d?A?uLt??L?????9sr???X?d??)F??? Ǐ!      y   <   x?5???0??]??=?DR??A@??9?e??f
????ۣBk??졗?????D??      b   R   x?3?,??M??4202?50?54U04?22?21?2????N?L?J???)Y[rs?????"I?+?Z???$c???? ??      u   Q   x?M??? ?w2??N??t?9
~?V ?+a?F.z?d?l????,??~??nc὏?gfi??qp/?KU_??1      d   ?   x?M?1?0@??9E.??v?4??	:0!??f@-
?,HF?
b?e?}?M??M?????!M?y?|>?]?X?]??
"0Rm?6\We&)+&?֐?$?Häxq??G?f?Mc?V+P??<?_)d?庒?^-???l??6_???4?%[?~Ih?.I?ˈ!?Wf_)???4?      c   >   x?=ʱ? E?O??}?g??sDH(?????A9?EӨ?;???????????1??!      g   @   x?-???@?7[`?E?P??_???w??ɔbd?y??!??w???^??OH???Jc ^?/      ?   q   x?3?4?4???,I,Pp9?'?2???FǔĂĪĢ#9??tuL???L͸@Z?04??%'?u?*??ups? ??Ҽ???<?#?&??V?&\1z\\\ ?e-?      }   ?   x?m?1
?@E??S????;?q;?FTll???"$EN?1,=H?^.?a??x??1YZV?Pҡz??f?ێ?ha?Q?kF??\???`? A$0Hhݟ??h|?㫺E???8v??T?y???!C?v???Ӿ?ĩ?:?=8?%m??X????f?8?V?7? &R???i??? ??:      p   F   x?E???0?7WE???#jq?u?"????PXyWSc?є??a?w?,0?6p?|?O?????my?      k   ?   x?E?1
?@?z?^ ??gg?ia#v?6c?D$1??҃??rW?a????c?tC??J??`??ϳo?*? J?4\???????_?k?Z?HT??$2??C???ޯd?f?-?5??Y??????x?hݴc2}U)ʠs?-??$<?X?????9?8?>?      ?   ]   x?-?+?0@?{
.P????Y?Ga1u?&w?q1B@O?r?????p?sd??@K?R(㱭˯?C??4?$Ȑ?}}
?^z?bҹV??      ?   [   x?3?9??(;?2?????P??B??H???????Ԍˈ?1'71?2*k?kh?`hle?5?t?J-JJ?LÑ(04 i72?26)????? ? a      f   g   x?3??J?M-V?M,)?H-?tJ,*?L?4202?50?54S04?26?22?2?t/?L?/??H-)?/?*2?52R0? )24?2??K-?J,?<ܞZ???UM? ?M?     
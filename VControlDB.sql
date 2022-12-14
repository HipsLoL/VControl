PGDMP                 	    
    z            VControl    14.2    14.2 3    &           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            '           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            (           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            )           1262    118314    VControl    DATABASE     n   CREATE DATABASE "VControl" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Spanish_United States.1252';
    DROP DATABASE "VControl";
                postgres    false            ?            1259    126529    autenticacion    TABLE     ?   CREATE TABLE public.autenticacion (
    id_autenticacion integer NOT NULL,
    token character varying(4) NOT NULL,
    fecha_token time without time zone NOT NULL,
    id_usuario integer NOT NULL
);
 !   DROP TABLE public.autenticacion;
       public         heap    postgres    false            ?            1259    126528 "   autenticacion_id_autenticacion_seq    SEQUENCE     ?   CREATE SEQUENCE public.autenticacion_id_autenticacion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 9   DROP SEQUENCE public.autenticacion_id_autenticacion_seq;
       public          postgres    false    220            *           0    0 "   autenticacion_id_autenticacion_seq    SEQUENCE OWNED BY     i   ALTER SEQUENCE public.autenticacion_id_autenticacion_seq OWNED BY public.autenticacion.id_autenticacion;
          public          postgres    false    219            ?            1259    118345    cliente    TABLE     x  CREATE TABLE public.cliente (
    id_cliente integer NOT NULL,
    nombre_cliente character varying(50) NOT NULL,
    apellido_cliente character varying(50) NOT NULL,
    dui_cliente character varying(10) NOT NULL,
    direccion_cliente character varying(100) NOT NULL,
    correo_cliente character varying(100) NOT NULL,
    telefono_cliente character varying(9) NOT NULL
);
    DROP TABLE public.cliente;
       public         heap    postgres    false            ?            1259    118344    cliente_id_cliente_seq    SEQUENCE     ?   CREATE SEQUENCE public.cliente_id_cliente_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.cliente_id_cliente_seq;
       public          postgres    false    214            +           0    0    cliente_id_cliente_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.cliente_id_cliente_seq OWNED BY public.cliente.id_cliente;
          public          postgres    false    213            ?            1259    118326    estado_usuario    TABLE     ?   CREATE TABLE public.estado_usuario (
    id_estado_usuario integer NOT NULL,
    estado_usuario character varying(100) NOT NULL
);
 "   DROP TABLE public.estado_usuario;
       public         heap    postgres    false            ?            1259    118325 $   estado_usuario_id_estado_usuario_seq    SEQUENCE     ?   CREATE SEQUENCE public.estado_usuario_id_estado_usuario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ;   DROP SEQUENCE public.estado_usuario_id_estado_usuario_seq;
       public          postgres    false    210            ,           0    0 $   estado_usuario_id_estado_usuario_seq    SEQUENCE OWNED BY     m   ALTER SEQUENCE public.estado_usuario_id_estado_usuario_seq OWNED BY public.estado_usuario.id_estado_usuario;
          public          postgres    false    209            ?            1259    126507    perfil_acceso    TABLE        CREATE TABLE public.perfil_acceso (
    id_perfil_acceso integer NOT NULL,
    perfil_acceso character varying(50) NOT NULL
);
 !   DROP TABLE public.perfil_acceso;
       public         heap    postgres    false            ?            1259    126506 "   perfil_acceso_id_perfil_acesso_seq    SEQUENCE     ?   CREATE SEQUENCE public.perfil_acceso_id_perfil_acesso_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 9   DROP SEQUENCE public.perfil_acceso_id_perfil_acesso_seq;
       public          postgres    false    218            -           0    0 "   perfil_acceso_id_perfil_acesso_seq    SEQUENCE OWNED BY     i   ALTER SEQUENCE public.perfil_acceso_id_perfil_acesso_seq OWNED BY public.perfil_acceso.id_perfil_acceso;
          public          postgres    false    217            ?            1259    118352    rol_usuario    TABLE     y   CREATE TABLE public.rol_usuario (
    id_rol_usuario integer NOT NULL,
    rol_usuario character varying(20) NOT NULL
);
    DROP TABLE public.rol_usuario;
       public         heap    postgres    false            ?            1259    118351    rol_usuario_id_rol_usuario_seq    SEQUENCE     ?   CREATE SEQUENCE public.rol_usuario_id_rol_usuario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE public.rol_usuario_id_rol_usuario_seq;
       public          postgres    false    216            .           0    0    rol_usuario_id_rol_usuario_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE public.rol_usuario_id_rol_usuario_seq OWNED BY public.rol_usuario.id_rol_usuario;
          public          postgres    false    215            ?            1259    118333    usuario    TABLE     ?  CREATE TABLE public.usuario (
    id_usuario integer NOT NULL,
    nombre_usuario character varying(50) NOT NULL,
    apellido_usuario character varying(50) NOT NULL,
    id_rol_usuario integer NOT NULL,
    id_estado_usuario integer NOT NULL,
    correo_usuario character varying(100) NOT NULL,
    contrasena_usuario character varying(100) NOT NULL,
    id_perfil_acceso integer
);
    DROP TABLE public.usuario;
       public         heap    postgres    false            ?            1259    118332    usuario_id_usuario_seq    SEQUENCE     ?   CREATE SEQUENCE public.usuario_id_usuario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.usuario_id_usuario_seq;
       public          postgres    false    212            /           0    0    usuario_id_usuario_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.usuario_id_usuario_seq OWNED BY public.usuario.id_usuario;
          public          postgres    false    211            z           2604    126532    autenticacion id_autenticacion    DEFAULT     ?   ALTER TABLE ONLY public.autenticacion ALTER COLUMN id_autenticacion SET DEFAULT nextval('public.autenticacion_id_autenticacion_seq'::regclass);
 M   ALTER TABLE public.autenticacion ALTER COLUMN id_autenticacion DROP DEFAULT;
       public          postgres    false    219    220    220            w           2604    118348    cliente id_cliente    DEFAULT     x   ALTER TABLE ONLY public.cliente ALTER COLUMN id_cliente SET DEFAULT nextval('public.cliente_id_cliente_seq'::regclass);
 A   ALTER TABLE public.cliente ALTER COLUMN id_cliente DROP DEFAULT;
       public          postgres    false    214    213    214            u           2604    118329     estado_usuario id_estado_usuario    DEFAULT     ?   ALTER TABLE ONLY public.estado_usuario ALTER COLUMN id_estado_usuario SET DEFAULT nextval('public.estado_usuario_id_estado_usuario_seq'::regclass);
 O   ALTER TABLE public.estado_usuario ALTER COLUMN id_estado_usuario DROP DEFAULT;
       public          postgres    false    209    210    210            y           2604    126510    perfil_acceso id_perfil_acceso    DEFAULT     ?   ALTER TABLE ONLY public.perfil_acceso ALTER COLUMN id_perfil_acceso SET DEFAULT nextval('public.perfil_acceso_id_perfil_acesso_seq'::regclass);
 M   ALTER TABLE public.perfil_acceso ALTER COLUMN id_perfil_acceso DROP DEFAULT;
       public          postgres    false    217    218    218            x           2604    118355    rol_usuario id_rol_usuario    DEFAULT     ?   ALTER TABLE ONLY public.rol_usuario ALTER COLUMN id_rol_usuario SET DEFAULT nextval('public.rol_usuario_id_rol_usuario_seq'::regclass);
 I   ALTER TABLE public.rol_usuario ALTER COLUMN id_rol_usuario DROP DEFAULT;
       public          postgres    false    215    216    216            v           2604    118336    usuario id_usuario    DEFAULT     x   ALTER TABLE ONLY public.usuario ALTER COLUMN id_usuario SET DEFAULT nextval('public.usuario_id_usuario_seq'::regclass);
 A   ALTER TABLE public.usuario ALTER COLUMN id_usuario DROP DEFAULT;
       public          postgres    false    211    212    212            #          0    126529    autenticacion 
   TABLE DATA           Y   COPY public.autenticacion (id_autenticacion, token, fecha_token, id_usuario) FROM stdin;
    public          postgres    false    220   >?                 0    118345    cliente 
   TABLE DATA           ?   COPY public.cliente (id_cliente, nombre_cliente, apellido_cliente, dui_cliente, direccion_cliente, correo_cliente, telefono_cliente) FROM stdin;
    public          postgres    false    214   [?                 0    118326    estado_usuario 
   TABLE DATA           K   COPY public.estado_usuario (id_estado_usuario, estado_usuario) FROM stdin;
    public          postgres    false    210   x?       !          0    126507    perfil_acceso 
   TABLE DATA           H   COPY public.perfil_acceso (id_perfil_acceso, perfil_acceso) FROM stdin;
    public          postgres    false    218   ??                 0    118352    rol_usuario 
   TABLE DATA           B   COPY public.rol_usuario (id_rol_usuario, rol_usuario) FROM stdin;
    public          postgres    false    216   ??                 0    118333    usuario 
   TABLE DATA           ?   COPY public.usuario (id_usuario, nombre_usuario, apellido_usuario, id_rol_usuario, id_estado_usuario, correo_usuario, contrasena_usuario, id_perfil_acceso) FROM stdin;
    public          postgres    false    212   ,@       0           0    0 "   autenticacion_id_autenticacion_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('public.autenticacion_id_autenticacion_seq', 1, true);
          public          postgres    false    219            1           0    0    cliente_id_cliente_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.cliente_id_cliente_seq', 3, true);
          public          postgres    false    213            2           0    0 $   estado_usuario_id_estado_usuario_seq    SEQUENCE SET     R   SELECT pg_catalog.setval('public.estado_usuario_id_estado_usuario_seq', 3, true);
          public          postgres    false    209            3           0    0 "   perfil_acceso_id_perfil_acesso_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('public.perfil_acceso_id_perfil_acesso_seq', 2, true);
          public          postgres    false    217            4           0    0    rol_usuario_id_rol_usuario_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.rol_usuario_id_rol_usuario_seq', 3, true);
          public          postgres    false    215            5           0    0    usuario_id_usuario_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.usuario_id_usuario_seq', 4, true);
          public          postgres    false    211            ?           2606    126534     autenticacion autenticacion_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.autenticacion
    ADD CONSTRAINT autenticacion_pkey PRIMARY KEY (id_autenticacion);
 J   ALTER TABLE ONLY public.autenticacion DROP CONSTRAINT autenticacion_pkey;
       public            postgres    false    220            ?           2606    118350    cliente cliente_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_pkey PRIMARY KEY (id_cliente);
 >   ALTER TABLE ONLY public.cliente DROP CONSTRAINT cliente_pkey;
       public            postgres    false    214            |           2606    118331 "   estado_usuario estado_usuario_pkey 
   CONSTRAINT     o   ALTER TABLE ONLY public.estado_usuario
    ADD CONSTRAINT estado_usuario_pkey PRIMARY KEY (id_estado_usuario);
 L   ALTER TABLE ONLY public.estado_usuario DROP CONSTRAINT estado_usuario_pkey;
       public            postgres    false    210            ?           2606    126512     perfil_acceso perfil_acceso_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.perfil_acceso
    ADD CONSTRAINT perfil_acceso_pkey PRIMARY KEY (id_perfil_acceso);
 J   ALTER TABLE ONLY public.perfil_acceso DROP CONSTRAINT perfil_acceso_pkey;
       public            postgres    false    218            ?           2606    118357    rol_usuario rol_usuario_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.rol_usuario
    ADD CONSTRAINT rol_usuario_pkey PRIMARY KEY (id_rol_usuario);
 F   ALTER TABLE ONLY public.rol_usuario DROP CONSTRAINT rol_usuario_pkey;
       public            postgres    false    216            ~           2606    118364    usuario unique_correo 
   CONSTRAINT     Z   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT unique_correo UNIQUE (correo_usuario);
 ?   ALTER TABLE ONLY public.usuario DROP CONSTRAINT unique_correo;
       public            postgres    false    212            ?           2606    118338    usuario usuario_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id_usuario);
 >   ALTER TABLE ONLY public.usuario DROP CONSTRAINT usuario_pkey;
       public            postgres    false    212            ?           2606    126535 (   autenticacion fk_autenticacion_idusuario    FK CONSTRAINT     ?   ALTER TABLE ONLY public.autenticacion
    ADD CONSTRAINT fk_autenticacion_idusuario FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario);
 R   ALTER TABLE ONLY public.autenticacion DROP CONSTRAINT fk_autenticacion_idusuario;
       public          postgres    false    3200    212    220            ?           2606    118339 (   usuario fk_estadousuario_idestadousuario    FK CONSTRAINT     ?   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT fk_estadousuario_idestadousuario FOREIGN KEY (id_estado_usuario) REFERENCES public.estado_usuario(id_estado_usuario);
 R   ALTER TABLE ONLY public.usuario DROP CONSTRAINT fk_estadousuario_idestadousuario;
       public          postgres    false    210    212    3196            ?           2606    126514 &   usuario fk_perfilacceso_idperfilacesso    FK CONSTRAINT     ?   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT fk_perfilacceso_idperfilacesso FOREIGN KEY (id_perfil_acceso) REFERENCES public.perfil_acceso(id_perfil_acceso) NOT VALID;
 P   ALTER TABLE ONLY public.usuario DROP CONSTRAINT fk_perfilacceso_idperfilacesso;
       public          postgres    false    218    3206    212            ?           2606    118358 "   usuario fk_rolusuario_idrolusuario    FK CONSTRAINT     ?   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT fk_rolusuario_idrolusuario FOREIGN KEY (id_rol_usuario) REFERENCES public.rol_usuario(id_rol_usuario) NOT VALID;
 L   ALTER TABLE ONLY public.usuario DROP CONSTRAINT fk_rolusuario_idrolusuario;
       public          postgres    false    216    212    3204            #      x?????? ? ?            x?????? ? ?         *   x?3?tL.?,??2???K?0??̌Ĥ̜̒Ĕ|?=... ?~?      !   (   x?3?tL????,.)JL?/?2?t-.I?KI,?????? ?6	?         2   x?3?tL????,.)J,?,??2?t??K?K?L-??2?
???????? *?x            x?????? ? ?     
PGDMP  )                    |            sql-final_project    16.3    16.3 -               0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    25129    sql-final_project    DATABASE     �   CREATE DATABASE "sql-final_project" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';
 #   DROP DATABASE "sql-final_project";
                postgres    false            �            1259    25460    ads    TABLE     �   CREATE TABLE public.ads (
    ad_id integer NOT NULL,
    title character varying(255) NOT NULL,
    date_post date NOT NULL,
    car_id integer,
    user_id integer,
    location_id integer
);
    DROP TABLE public.ads;
       public         heap    postgres    false            �            1259    25459    ads_ad_id_seq    SEQUENCE     �   CREATE SEQUENCE public.ads_ad_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.ads_ad_id_seq;
       public          postgres    false    222                       0    0    ads_ad_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.ads_ad_id_seq OWNED BY public.ads.ad_id;
          public          postgres    false    221            �            1259    25482    bids    TABLE     �   CREATE TABLE public.bids (
    bid_id character varying NOT NULL,
    ad_id integer,
    user_id integer,
    bid_amount numeric(12,0) NOT NULL,
    bid_date timestamp without time zone NOT NULL,
    bid_status boolean NOT NULL
);
    DROP TABLE public.bids;
       public         heap    postgres    false            �            1259    25481    bids_bid_id_seq    SEQUENCE     �   CREATE SEQUENCE public.bids_bid_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.bids_bid_id_seq;
       public          postgres    false    224                       0    0    bids_bid_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.bids_bid_id_seq OWNED BY public.bids.bid_id;
          public          postgres    false    223            �            1259    25451    cars    TABLE     D  CREATE TABLE public.cars (
    car_id integer NOT NULL,
    brand character varying(255) NOT NULL,
    model character varying(255) NOT NULL,
    body_type character varying(255) NOT NULL,
    transmission character varying(255) NOT NULL,
    year integer NOT NULL,
    description text,
    price numeric(12,0) NOT NULL
);
    DROP TABLE public.cars;
       public         heap    postgres    false            �            1259    25450    cars_car_id_seq    SEQUENCE     �   CREATE SEQUENCE public.cars_car_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.cars_car_id_seq;
       public          postgres    false    220                       0    0    cars_car_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.cars_car_id_seq OWNED BY public.cars.car_id;
          public          postgres    false    219            �            1259    25430 	   locations    TABLE     �   CREATE TABLE public.locations (
    location_id integer NOT NULL,
    city_name character varying(255) NOT NULL,
    longitude numeric(9,6) NOT NULL,
    latitude numeric(9,6) NOT NULL
);
    DROP TABLE public.locations;
       public         heap    postgres    false            �            1259    25429    locations_location_id_seq    SEQUENCE     �   CREATE SEQUENCE public.locations_location_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.locations_location_id_seq;
       public          postgres    false    216                       0    0    locations_location_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.locations_location_id_seq OWNED BY public.locations.location_id;
          public          postgres    false    215            �            1259    25437    users    TABLE     �   CREATE TABLE public.users (
    user_id integer NOT NULL,
    name character varying(255) NOT NULL,
    phone character varying(255) NOT NULL,
    address character varying(255) NOT NULL,
    location_id integer NOT NULL
);
    DROP TABLE public.users;
       public         heap    postgres    false            �            1259    25436    users_user_id_seq    SEQUENCE     �   CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.users_user_id_seq;
       public          postgres    false    218                       0    0    users_user_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;
          public          postgres    false    217            g           2604    25463 	   ads ad_id    DEFAULT     f   ALTER TABLE ONLY public.ads ALTER COLUMN ad_id SET DEFAULT nextval('public.ads_ad_id_seq'::regclass);
 8   ALTER TABLE public.ads ALTER COLUMN ad_id DROP DEFAULT;
       public          postgres    false    221    222    222            h           2604    25524    bids bid_id    DEFAULT     j   ALTER TABLE ONLY public.bids ALTER COLUMN bid_id SET DEFAULT nextval('public.bids_bid_id_seq'::regclass);
 :   ALTER TABLE public.bids ALTER COLUMN bid_id DROP DEFAULT;
       public          postgres    false    223    224    224            f           2604    25454    cars car_id    DEFAULT     j   ALTER TABLE ONLY public.cars ALTER COLUMN car_id SET DEFAULT nextval('public.cars_car_id_seq'::regclass);
 :   ALTER TABLE public.cars ALTER COLUMN car_id DROP DEFAULT;
       public          postgres    false    220    219    220            d           2604    25433    locations location_id    DEFAULT     ~   ALTER TABLE ONLY public.locations ALTER COLUMN location_id SET DEFAULT nextval('public.locations_location_id_seq'::regclass);
 D   ALTER TABLE public.locations ALTER COLUMN location_id DROP DEFAULT;
       public          postgres    false    215    216    216            e           2604    25440    users user_id    DEFAULT     n   ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);
 <   ALTER TABLE public.users ALTER COLUMN user_id DROP DEFAULT;
       public          postgres    false    218    217    218                      0    25460    ads 
   TABLE DATA           T   COPY public.ads (ad_id, title, date_post, car_id, user_id, location_id) FROM stdin;
    public          postgres    false    222   2                 0    25482    bids 
   TABLE DATA           X   COPY public.bids (bid_id, ad_id, user_id, bid_amount, bid_date, bid_status) FROM stdin;
    public          postgres    false    224   m6                 0    25451    cars 
   TABLE DATA           g   COPY public.cars (car_id, brand, model, body_type, transmission, year, description, price) FROM stdin;
    public          postgres    false    220   H8       	          0    25430 	   locations 
   TABLE DATA           P   COPY public.locations (location_id, city_name, longitude, latitude) FROM stdin;
    public          postgres    false    216   �:                 0    25437    users 
   TABLE DATA           K   COPY public.users (user_id, name, phone, address, location_id) FROM stdin;
    public          postgres    false    218   [<                  0    0    ads_ad_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.ads_ad_id_seq', 1, false);
          public          postgres    false    221                       0    0    bids_bid_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.bids_bid_id_seq', 1, false);
          public          postgres    false    223                       0    0    cars_car_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.cars_car_id_seq', 1, false);
          public          postgres    false    219                        0    0    locations_location_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.locations_location_id_seq', 1, false);
          public          postgres    false    215            !           0    0    users_user_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.users_user_id_seq', 1, false);
          public          postgres    false    217            p           2606    25465    ads ads_pkey 
   CONSTRAINT     M   ALTER TABLE ONLY public.ads
    ADD CONSTRAINT ads_pkey PRIMARY KEY (ad_id);
 6   ALTER TABLE ONLY public.ads DROP CONSTRAINT ads_pkey;
       public            postgres    false    222            r           2606    25526    bids bids_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.bids
    ADD CONSTRAINT bids_pkey PRIMARY KEY (bid_id);
 8   ALTER TABLE ONLY public.bids DROP CONSTRAINT bids_pkey;
       public            postgres    false    224            n           2606    25458    cars cars_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.cars
    ADD CONSTRAINT cars_pkey PRIMARY KEY (car_id);
 8   ALTER TABLE ONLY public.cars DROP CONSTRAINT cars_pkey;
       public            postgres    false    220            j           2606    25435    locations locations_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (location_id);
 B   ALTER TABLE ONLY public.locations DROP CONSTRAINT locations_pkey;
       public            postgres    false    216            l           2606    25444    users users_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    218            w           2606    25488    bids fk_ad_id    FK CONSTRAINT     k   ALTER TABLE ONLY public.bids
    ADD CONSTRAINT fk_ad_id FOREIGN KEY (ad_id) REFERENCES public.ads(ad_id);
 7   ALTER TABLE ONLY public.bids DROP CONSTRAINT fk_ad_id;
       public          postgres    false    222    4720    224            t           2606    25466    ads fk_car_id    FK CONSTRAINT     n   ALTER TABLE ONLY public.ads
    ADD CONSTRAINT fk_car_id FOREIGN KEY (car_id) REFERENCES public.cars(car_id);
 7   ALTER TABLE ONLY public.ads DROP CONSTRAINT fk_car_id;
       public          postgres    false    220    4718    222            s           2606    25445    users fk_location_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.users
    ADD CONSTRAINT fk_location_id FOREIGN KEY (location_id) REFERENCES public.locations(location_id);
 >   ALTER TABLE ONLY public.users DROP CONSTRAINT fk_location_id;
       public          postgres    false    218    4714    216            u           2606    25476    ads fk_location_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.ads
    ADD CONSTRAINT fk_location_id FOREIGN KEY (location_id) REFERENCES public.locations(location_id);
 <   ALTER TABLE ONLY public.ads DROP CONSTRAINT fk_location_id;
       public          postgres    false    222    216    4714            v           2606    25471    ads fk_user_id    FK CONSTRAINT     r   ALTER TABLE ONLY public.ads
    ADD CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 8   ALTER TABLE ONLY public.ads DROP CONSTRAINT fk_user_id;
       public          postgres    false    218    4716    222            x           2606    25493    bids fk_user_id    FK CONSTRAINT     s   ALTER TABLE ONLY public.bids
    ADD CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 9   ALTER TABLE ONLY public.bids DROP CONSTRAINT fk_user_id;
       public          postgres    false    4716    218    224               �  x���Qo�0ǟ�O���g;yl餩S�j�i���D#( H&�O�;;#��ԇ�?������=�v5zڼ��у-�l��G�����GS�V�G"b4+G_7�=ڥ�����Y�� �D*
&S�܈Dx�x��U��M��zw��	�@L%2�M7��#*�EA*rL
O���e��� �A�nw%~l��LJ&ӀͩP0O���-KY�����r�X�-ǪH�3�%֤o����^/�J�d L(l�������뽭�'�I,��b���I�5�?������'��ǒP*Ms���%aI���+�e�\UL��4S9����)�Li.t(ʮ�e�Cq�j=ڏ�>ޙ�8�Jqo-.z\�N䢺�Ci�Z\F�����X��z���eҌ3t;��!����]U.��?a�rR�{Y�_��[z�+�L
y#���>��[��;O�
� ����T��M��;�ql��-��+4���|e+�n���+�Ё�}�%"�@�H%g�s��"�SjK�� �S�1���<��!�d8g�w07!��x��Yb�f�)�B�	[�}[v���!�
�f��;Mל�&�|�
��8��p�����V�I����`[��V�F��:&(eU.�vxTPL0���U~]zŒ�кƶ�Y��U��r1�Q��1T�d�W��j��A)��K$cf?}9������ք���PE��wwU���NC`��\�0ܪ�p;�]�w����a]���9�\a��3�d	��{H�[��=Vզ=^^�*���M�7���1)�0L�j.p�uΏo��$��րX�w���@����"���[���:C�3�Ĺ�C ��&ٽp�n�˰ٍ<�?P��˅��㥇x��V�<<�UNg ��T�;��S�G� ީ���~�=8\�@���;�;o$�}��j�ȇ=U�'t��$4�]6��N/�a�ϐ�gZ?*f�Ӏ�
.E�V�~�Qp���$�_<4�         �  x�uU���0����I%K)��3A��@v��`��=H����0�����^��[�?n���T��'T+�"����d���7��τڋ�HpպJ��:1a�PG�-j�@�V� Ѻ��3PŬ�_B��,Tmj�RnV��x��pi�aV�n6�D���֎W���	w��Ԓ�#R���$\��y�L�k�Yka�kj�F.�������-����Ij�@�&�ښq�,�@s=�� ���:�� Ҁk ���Zi1`㚥��A�֮���k	w�VbC�j�a;�ah��H$�n��7�i��D���v�4L=�����]�Qtf�'���Xw�Hn9{��D���w��>�i�HNz���r�uM�W�]/��^�ltZ���`ɤ�>T�q�ʍw���I���\��r��y�2}��v�46�$t��m�щ��|�v6��%Y��l��_�?�>�?�o��         �  x���ێ�0����������VZUjU������@)�B�*���O$�x����3��?cx���Q�#����U�=l��T�T C�A�� �Gr��ad8�Q��eY��c����mꢏ1;U�M�� k&,�Gl����f��}�w*�J���]��N��)�@Ȝ!��*�BcYlh^���L�2*�Vh��&%Ɔc�YMЕ*{����R�*i���M僿թUeX^btBSk�C�^�Ss��s���h�[�0B�&��UTsn���+}��tF,�a�(i[lg���E�i�t�$7�|.Fc���S`_�]��1
�Oy]Tg����흩Q����|��φՅmhZ�fRj���\��hnT��?kퟙ#B���
>�S--�F!{�8le�d� ᐱ�b(�XW�,�@��&SrӼ¹�4' ��?V�{�I��m��2b�C�=n6|�ٔ�=�U�]*��ƣq�[�\��ŤL�Ef ~���{���uW�����0ՄZ$#�(�v��C.�nD�M�)\*dLKf������O���ѹ�b��:�)�*�zލ
�D@cs2#�7��q�
��[��^$R=8X������Ǻ)���f�ߓ-L�月�����2�g^���8��%�!On���I���.F�      	   `  x�Uһj�@�Z�y/s��KkNuB �8p�	F�Q�,y��H���l�i.���`��=��_=�h��|ѩCȱr���&G�9�=��IG]p)	)-�0�8�G�5{��̰Vf! ���>O:�p�6�8g��й<��kWܤJsL9%1,�A^��áC��)p�)�U�-����ͣ~�.�p�V�Qm�-�t����g�n"�ZZqi�U�[߭��C���z�TR
ȷ���_�+&���&`��u��|짩�~���*N���}­���Y�#Z2Tj��ђ����=w��c?�}�Q���@ ��}���rQ�[L��{F?A�ӟ�ᬫ�HD��Ij̒�A�C�U]�)           x�}W]s�|^�
<ڕ#����ɒyQ�v�.�ȻGB$wU��S�~}z ��'U��b0���3�簋c`�0<N]��Z�w����v�)W��:tk�l�~:�8N��~΄��V\��a����b�v�O��8U��ᅚIkLu���OÜ��������RCU�p�z��0�����~,�X��#ΤuN�m�ǰn٪݅9Q$S	�Hٰ�;R�?Q�!���3m��)����P�����0Շ�����HIH4��9'du���/�&Ǿ�S�L.��B����H�g�?��W9��fv6���TU�q���7l������b��)��jՎ1<N�&�\�jpU�����Cw8�M�����;�j+LuK��߀N��9� )_]��?�;D�¡��}���%���P�L)_�0�Æ��6�9�� ��j8��j���ū���S|敜��֩�۶k����NP,+�:w!D��]����?���3 �0(Oٜ�e�N��/q?��%'Y�����! 0�J�k�uj�R;�N�o-���B(�2'P�q�J^BGy Оc-3�������G2ǹL����H�{S����8,k�[潭ߖ�!!㪑��4�.D6u�$�R��ƥ"��!�
�
��:��r"OM<���(:	�[����hR�qۍ� # D�Fir�d!�e��|�|I<�t5}��~: 8Ƅ`� ���K3C�Y����fξ���WA4E3<��b|�9Q1��5�|�@�=#�}�`��ū��2m���O8%������]sj��nz��&����&P��eB�(\O�$7�/>�W輪,9���=×d�ɧ��w��LK���˸	�gx�!�H�E$S�Ƨo�d5����?��9�])}w�:h<��(	ZN��Q��>��!D�fJץ���џ�BnK�&��L2f�:���}n��4D�c��m��l�٧���%j֖����;�p���3�g
�E�4Na�Q�E��V_�b��OE���<�!Y^W3�Ϭx;��씮����<�?ϕ�"6�%�e����6�c!��*}u���c�؎��X�{W{��x�~V�u%����տ��s0��!"��6>�D�h����P`���iY�u�n�m��o���VeH��hb_�a����@fu�[�f*��M���� �4a8���J2S�8���~:<'ca�i���:���k8KU��&`��MH�w��i��s[�َ�p:���g��
m`W��
ɠ�n��)�O�)�|���*�C�/�dZ�f+tS���˹��%ԃ��khb�bkz�0�ʳr�a����<W�6<Ửz�MO�j�Ex{x�
z��!��).K+@[@��2���'z_ex���u|g^Zp�bgF:_V�7��sX�hNXڈ�P�+�ȫ���Py�hQ}�X�[$0��tX����Z��?0] �ww�s�Dp	�kY�D]���g�q��iGҙ�XU��W�T����ħ���?��]ĩ5f�6����QpP�Vh	J���7��v^}���U��0�"�7O���'h1I�$P�'L�*5�i��e	��di���節e;4m�*�e�Ӧy|i��]���0�?����f�aǎ��vY�K�K�"���O�05Y�c���
-|��'#��>�Y�c�!��"#�d�4u�Z9��u��)�:�lU˴W)����F���q�:��Ɨ�vN^H����b�V;!�A���R������m�e��@ N0�E�u6X��^l(#��?��햣�7
W��5�@�.�c8ڷ�~a6	��@�ɍ��x������m����RL]� �ƶ��F�U�?��߉�NɁ���u���1 Fz�䇉/�����V�)w7�۴*$d�R�$����k>;����M.������!瑴�����I)w-陸�s�i��x��G(�&<��XV�)�0X��P����%��u�6t�?#a�� �ʧN��G�M���⩥��C��� u����:oK�ú�rw�c���¿��xO,     
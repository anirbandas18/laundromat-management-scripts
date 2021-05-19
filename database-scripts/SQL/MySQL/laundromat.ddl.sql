-----------------------------------------------------------------------------------------------------------------
-------------------------------------------------- METADATA DB --------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

create table if not exists lms_metadata_db.duration_type_lov (
    id int auto_increment,
    name varchar(20) not null, -- month(s), day(s), year(s)
    description varchar(100),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_duration_type_lov primary key (id),
    index idx_duration_type_lov_name (name)
);

create table if not exists lms_metadata_db.enterprise_level_lov (
	id int auto_increment,
    name varchar(50) not null, -- small, medium, large
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_enterprise_level_lov primary key (id)
);

create table if not exists lms_metadata_db.gender_type_lov (
    id int auto_increment,
    name varchar(20) not null, -- male, female, other
    description varchar(100),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_gender_type_lov primary key (id),
    index idx_gender_type_lov_name (name)
);

create table if not exists lms_metadata_db.weight_type_lov (
    id int auto_increment,
    name varchar(20) not null, -- kg, g, pound, count
    description varchar(100),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_weight_type_lov primary key (id),
    index idx_weight_type_lov_name (name)
);

create table if not exists lms_metadata_db.distance_type_lov (
    id int auto_increment,
    name varchar(20) not null, -- km, m, mile
    description varchar(100),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_distance_type_lov primary key (id),
    index idx_distance_type_lov_name (name)
);

create table if not exists lms_metadata_db.currency_type_lov (
    id int auto_increment,
    name varchar(20) not null, -- inr, usd, aud, euro, yen
    description varchar(100),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_currency_type_lov primary key (id),
    index idx_currency_type_lov_name (name)
);

create table if not exists lms_metadata_db.laundry_service_lov (
	id int auto_increment,
    name varchar(50) not null, -- washing, folding, ironing, dry-cleaning
    description varchar(100),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_laundry_service primary key (id),
    index idx_laundry_service_lov_name (name)
);

create table if not exists lms_metadata_db.logistic_service_lov (
	id int auto_increment,
    name varchar(50) not null, -- pickup, delivery
    description varchar(100),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_logistic_service primary key (id),
    index idx_logistic_service_lov_name (name)
);

-----------------------------------------------------------------------------------------------------------------
-------------------------------------------------- SERVICE LOV DB -----------------------------------------------
-----------------------------------------------------------------------------------------------------------------



-----------------------------------------------------------------------------------------------------------------
----------------------------------------------------- TAX DB ----------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

create table if not exists lms_tax_db.tax_type_lov (
    id int auto_increment,
    name varchar(20) not null, -- cgst, gst, sales-tax, tips
    description varchar(100),
    rate float not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_tax_type_lov primary key (id),
    constraint chk_tax_type_tax_rate check (rate > 0),
    index idx_tax_type_lov_name (name)
);

create table if not exists lms_tax_db.tax_model (
	id int auto_increment,
    tax_type_lov_id int not null,
    currency_type_lov_id int not null,
    name varchar(50) not null, -- gst-inr, cgst-inr
    description varchar(100),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_tax_model primary key (id),
    constraint fk_tax_model_tax_type_lov foreign key (tax_type_lov_id) references lms_tax_db.tax_type_lov(id),
    index idx_tax_model_tax_type (tax_type_lov_id),
    index idx_tax_model_currency_type (currency_type_lov_id)
);

-----------------------------------------------------------------------------------------------------------------
-------------------------------------------------- DISCOUNT DB --------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

create table if not exists lms_discount_db.discount_level_lov (
	id int auto_increment,
    name varchar(20) not null, -- subscription, code, deal
    priority int not null,
    subscription_level_sw bigint default 0,
    description varchar(100),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_discount_level_lov primary key (id),
    constraint chk_discount_level_lov_priority check (priority > 0)
);

create table if not exists lms_discount_db.discount_type_lov (
	id int auto_increment,
    name varchar(20) not null, -- percentage, fixed
    subscription_level_sw bigint default 0,
    description varchar(100),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_discount_type_lov primary key (id)
);

create table if not exists lms_discount_db.discount_status_lov (
	id int auto_increment,
    name varchar(20) not null, -- draft, active, expired
    description varchar(100),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_discount_status_lov primary key (id)
);

create table if not exists lms_discount_db.discount_model (
	id int auto_increment,
    discount_level_lov_id int not null,
    discount_type_lov_id int not null,
    description varchar(100),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_discount_model primary key (id),
    constraint uq_discount_model_level_lov_type_lov unique (discount_level_lov_id, discount_type_lov_id)
);

create table if not exists lms_discount_db.discount_status_reason (
	id int auto_increment,
    discount_status_lov_id int not null,
    text varchar(255), -- other, reason 1, reason 2
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_discount_status_reason primary key (id),
    constraint uq_discount_status_reason_discount_status_lov foreign key (discount_status_lov_id) references lms_discount_db.discount_status_lov(id)
);

-----------------------------------------------------------------------------------------------------------------
-------------------------------------------------- CLOTHING DB --------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

create table if not exists lms_clothing_db.clothing_type_lov (
	id int auto_increment auto_increment,
    name varchar(50) not null, -- household, garment
    description varchar(100),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_clothing_type_lov primary key (id),
    index idx_clothing_type_lov_name (name)
);

create table if not exists lms_clothing_db.clothing_material_lov (
	id int auto_increment auto_increment,
    name varchar(50) not null, -- cotton, silk, jute, wool, rayon, pu
    description varchar(100),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_clothing_material_lov primary key (id),
    index idx_clothing_material_lov_name (name)
);

create table if not exists lms_clothing_db.clothing_model (
	id int auto_increment auto_increment,
    clothing_type_lov_id int not null,
    clothing_material_lov_id int not null,
    description varchar(100),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_clothing_model primary key (id),
    constraint fk_clothing_model_clothing_type_lov foreign key (clothing_type_lov_id) references lms_clothing_db.clothing_type_lov(id),
	constraint fk_clothing_model_clothing_material_lov foreign key (clothing_material_lov_id) references lms_clothing_db.clothing_material_lov(id),
    constraint uq_clothing_model_clothing_type_clothing_material unique (clothing_type_lov_id, clothing_material_lov_id),
    index idx_clothing_model_type_material (clothing_type_lov_id, clothing_material_lov_id)
);

create table if not exists lms_clothing_db.clothing_item (
	id int auto_increment,
    clothing_model_id int not null,
    name varchar(50) not null, -- shirt, pant, saree, curtain, towel, t shirt, top, jeans, all
    description varchar(100),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_clothing_item_lov primary key (id),
    constraint fk_clothing_item_clothing_model foreign key (clothing_model_id) references lms_clothing_db.clothing_model(id),
    index idx_clothing_item_clothing_model_id (clothing_model_id),
    index idx_clothing_item_name (name)
);

-----------------------------------------------------------------------------------------------------------------
-------------------------------------------------- USER DB ------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

create table if not exists lms_user_db.permission_lov (
	id int auto_increment,
    name varchar(50) not null, -- order, deliver, pickup, manage, wash, iron, dry-clean, fold
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_role_lov primary key (id)
);

create table if not exists lms_user_db.role_lov (
	id int auto_increment,
    name varchar(50) not null, -- customer, admin, operator, agent, partner
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_role_lov primary key (id)
);

create table if not exists lms_user_db.role_permission (
	id int auto_increment,
    role_lov_id int not null,
    permission_lov_id int not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_role_permission primary key (id),
	constraint fk_role_permission_role_lov foreign key (role_lov_id) references lms_user_db.role_lov(id),
	constraint fk_role_permission_permission_lov foreign key (permission_lov_id) references lms_user_db.permission_lov(id),
    constraint uq_role_permission unique (role_lov_id, permission_lov_id),
    index idx_role_permission (role_lov_id, permission_lov_id)
);

create table if not exists lms_user_db.user_detail (
	id int auto_increment,
    name varchar(50) not null,
    email_id varchar(100),
    phone_number varchar(15) not null,
    hashed_token varchar(200) not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_user_detail primary key (id),
    constraint uq_user_detail_name unique (name),
    constraint uq_user_detail_phone_email unique (phone_number, email_id),
    index idx_user_detail_name (name),
    index idx_user_detail_phone_number (phone_number)
);

create table if not exists lms_user_db.user_role (
	id int auto_increment,
    user_detail_id int not null,
    role_lov_id int not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_user_role primary key (id),
	constraint fk_user_role_user_detail foreign key (user_detail_id) references lms_user_db.user_detail(id),
	constraint fk_user_role_role_lov foreign key (role_lov_id) references lms_user_db.role_lov(id),
    constraint uq_user_role unique (user_detail_id, role_lov_id),
    index idx_user_role (user_detail_id, role_lov_id)
);

-----------------------------------------------------------------------------------------------------------------
-------------------------------------------------- CUSTOMER DB --------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

create table if not exists lms_customer_db.subscription_level_lov (
	id int auto_increment,
    name varchar(50) not null, -- basic, premium
    priority int not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_subscription_level_lov primary key (id),
    constraint chk_subscription_level_lov_priority check (priority > 0)
);

create table if not exists lms_customer_db.subscription_status_lov (
	id int auto_increment,
    name varchar(50) not null, -- draft, active, expired, hold, cancelled
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_subscription_level_lov primary key (id)
);

create table if not exists lms_customer_db.subscription_model (
	id int auto_increment,
    discount_model_id int not null,
    subscription_level_lov_id int not null,
    per_unit_of_duration int not null,
    duration_type_lov_id int not null,
    free_logistics_sw bigint not null,
    discount_value float not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_subscription_model primary key (id),
    constraint fk_subscription_model_subscription_level_lov foreign key (subscription_level_lov_id) references lms_customer_db.subscription_level_lov(id),
    constraint uq_subscription_model_discount_model_subscription_level unique (discount_model_id, subscription_level_lov_id),
    constraint chk_subscription_model_per_unit_of_duration check (per_unit_of_duration > 0),
    constraint chk_subscription_model_discount_value check (discount_value > 0)
);

create table if not exists lms_customer_db.customer_detail (
	id int auto_increment,
    user_detail_id int not null,
    first_name varchar(50) not null,
    last_name varchar(50) not null,
    gender_id int not null,
    dob date not null,
    verified_sw bigint default 0,
    consent_sw bigint default 0,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_customer_detail primary key (id),
    index idx_customer_detail_full_name (first_name, last_name)
);

create table if not exists lms_customer_db.subscription_status_reason (
	id int auto_increment,
    subscription_status_lov_id int not null,
    text varchar(255), -- other, reason 1, reason 2
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_subscription_status_reason primary key (id),
    constraint uq_subscription_status_reason_subscription_status_lov foreign key (subscription_status_lov_id) references lms_customer_db.subscription_status_lov(id)
);

create table if not exists lms_customer_db.subscription_tracker (
	id int auto_increment,
    subscription_model_id int not null,
    customer_detail_id int not null,
    subscribed_on timestamp not null,
    expires_on timestamp not null,
    expired_sw bigint default 0,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_subscription_tracker primary key (id),
    constraint fk_subscription_tracker_subscription_model foreign key (subscription_model_id) references lms_customer_db.subscription_model(id),
    constraint fk_subscription_tracker_customer_details foreign key (customer_detail_id) references lms_customer_db.customer_detail(id),
    constraint uq_subscription_trackers_customer_detail_on_subscription_model unique (customer_detail_id, subscribed_on, subscription_model_id),
    constraint chk_subscription_tracker_subscription_before_expiry check (subscribed_on < expires_on)
);

create table if not exists lms_customer_db.subscription_tracking_history (
	id int auto_increment,
    subscription_tracker_id int not null,
    subscription_status_lov_id int not null,
    subscription_status_reason_id int not null,
    additional_reason varchar(128),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_subscription_tracking_history primary key (id),
    constraint fk_subscription_tracking_history_subscription_status_lov foreign key (subscription_status_lov_id) references lms_customer_db.subscription_status_lov(id),
    constraint fk_subscription_tracking_history_subscription_tracker foreign key (subscription_tracker_id) references lms_customer_db.subscription_tracker(id),
    constraint fk_subscription_tracking_history_status_reason foreign key (subscription_status_reason_id) references lms_customer_db.customer_detail(id)
);

create table if not exists lms_customer_db.customer_address (
	id int auto_increment,
    customer_detail_id int not null,
    name varchar(100) not null,
    house_number varchar(100) not null,
    floor varchar(100) not null,
    street_name varchar(100),
    locality varchar(100) not null,
    additional_line_1 varchar(100) not null,
    additional_line_2 varchar(100) not null,
    city varchar(100) not null,
    district varchar(100) not null,
    pin_code varchar(100) not null,
    state varchar(100) not null,
    country varchar(100) not null,
    latitude double not null,
    longitude double not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_customer_address primary key (id),
    constraint fk_customer_address_customer_detail foreign key (customer_detail_id) references lms_customer_db.customer_detail(id),
    index idx_customer_address_locality (locality),
    index idx_customer_address_pin_code (pin_code),
    index idx_customer_address_district (district),
    index idx_customer_address_city (city),
	index idx_customer_address_state (state),
    index idx_customer_address_country (country),
    index idx_customer_address_coordinates (latitude, longitude)
);

-----------------------------------------------------------------------------------------------------------------
-------------------------------------------------- AGENT DB -----------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

create table if not exists lms_agent_db.agent_model (
	id int auto_increment,
    enterprise_level_lov_id int not null,
    user_detail_id int not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_agent_model primary key (id),
    constraint uq_agent_model_enterprise_level_user_detail unique (enterprise_level_lov_id, user_detail_id)
);

create table if not exists lms_agent_db.agent_detail (
	id int auto_increment,
    agent_model_id int not null,
    point_of_contact_name varchar(50) not null,
    point_of_contact_email_id varchar(50) not null,
    point_of_contact_phone_number varchar(20) not null,
    tax_number varchar(50) not null,
    facility_sw bigint default 0,
    verified_sw bigint default 0,
    consent_sw bigint default 0,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_agent_detail primary key (id),
    constraint fk_agent_detail_agent_model foreign key (agent_model_id) references lms_agent_db.agent_model(id),
    index idx_agent_detail_poc_name (point_of_contact_name),
    index idx_agent_detail_poc_email_id (point_of_contact_email_id),
    index idx_agent_detail_poc_phone_number (point_of_contact_phone_number),
    index idx_agent_detail_tax_number (tax_number)
);

create table if not exists lms_agent_db.agent_services (
	id int auto_increment,
    logistic_service_lov_id int not null,
    agent_detail_id int not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_agent_services primary key (id),
    constraint fk_agent_services_agent_detail foreign key (agent_detail_id) references lms_agent_db.agent_detail(id),
    constraint uq_agent_services_logistic_service_lov_agent_detail unique (logistic_service_lov_id, agent_detail_id)
);

create table if not exists lms_agent_db.agent_address (
	id int auto_increment,
    agent_detail_id int not null,
    name varchar(100) not null,
    house_number varchar(100) not null,
    floor varchar(100) not null,
    street_name varchar(100),
    locality varchar(100) not null,
    additional_line_1 varchar(100) not null,
    additional_line_2 varchar(100) not null,
    city varchar(100) not null,
    district varchar(100) not null,
    pin_code varchar(100) not null,
    state varchar(100) not null,
    country varchar(100) not null,
    latitude double not null,
    longitude double not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_agent_address primary key (id),
    constraint fk_agent_address_agent_detail foreign key (agent_detail_id) references lms_agent_db.agent_detail(id),
    index idx_agent_address_locality (locality),
    index idx_agent_address_pin_code (pin_code),
    index idx_agent_address_district (district),
    index idx_agent_address_city (city),
	index idx_agent_address_state (state),
    index idx_agent_address_country (country),
    index idx_agent_address_coordinates (latitude, longitude)
);

create table if not exists lms_agent_db.agent_facility (
	id int auto_increment,
    agent_detail_id int not null,
    name varchar(128) not null,
    establishment_registration_number varchar(50),
    multi_facility_sw bigint default 0,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_agent_facility primary key (id),
    constraint fk_agent_facility_partner_detail foreign key (agent_detail_id) references lms_agent_db.agent_detail(id),
    index idx_agent_facility_establishment_registration_number (establishment_registration_number)
);

create table if not exists lms_agent_db.agent_facility_services (
	id int auto_increment,
    logistic_service_lov_id int not null,
    agent_facility_id int not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_agent_facility_services primary key (id),
    constraint fk_agent_facility_services_agent_facility foreign key (agent_facility_id) references lms_agent_db.agent_facility(id),
    constraint uq_agent_facility_services_logistic_service_lov_agent_facility unique (logistic_service_lov_id, agent_facility_id)
);

create table if not exists lms_agent_db.agent_facility_address (
	id int auto_increment,
    agent_facility_id int not null,
    name varchar(100) not null,
    house_number varchar(100) not null,
    floor varchar(100) not null,
    street_name varchar(100),
    locality varchar(100) not null,
    additional_line_1 varchar(100) not null,
    additional_line_2 varchar(100) not null,
    city varchar(100) not null,
    district varchar(100) not null,
    pin_code varchar(100) not null,
    state varchar(100) not null,
    country varchar(100) not null,
    latitude double not null,
    longitude double not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_agent_facility_address primary key (id),
    constraint fk_agent_facility_address_agent_facility foreign key (agent_facility_id) references lms_agent_db.agent_facility(id),
    index idx_agent_facility_address_locality (locality),
    index idx_agent_facility_address_pin_code (pin_code),
    index idx_agent_facility_address_district (district),
    index idx_agent_facility_address_city (city),
	index idx_agent_facility_address_state (state),
    index idx_agent_facility_address_country (country),
    index idx_agent_facility_address_coordinates (latitude, longitude)
);

-----------------------------------------------------------------------------------------------------------------
-------------------------------------------------- PARTNER DB ---------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

create table if not exists lms_partner_db.partner_model (
	id int auto_increment,
    enterprise_level_lov_id int not null,
    user_detail_id int not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_partner_model primary key (id),
    constraint uq_partner_model_enterprise_level_user_detail unique (enterprise_level_lov_id, user_detail_id)
); 

create table if not exists lms_partner_db.partner_detail (
	id int auto_increment,
    partner_model_id int not null,
    point_of_contact_name varchar(50) not null,
    point_of_contact_email_id varchar(50) not null,
    point_of_contact_phone_number varchar(20) not null,
    tax_number varchar(50) not null,
    facility_sw bigint default 0,
    verified_sw bigint default 0,
    consent_sw bigint default 0,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_partner_detail primary key (id),
    constraint fk_partner_detail_partner_model foreign key (partner_model_id) references lms_partner_db.partner_model(id),
    index idx_partner_detail_poc_name (point_of_contact_name),
    index idx_partner_detail_poc_email_id (point_of_contact_email_id),
    index idx_partner_detail_poc_phone_number (point_of_contact_phone_number),
    index idx_partner_detail_tax_number (tax_number)
);

create table if not exists lms_partner_db.partner_services (
	id int auto_increment,
    laundry_service_lov_id int not null,
    partner_detail_id int not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_partner_services primary key (id),
    constraint fk_partner_services_partner_detail foreign key (partner_detail_id) references lms_partner_db.partner_detail(id),
    constraint uq_partner_services_laundry_service_lov_partner_detail unique (laundry_service_lov_id, partner_detail_id)
);

create table if not exists lms_partner_db.partner_address (
	id int auto_increment,
    partner_detail_id int not null,
    name varchar(100) not null,
    house_number varchar(100) not null,
    floor varchar(100) not null,
    street_name varchar(100),
    locality varchar(100) not null,
    additional_line_1 varchar(100) not null,
    additional_line_2 varchar(100) not null,
    city varchar(100) not null,
    district varchar(100) not null,
    pin_code varchar(100) not null,
    state varchar(100) not null,
    country varchar(100) not null,
    latitude double not null,
    longitude double not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_partner_address primary key (id),
    constraint fk_partner_address_partner_detail foreign key (partner_detail_id) references lms_partner_db.partner_detail(id),
    index idx_partner_address_locality (locality),
    index idx_partner_address_pin_code (pin_code),
    index idx_partner_address_district (district),
    index idx_partner_address_city (city),
	index idx_partner_address_state (state),
    index idx_partner_address_country (country),
    index idx_partner_address_coordinates (latitude, longitude)
);

create table if not exists lms_partner_db.partner_facility (
	id int auto_increment,
    partner_detail_id int not null,
    name varchar(128) not null,
    establishment_registration_number varchar(50),
    multi_facility_sw bigint default 0,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_partner_facility primary key (id),
    constraint fk_partner_facility_partner_detail foreign key (partner_detail_id) references lms_partner_db.partner_detail(id),
    index idx_partner_facility_establishment_registration_number (establishment_registration_number)
);

create table if not exists lms_partner_db.partner_facility_services (
	id int auto_increment,
    laundry_type_lov_id int not null,
    partner_facility_id int not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_partner_facility_services primary key (id),
    constraint fk_partner_facility_services_partner_facility foreign key (partner_facility_id) references lms_partner_db.partner_facility(id),
    constraint uq_partner_facility_services_laundry_type_lov_partner_facility unique (laundry_type_lov_id, partner_facility_id)
);

create table if not exists lms_partner_db.partner_facility_address (
	id int auto_increment,
    partner_facility_id int not null,
    name varchar(100) not null,
    house_number varchar(100) not null,
    floor varchar(100) not null,
    street_name varchar(100),
    locality varchar(100) not null,
    additional_line_1 varchar(100) not null,
    additional_line_2 varchar(100) not null,
    city varchar(100) not null,
    district varchar(100) not null,
    pin_code varchar(100) not null,
    state varchar(100) not null,
    country varchar(100) not null,
    latitude double not null,
    longitude double not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_partner_facility_address primary key (id),
    constraint fk_partner_facility_address_partner_facility foreign key (partner_facility_id) references lms_partner_db.partner_facility(id),
    index idx_partner_facility_address_locality (locality),
    index idx_partner_facility_address_pin_code (pin_code),
    index idx_partner_facility_address_district (district),
    index idx_partner_facility_address_city (city),
	index idx_partner_facility_address_state (state),
    index idx_partner_facility_address_country (country),
    index idx_partner_facility_address_coordinates (latitude, longitude)
);

-----------------------------------------------------------------------------------------------------------------
-------------------------------------------------- CONSENT DB ---------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

create table if not exists lms_consent_db.consent_level_lov (
    id int auto_increment,
    name varchar(20) not null, -- customer, partner, enterprise
    description varchar(100),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_consent_level_lov primary key (id),
    index idx_consent_level_lov_name (name)
);

create table if not exists lms_consent_db.consent_status_lov (
    id int auto_increment,
    name varchar(20) not null, -- waiting, accepted, declined, hold
    description varchar(100),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_consent_type_lov primary key (id),
    index idx_consent_type_lov_name (name)
);

create table if not exists lms_consent_db.consent_model (
	id int auto_increment,
    consent_level_lov_id int not null,
    policy_introduction varchar(255) not null,
    policy_introduction_extension varchar(255),
    policy_introduction_supplementary varchar(255),
    policy_body varchar(255) not null,
    policy_body_extension varchar(255),
    policy_body_supplementary varchar(255),
    policy_conclusion varchar(255) not null,
	policy_conclusion_extension varchar(255),
    policy_conclusion_supplementary varchar(255),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_consent_model primary key (id),
    constraint fk_consent_model_consent_level_lov foreign key (consent_level_lov_id) references lms_consent_db.consent_level_lov(id),
	index idx_consent_model_consent_type_lov (consent_level_lov_id)
);

create table if not exists lms_consent_db.consent_status_reason (
	id int auto_increment,
    consent_status_lov_id int not null,
    text varchar(255), -- other, reason 1, reason 2
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_consent_status_reason primary key (id),
    constraint uq_consent_status_reason_consent_status_lov foreign key (consent_status_lov_id) references lms_consent_db.consent_status_lov(id)
);

create table if not exists lms_consent_db.consent_tracker (
	id int auto_increment,
    consent_model_id int not null,
    user_detail_id int not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_consent_tracker primary key (id),
    constraint fk_consent_tracker_consent_model foreign key (consent_model_id) references lms_consent_db.consent_model(id),
    constraint uq_consent_tracker_consent_model_user_detail unique (consent_model_id, user_detail_id),
	index idx_consent_history_consent_model (consent_model_id)
);

create table if not exists lms_consent_db.consent_tracker_history (
	id int auto_increment,
    consent_tracker_id int not null,
    consent_status_lov_id int not null,
    consent_status_reason_id int not null,
    additional_reason varchar(128),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_consent_tracker_history primary key (id),
    constraint fk_consent_tracker_history_consent_tracker foreign key (consent_tracker_id) references lms_consent_db.consent_tracker(id),
    constraint fk_consent_tracker_history_consent_status_lov foreign key (consent_status_lov_id) references lms_consent_db.consent_status_lov(id),
    constraint fk_consent_tracker_history_consent_status_reason foreign key (consent_status_reason_id) references lms_consent_db.consent_status_reason(id),
    constraint uq_consent_tracker_history_status_lov_status_reason unique (consent_tracker_id, consent_status_lov_id, consent_status_reason_id),
	index idx_consent_history_consent_status (consent_status_lov_id)
);

-----------------------------------------------------------------------------------------------------------------
-------------------------------------------------- VERIFICATION DB ----------------------------------------------
-----------------------------------------------------------------------------------------------------------------

create table if not exists lms_verification_db.verification_level_lov (
    id int auto_increment,
    name varchar(20) not null, -- basic, intermediate, advanced
    priority int not null,
    description varchar(100),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_verification_level_lov primary key (id),
    constraint chk_verification_level_lov_priority check (prority > 0),
    index idx_verification_level_lov_name (name)
);

create table if not exists lms_verification_db.verification_status_lov (
	id int auto_increment,
    name varchar(20) not null, -- pending, completed, aborted, failed, hold
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_verification_status_lov primary key (id)
);

create table if not exists lms_verification_db.verification_model ( -- customer-basic, customer-intermediate, agent-basic, agent-intermediate, agent-advanced, partner-basic, partner-intermediate, partner-advanced
	id int auto_increment,
    verification_level_lov_id int not null,
    role_lov_id int not null,
    requires_basic_verification_sw bigint default 0,
    requires_intermediate_verification_sw bigint default 1,
    requires_advanced_verification_sw bigint default 1,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_verification_model primary key (id),
    constraint fk_verification_model_verification_level_lov foreign key (verification_level_lov_id) references lms_verification_db.verification_level_lov(id),
    constraint uq_verification_model_verification_level_lov_role_lov unique (verification_level_lov_id, role_lov_id)
);

create table if not exists lms_verification_db.basic_verification_model (
	id int auto_increment,
    verification_model_id int not null,
    phone_number_verification_sw bigint default 0,
    email_id_verification_sw bigint default 0,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_basic_verification_model primary key (id),
    constraint fk_basic_verification_model_verification_model foreign key (verification_model_id) references lms_verification_db.verification_model(id)
);

create table if not exists lms_verification_db.intermediate_verification_model (
	id int auto_increment,
    basic_verification_model_id int not null,
    tax_number_verification_sw bigint default 0,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_intermediate_verification_model primary key (id),
    constraint fk_intermediate_verification_model_basic_verification_model foreign key (basic_verification_model_id) references lms_verification_db.basic_verification_model(id)
);

create table if not exists lms_verification_db.advanced_verification_model (
	id int auto_increment,
    intermediate_verification_model_id int not null,
    establishment_registration_number_verification_sw bigint default 0,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_advanced_verification_model primary key (id),
    constraint fk_advanced_verification_model_intermediate_verification_model foreign key (intermediate_verification_model_id ) references lms_verification_db.intermediate_verification_model(id)
);

create table if not exists lms_verification_db.verification_status_reason (
	id int auto_increment,
    verification_status_lov_id int not null,
    text varchar(255), -- other, reason 1, reason 2
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_verification_status_reason primary key (id),
	constraint uq_verification_status_reason_verification_status_lov foreign key (verification_status_lov_id) references lms_verification_db.verification_status_lov(id)
);

create table if not exists lms_verification_db.verification_tracker (
	id int auto_increment,
    verification_model_id int not null,
    user_detail_id int not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_verification_tracker primary key (id),
    constraint fk_verification_tracker_verification_model foreign key (verification_model_id) references lms_verification_db.verification_model(id),
    constraint uq_verification_tracker_verification_model_user_detail unique (verification_model_id, user_detail_id),
	index idx_verification_tracker_verification_model (verification_model_id)
);

create table if not exists lms_verification_db.verification_tracker_history (
	id int auto_increment,
    verification_tracker_id int not null,
    verification_status_lov_id int not null,
    verification_status_reason_id int not null,
    additional_reason varchar(128),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_verification_tracker_history primary key (id),
    constraint fk_verification_tracker_history_verification_tracker foreign key (verification_tracker_id) references lms_verification_db.verification_tracker(id),
    constraint fk_verification_tracker_history_verification_status_lov foreign key (verification_status_lov_id) references lms_verification_db.verification_status_lov(id),
    constraint fk_verification_tracker_history_verification_status_reason foreign key (verification_status_reason_id) references lms_verification_db.verification_status_reason(id),
    index idx_verification_tracker_history_verification_tracker (verification_tracker_id),
    index idx_verification_tracker_history_verification_status (verification_status_lov_id)
);

-----------------------------------------------------------------------------------------------------------------
-------------------------------------------------- WASH DB ------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

create table if not exists lms_wash_db.wash_status_lov (
	id int auto_increment,
    name varchar(50) not null, -- draft, inspecting, washing, drying, folding, ready, cancelled, failed, hold
    description varchar(100),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_wash_status_lov primary key (id)
);

create table if not exists lms_wash_db.wash_type_lov (
	id int auto_increment,
    name varchar(50) not null, -- machine, hand
    description varchar(100),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_wash_type_lov primary key (id)
);

create table if not exists lms_wash_db.wash_load_lov (
	id int auto_increment,
    name varchar(50) not null, -- weighted, individual
    description varchar(100),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_wash_load_lov primary key (id)
);

create table if not exists lms_wash_db.washing_model (
	id int auto_increment,
    wash_type_lov_id int not null,
    wash_load_lov_id int not null,
    partner_id int not null,
    name varchar(50) not null, -- machine-weighted, machine-individual, hand-washed-individual
    description varchar(100),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_washing_model primary key (id),
    constraint fk_washing_model_wash_type_lov foreign key (wash_type_lov_id) references lms_wash_db.wash_type_lov(id),
    constraint fk_washing_model_wash_load_lov foreign key (wash_load_lov_id) references lms_wash_db.wash_load_lov(id)
);

-----------------------------------------------------------------------------------------------------------------
-------------------------------------------------- WASH PRICE DB ---------------------------------------------
-----------------------------------------------------------------------------------------------------------------

create table if not exists lms_wash_pricing_db.weighted_washing_model (
	id int auto_increment,
    washing_model_id int not null,
    clothing_type_lov_id int not null,
    partner_id int not null,
    name varchar(50) not null, -- machine-weighted-garments, machine-weighted-household
    description varchar(100),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_weighted_washing_model primary key (id)
);

create table if not exists lms_wash_pricing_db.individual_washing_model (
	id int auto_increment,
    washing_model_id int not null,
    clothing_item_id int not null,
	name varchar(50) not null, -- machine-individual-shirt, machine-individual-towels, hand-washed-individual-curtains, hand-washed-individual-saree, hand-washed-individual-pant
    description varchar(100),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_individual_washing_model primary key (id)
);

create table if not exists lms_wash_pricing_db.washing_price_rule (
	id int auto_increment,
    washing_model_id int not null,
	name varchar(50) not null, -- machine-weighted-garments-N-inr, machine-weighted-household-N-inr, machine-individual-shirt-N-inr, machine-individual-towel-N-inr, hand-washed-individual-saree-N-inr, hand-washed-individual-curtain-N-inr
    description varchar(100),
	per_unit_price float not null,
    price_currency varchar(10) not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_washing_price_rule primary key (id),
    constraint chk_washing_price_rule_per_unit_price check (per_unit_price > 0)
);

create table if not exists lms_wash_pricing_db.weighted_washing_rate (
	id int auto_increment,
    washing_price_rule_id int not null,
    weighted_washing_model_id int not null,
	name varchar(50) not null, -- machine-weighted-garments-inr-kg, machine-weighted-household-inr-kg
    description varchar(100),
    per_unit_weight float not null,
	weight_unit varchar(10) not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_weighted_washing_rate primary key (id),
    constraint fk_weighted_washing_rate_washing_price_rule foreign key (washing_price_rule_id) references lms_wash_pricing_db.washing_price_rule(id),
    constraint fk_weighted_washing_rate_weighted_washing_model foreign key (weighted_washing_model_id) references lms_wash_pricing_db.weighted_washing_model(id),
    constraint chk_weighted_washing_rate_per_unit_weight check (per_unit_weight > 0)
);

create table if not exists lms_wash_pricing_db.individual_washing_rate (
	id int auto_increment, 
    washing_price_rule_id int not null,
    individual_washing_model_id int not null,
    name varchar(50) not null, -- machine-individual-shirt-inr-N-count, machine-individual-towel-inr-N-count, hand-washed-individual-saree-inr-N-count, hand-washed-individual-curtain-inr-N-count
    description varchar(100),
    per_unit_count int not null,
	created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_individual_washing_rate primary key (id),
    constraint fk_individual_washing_rate_washing_price_rule foreign key (washing_price_rule_id) references lms_wash_pricing_db.washing_price_rule(id),
    constraint fk_individual_washing_rate_individual_washing_model foreign key (individual_washing_model_id) references lms_wash_pricing_db.individual_washing_model(id),
    constraint chk_individual_washing_rate_per_unit_count check (per_unit_count > 0)
);

-----------------------------------------------------------------------------------------------------------------
-------------------------------------------------- WASH DISCOUNT DB ---------------------------------------------
-----------------------------------------------------------------------------------------------------------------

create table if not exists lms_wash_discount_db.weighted_washing_discount_model (
	id int auto_increment,
    weighted_washing_model_id int not null,
    discount_model_id int not null,
    partner_id int not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_weighted_washing_discount_model primary key (id)
);

create table if not exists lms_wash_discount_db.weighted_washing_discount_rate (
	id int auto_increment,
    weighted_washing_discount_model_id int not null,
    name varchar(50) not null, -- subscription-basic-10, subscription-premium-15, deal-flat-100-less, deal-machine-weighted-household-30-off, deal-machine-weighted-garment-5-less, deal-machine-weighted-garments-free-shipping
    description varchar(100),
    discount_value float not null,
    minimum_expected_value float not null,
    maximum_allowed_value float not null,
    free_logistics_sw bigint not null,
    starts_on timestamp not null,
    expires_on timestamp not null,
    expired_sw bigint default 0,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_weighted_washing_discount_rate primary key (id),
    constraint fk_ww_discount_rate_ww_discount_model foreign key (weighted_washing_discount_model_id) references lms_wash_discount_db.weighted_washing_discount_model(id),
    constraint uq_weighted_washing_discount_rate_name unique (weighted_washing_discount_model_id, name),
    constraint chk_weighted_washing_discount_rate_discount_value check (discount_value > 0),
    constraint chk_weighted_washing_discount_rate_minimum_expected_value check (minimum_expected_value > 0),
    constraint chk_weighted_washing_discount_rate_maximum_allowed_value check (maximum_allowed_value > 0),
    constraint chk_weighted_washing_discount_rate_start_before_expiry check (starts_on < expires_on)
);

create table if not exists lms_wash_discount_db.weighted_washing_discount_logistics (
	id int auto_increment,
    weighted_washing_discount_rate_id int not null,
    free_pickup_sw bigint default 0,
    free_delivery_sw bigint default 0,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_weighted_washing_discount_logistics primary key (id),
    constraint fk_ww_discount_logistics_ww_discount_rate foreign key (weighted_washing_discount_rate_id) references lms_wash_discount_db.weighted_washing_discount_rate(id),
    constraint uq_weighted_washing_discount_logistics_pickup_delivery unique (weighted_washing_discount_rate_id, free_pickup_sw, free_delivery_sw)
);

create table if not exists lms_wash_discount_db.weighted_washing_discount_rate_currency (
	id int auto_increment,
    weighted_washing_discount_rate_id int not null,
    currency_type_lov_id int not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_weighted_washing_discount_rate_currency primary key (id),
    constraint fk_ww_discount_rate_currency_ww_discount_rate foreign key (weighted_washing_discount_rate_id) references lms_wash_discount_db.weighted_washing_discount_rate(id)
);

create table if not exists lms_wash_discount_db.weighted_washing_discount_rate_history (
	id int auto_increment,
    weighted_washing_discount_rate_id int not null,
    discount_status_lov_id int not null,
    discount_status_reason_id int not null,
    additional_reason varchar(128),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_weighted_washing_discount_rate_history primary key (id),
    constraint fk_ww_discount_rate_history_ww_discount_rate foreign key (weighted_washing_discount_rate_id) references lms_wash_discount_db.weighted_washing_discount_rate(id)
);

create table if not exists lms_wash_discount_db.weighted_washing_discount_coupon (
	id int auto_increment,
    weighted_washing_discount_rate_id int not null,
    code_hash varchar(128) not null, 
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_weighted_washing_discount_coupon primary key (id),
    constraint fk_ww_discount_coupon_ww_discount_rate foreign key (weighted_washing_discount_rate_id) references lms_wash_discount_db.weighted_washing_discount_rate(id)
);

create table if not exists lms_wash_discount_db.individual_washing_discount_model (
	id int auto_increment,
    individual_washing_model_id int not null,
    discount_model_id int not null,
    partner_id int not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_individual_washing_discount_model primary key (id)
);

create table if not exists lms_wash_discount_db.individual_washing_discount_rate (
	id int auto_increment,
    individual_washing_discount_model_id int not null,
    name varchar(50) not null, -- subscription-basic-10, subscription-premium-15, deal-flat-100-less, deal-machine-weighted-household-30-off, deal-machine-weighted-garment-5-less, deal-machine-weighted-garments-free-shipping
    description varchar(100),
    discount_value float not null,
    minimum_expected_value float not null,
    maximum_allowed_value float not null,
    free_logistics_sw bigint not null,
    starts_on timestamp not null,
    expires_on timestamp not null,
    expired_sw bigint default 0,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_individual_washing_discount_rate primary key (id),
    constraint fk_iw_discount_rate_iw_discount_model foreign key (individual_washing_discount_model_id) references lms_wash_discount_db.individual_washing_discount_model(id),
    constraint uq_individual_washing_discount_rate_name unique (individual_washing_discount_model_id, name),
    constraint chk_individual_washing_discount_rate_discount_value check (discount_value > 0),
    constraint chk_individual_washing_discount_rate_minimum_expected_value check (minimum_expected_value > 0),
    constraint chk_individual_washing_discount_rate_maximum_allowed_value check (maximum_allowed_value > 0),
    constraint chk_individual_washing_discount_rate_start_before_expiry check (starts_on < expires_on)
);

create table if not exists lms_wash_discount_db.individual_washing_discount_logistics (
	id int auto_increment,
    individual_washing_discount_rate_id int not null,
    free_pickup_sw bigint default 0,
    free_delivery_sw bigint default 0,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_individual_washing_discount_logistics primary key (id),
    constraint fk_iw_discount_logistics_iw_discount_rate foreign key (individual_washing_discount_rate_id) references lms_wash_discount_db.individual_washing_discount_rate(id),
    constraint uq_individual_washing_discount_logistics_pickup_delivery unique (individual_washing_discount_rate_id, free_pickup_sw, free_delivery_sw)
);

create table if not exists lms_wash_discount_db.individual_washing_discount_rate_currency (
	id int auto_increment,
    individual_washing_discount_rate_id int not null,
    currency_type_lov_id int not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_individual_washing_discount_rate_currency primary key (id),
    constraint fk_iw_discount_rate_currency_iw_discount_rate foreign key (individual_washing_discount_rate_id) references lms_wash_discount_db.individual_washing_discount_rate(id)
);

create table if not exists lms_wash_discount_db.individual_washing_discount_rate_history (
	id int auto_increment,
    individual_washing_discount_rate_id int not null,
    discount_status_lov_id int not null,
    discount_status_reason_id int not null,
    additional_reason varchar(128),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_individual_washing_discount_rate_history primary key (id),
    constraint fk_iw_discount_rate_history_iw_discount_rate foreign key (individual_washing_discount_rate_id) references lms_wash_discount_db.individual_washing_discount_rate(id)
);

create table if not exists lms_wash_discount_db.individual_washing_discount_coupon (
	id int auto_increment,
    individual_washing_discount_rate_id int not null,
    code_hash varchar(128) not null, 
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_individual_washing_discount_coupon primary key (id),
    constraint fk_iw_discount_coupon_iw_discount_rate foreign key (individual_washing_discount_rate_id) references lms_wash_discount_db.individual_washing_discount_rate(id)
);

-----------------------------------------------------------------------------------------------------------------
-------------------------------------------------- WASH TRACKING DB ---------------------------------------------
-----------------------------------------------------------------------------------------------------------------

create table if not exists lms_wash_tracking_db.washable_item_tracker (
	id int auto_increment,
    order_number varchar(128) not null,
    order_line_id int not null,
    sequence int not null,
    tag_id varchar(100),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_washable_item_tracker primary key (id),
    constraint chk_washable_item_tracker_sequence check (sequence > 0)
);

create table if not exists lms_wash_tracking_db.wash_status_reason (
	id int auto_increment,
    text varchar(255), -- other, reason 1, reason 2, payment completed, 
    wash_status_lov_id int not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_wash_status_reason primary key (id)
);

create table if not exists lms_wash_tracking_db.washable_item_tracking_history (
	id int auto_increment,
    washable_item_tracker_id int not null,
    wash_status_lov_id int not null,
    wash_status_reason_id int not null,
    additional_reason varchar(128),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_washable_item_tracking_history primary key (id),
    constraint fk_washable_item_tracking_history_washable_item_tracker foreign key (washable_item_tracker_id) references lms_wash_tracking_db.washable_item_tracker(id),
    constraint fk_washable_item_tracking_history_wash_status_reason foreign key (wash_status_reason_id) references lms_wash_tracking_db.wash_status_reason(id)
);

-----------------------------------------------------------------------------------------------------------------
-------------------------------------------------- IRON DB ------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

create table if not exists lms_iron_db.iron_status_lov (
	id int auto_increment,
    name varchar(50) not null, -- new, inspecting, ironing, folding, ready, failed, hold
    description varchar(100),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_wash_status_lov primary key (id)
);

create table if not exists lms_iron_db.iron_type_lov (
	id int auto_increment,
    name varchar(50) not null, -- modern-steam, old-school-water, no-iron
    description varchar(100),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_wash_type_lov primary key (id)
);

-----------------------------------------------------------------------------------------------------------------
-------------------------------------------------- IRON PRICING DB ----------------------------------------------
-----------------------------------------------------------------------------------------------------------------

create table if not exists lms_iron_pricing_db.ironing_model (
	id int auto_increment,
    iron_type_lov_id int not null,
    clothing_item_id int not null,
    partner_id int not null,
    name varchar(50) not null, -- modern-steam-shirt, modern-steam-towels, modern-steam-curtains, old-school-water-saree, old-school-water-pant, no-iron-sweater
    description varchar(100),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_ironing_model primary key (id)
);

create table if not exists lms_iron_pricing_db.ironing_price_rule (
	id int auto_increment,
    ironing_model_id int not null,
    name varchar(50) not null, -- modern-steam-shirt-inr, modern-steam-pant-inr, modern-steam-t-shirt-inr, old-school-water-saree-inr, old-school-water-jeans-inr
    description varchar(100),
    per_unit_price float not null,
    price_currency varchar(10) not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_ironing_price_rule primary key (id),
    constraint fk_ironing_price_rule_ironing_model foreign key (ironing_model_id) references lms_iron_pricing_db.ironing_model(id)
);

create table if not exists lms_iron_pricing_db.ironing_rate (
	id int auto_increment,
    ironing_price_rule_id int not null,
    name varchar(50) not null, -- modern-steam-shirt-inr-N-count, modern-steam-pant-inr-N-count, modern-steam-t-shirt-inr-N-count, old-school-water-saree-inr-N-count, old-school-water-jeans-inr-N-count
    description varchar(100),
    per_unit_count int not null,
	created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_ironing_rate primary key (id),
    constraint fk_ironing_rate_ironing_price_rule foreign key (ironing_price_rule_id) references lms_iron_pricing_db.ironing_price_rule(id),
    constraint chk_ironing_rate_per_unit_count check (per_unit_count > 0)
);

-----------------------------------------------------------------------------------------------------------------
-------------------------------------------------- IRON DISCOUNT DB ---------------------------------------------
-----------------------------------------------------------------------------------------------------------------

create table if not exists lms_iron_discount_db.ironing_discount_model (
	id int auto_increment,
    ironing_model_id int not null,
    discount_model_id int not null,
    partner_id int not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_ironing_discount_model primary key (id)
);

create table if not exists lms_iron_discount_db.ironing_discount_rate (
	id int auto_increment,
    ironing_discount_model_id int not null,
    name varchar(50) not null, -- subscription-basic-10, subscription-premium-15, deal-flat-100-less, deal-machine-weighted-household-30-off, deal-machine-weighted-garment-5-less, deal-machine-weighted-garments-free-shipping
    description varchar(100),
    discount_value float not null,
    minimum_expected_value float not null,
    maximum_allowed_value float not null,
    free_logistics_sw bigint not null,
    starts_on timestamp not null,
    expires_on timestamp not null,
    expired_sw bigint default 0,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_ironing_discount_rate primary key (id),
    constraint fk_ironing_discount_rate_ironing_discount_model foreign key (ironing_discount_model_id) references lms_iron_discount_db.ironing_discount_model(id),
    constraint uq_ironing_discount_rate_name unique (ironing_discount_model_id, name),
    constraint chk_ironing_discount_rate_discount_value check (discount_value > 0),
    constraint chk_ironing_discount_rate_minimum_expected_value check (minimum_expected_value > 0),
    constraint chk_ironing_discount_rate_maximum_allowed_value check (maximum_allowed_value > 0),
    constraint chk_ironing_discount_rate_start_before_expiry check (starts_on < expires_on)
);

create table if not exists lms_iron_discount_db.ironing_discount_logistics (
	id int auto_increment,
    ironing_discount_rate_id int not null,
    free_pickup_sw bigint default 0,
    free_delivery_sw bigint default 0,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_ironing_discount_logistics primary key (id),
    constraint fk_iw_discount_logistics_iw_discount_rate foreign key (ironing_discount_rate_id) references lms_iron_discount_db.ironing_discount_rate(id),
    constraint uq_ironing_discount_logistics_pickup_delivery unique (ironing_discount_rate_id, free_pickup_sw, free_delivery_sw)
);

create table if not exists lms_iron_discount_db.ironing_discount_rate_currency (
	id int auto_increment,
    ironing_discount_rate_id int not null,
    currency_type_lov_id int not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_ironing_discount_rate_currency primary key (id),
    constraint fk_ironing_discount_rate_currency_ironing_discount_rate foreign key (ironing_discount_rate_id) references lms_iron_discount_db.ironing_discount_rate(id)
);

create table if not exists lms_iron_discount_db.ironing_discount_rate_history (
	id int auto_increment,
    ironing_discount_rate_id int not null,
    discount_status_lov_id int not null,
    discount_status_reason_id int not null,
    additional_reason varchar(128),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_ironing_discount_rate_history primary key (id),
    constraint fk_ironing_discount_rate_history_ironing_discount_rate foreign key (ironing_discount_rate_id) references lms_iron_discount_db.ironing_discount_rate(id)
);

create table if not exists lms_iron_discount_db.ironing_discount_coupon (
	id int auto_increment,
    ironing_discount_rate_id int not null,
    code_hash varchar(128) not null, 
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_ironing_discount_coupon primary key (id),
    constraint fk_ironing_discount_coupon_ironing_discount_rate foreign key (ironing_discount_rate_id) references lms_iron_discount_db.ironing_discount_rate(id)
);

-----------------------------------------------------------------------------------------------------------------
-------------------------------------------------- IRON TRACKING DB ---------------------------------------------
-----------------------------------------------------------------------------------------------------------------

create table if not exists lms_iron_tracking_db.ironable_item_tracker (
	id int auto_increment,
    order_number varchar(128) not null,
    order_line_id int not null,
    sequence int not null,
    tag_id varchar(100) not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_ironable_item_tracker primary key (id),
	constraint chk_ironable_item_tracker_sequence check (sequence > 0)
);

create table if not exists lms_iron_tracking_db.iron_status_reason (
	id int auto_increment,
    text varchar(255), -- other, reason 1, reason 2
    iron_status_lov_id int not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_iron_status_reason primary key (id)
);

create table if not exists lms_iron_tracking_db.ironable_item_tracking_history (
	id int auto_increment,
    ironable_item_tracker_id int not null,
    iron_status_lov_id int not null,
    iron_status_reason_id int not null,
    additional_reason varchar(128),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_ironable_item_tracking_history primary key (id),
    constraint fk_ironable_item_tracking_history_ironable_item_tracker foreign key (ironable_item_tracker_id) references lms_iron_tracking_db.ironable_item_tracker(id),
    constraint fk_ironable_item_tracking_history_iron_status_reason foreign key (iron_status_reason_id) references lms_iron_tracking_db.iron_status_reason(id)
);

------------------------------------------------------------------------------------------------------------------
-------------------------------------------------- DRY CLEAN DB --------------------------------------------------
------------------------------------------------------------------------------------------------------------------

create table if not exists lms_dry_clean_db.dry_cleaning_status_lov (
	id int auto_increment,
    name varchar(50) not null, -- new, inspecting, cleaning, rinsing, drying, folding, ready, failed, hold
    description varchar(100),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_dry_cleaning_status_lov primary key (id)
);

create table if not exists lms_dry_clean_db.dry_cleaning_type_lov (
	id int auto_increment,
    name varchar(50) not null, -- hcs, hcs-gentle, hcs-very-dentle, pce, pce-gentle, pce-very-gentle
    description varchar(100),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_dry_cleaning_type_lov primary key (id)
);

------------------------------------------------------------------------------------------------------------------
-------------------------------------------------- DRY CLEAN PRICE DB --------------------------------------------
------------------------------------------------------------------------------------------------------------------

create table if not exists lms_dry_clean_pricing_db.dry_cleaning_model (
	id int auto_increment,
    dry_cleaning_type_lov_id int not null,
    clothing_item_id int not null,
    partner_id int not null,
    name varchar(50) not null, -- hcs-cotton-shirt, hcs-gentle-silk-shirt, pce-cotton-towel, pce-jute-carpet, hcs-cotton-jeans, pce-very-gentle-woollen-suit
    description varchar(100),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_dry_cleaning_model primary key (id)
);

create table if not exists lms_dry_clean_pricing_db.dry_cleaning_price_rule (
	id int auto_increment,
    dry_cleaning_model_id int not null,
    name varchar(50) not null, -- hcs-cotton-shirt-inr, hcs-gentle-silk-shirt-inr, pce-cotton-towel-inr, pce-jute-carpet-inr, hcs-cotton-jeans-inr, pce-very-gentle-woollen-suit-inr
    description varchar(100),
    per_unit_price float not null,
    price_currency varchar(10) not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_dry_cleaning_price_rule primary key (id),
    constraint fk_dry_cleaning_price_rule_dry_cleaning_model foreign key (dry_cleaning_model_id) references lms_dry_clean_pricing_db.dry_cleaning_model(id)
);

create table if not exists lms_dry_clean_pricing_db.dry_cleaning_rate (
	id int auto_increment,
    dry_cleaning_price_rule_id int not null,
    name varchar(50) not null, -- hcs-cotton-shirt-inr-N-count, hcs-gentle-silk-shirt-inr-N-count, pce-cotton-towel-inr-N-count, pce-jute-carpet-inr-N-count, hcs-cotton-jeans-inr-N-count, pce-very-gentle-woollen-suit-inr-N-count
    description varchar(100),
    per_unit_count int not null,
	created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_dry_cleaning_rate primary key (id),
    constraint fk_dry_cleaning_rate_dry_cleaning_price_rule foreign key (dry_cleaning_price_rule_id) references lms_dry_clean_pricing_db.dry_cleaning_price_rule(id),
    constraint chk_dry_cleaning_rate_per_unit_count check (per_unit_count > 0)
);

-----------------------------------------------------------------------------------------------------------------
--------------------------------------------- DRY CLEAN DISCOUNT DB ---------------------------------------------
-----------------------------------------------------------------------------------------------------------------

create table if not exists lms_dry_clean_discount_db.dry_cleaning_discount_model (
	id int auto_increment,
    dry_cleaning_model_id int not null,
    discount_model_id int not null,
    partner_id int not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_dry_cleaning_discount_model primary key (id)
);

create table if not exists lms_dry_clean_discount_db.dry_cleaning_discount_rate (
	id int auto_increment,
    dry_cleaning_discount_model_id int not null,
    name varchar(50) not null, -- subscription-basic-10, subscription-premium-15, deal-flat-100-less, deal-machine-weighted-household-30-off, deal-machine-weighted-garment-5-less, deal-machine-weighted-garments-free-shipping
    description varchar(100),
    discount_value float not null,
    minimum_expected_value float not null,
    maximum_allowed_value float not null,
    free_logistics_sw bigint not null,
    starts_on timestamp not null,
    expires_on timestamp not null,
    expired_sw bigint default 0,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_dry_cleaning_discount_rate primary key (id),
    constraint fk_dry_cleaning_discount_rate_ironing_discount_model foreign key (dry_cleaning_discount_model_id) references lms_dry_clean_discount_db.dry_cleaning_discount_model(id),
    constraint uq_dry_cleaning_discount_rate_name unique (dry_cleaning_discount_model_id, name),
    constraint chk_dry_cleaning_discount_rate_discount_value check (discount_value > 0),
    constraint chk_dry_cleaning_discount_rate_minimum_expected_value check (minimum_expected_value > 0),
    constraint chk_dry_cleaning_discount_rate_maximum_allowed_value check (maximum_allowed_value > 0),
    constraint chk_dry_cleaning_discount_rate_start_before_expiry check (starts_on < expires_on)
);

create table if not exists lms_dry_clean_discount_db.dry_cleaning_discount_logistics (
	id int auto_increment,
    dry_cleaning_discount_rate_id int not null,
    free_pickup_sw bigint default 0,
    free_delivery_sw bigint default 0,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_dry_cleaning_discount_logistics primary key (id),
    constraint fk_dc_discount_logistics_dc_discount_rate foreign key (dry_cleaning_discount_rate_id) references lms_dry_clean_discount_db.dry_cleaning_discount_rate(id),
    constraint uq_dry_cleaning_discount_logistics_pickup_delivery unique (dry_cleaning_discount_rate_id, free_pickup_sw, free_delivery_sw)
);

create table if not exists lms_dry_clean_discount_db.dry_cleaning_discount_rate_currency (
	id int auto_increment,
    dry_cleaning_discount_rate_id int not null,
    currency_type_lov_id int not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_dry_cleaning_discount_rate_currency primary key (id),
    constraint fk_dc_discount_rate_currency_dc_discount_rate foreign key (dry_cleaning_discount_rate_id) references lms_dry_clean_discount_db.dry_cleaning_discount_rate(id)
);

create table if not exists lms_dry_clean_discount_db.dry_cleaning_discount_rate_history (
	id int auto_increment,
    dry_cleaning_discount_rate_id int not null,
    discount_status_lov_id int not null,
    discount_status_reason_id int not null,
    additional_reason varchar(128),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_dry_cleaning_discount_rate_history primary key (id),
    constraint fk_dc_discount_rate_history_dc_discount_rate foreign key (dry_cleaning_discount_rate_id) references lms_dry_clean_discount_db.dry_cleaning_discount_rate(id)
);

create table if not exists lms_dry_clean_discount_db.dry_cleaning_discount_coupon (
	id int auto_increment,
    dry_cleaning_discount_rate_id int not null,
    code_hash varchar(128) not null, 
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_dry_cleaning_discount_coupon primary key (id),
    constraint fk_dc_discount_coupon_dc_discount_rate foreign key (dry_cleaning_discount_rate_id) references lms_dry_clean_discount_db.dry_cleaning_discount_rate(id)
);

------------------------------------------------------------------------------------------------------------------
-------------------------------------------------- DRY CLEAN TRACKING DB --------------------------------------------
------------------------------------------------------------------------------------------------------------------

create table if not exists lms_dry_clean_tracking_db.dry_cleanable_item_tracker (
	id int auto_increment,
    order_number varchar(128) not null,
    order_line_id int not null,
    sequence int not null,
    tag_id varchar(100) not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_dry_cleanable_item_tracker primary key (id),
	constraint chk_dry_cleanable_item_tracker_sequence check (sequence > 0)
);

create table if not exists lms_dry_clean_tracking_db.dry_cleaning_status_reason (
	id int auto_increment,
    text varchar(255), -- other, reason 1, reason 2
    dry_cleaning_status_lov_id int not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_dry_cleaning_status_reason primary key (id)
);

create table if not exists lms_dry_clean_tracking_db.dry_cleanable_item_tracking_history (
	id int auto_increment,
    dry_cleanable_item_tracker_id int not null,
    dry_cleaning_status_lov_id int not null,
    dry_cleaning_status_reason_id int not null,
    additional_reason varchar(128),
    reason varchar(128),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_dry_cleanable_item_tracking_history primary key (id),
    constraint fk_dryc_item_tracking_history_dryc_item_tracker foreign key (dry_cleanable_item_tracker_id) references lms_dry_clean_tracking_db.dry_cleanable_item_tracker(id),
    constraint fk_dryc_item_tracking_history_dryc_status_reason foreign key (dry_cleaning_status_reason_id) references lms_dry_clean_tracking_db.dry_cleaning_status_reason(id)
);

-----------------------------------------------------------------------------------------------------------------
-------------------------------------------------- ORDER DB -----------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

create table if not exists lms_order_db.order_status_lov (
	id int auto_increment,
    name varchar(20) not null, -- new, processing, ready, completed, cancelled, failed, hold
    description varchar(100),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_order_status_lov primary key (id)
);

create table if not exists lms_order_db.order_deduction_type_lov (
	id int auto_increment,
    name varchar(20) not null, -- discount, deal, subscription
    description varchar(100),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_order_deduction_type_lov primary key (id)
);

create table if not exists lms_order_db.order_additive_type_lov (
	id int auto_increment,
    name varchar(20) not null, -- tax, pickup, delivery
    description varchar(100),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_order_additive_type_lov primary key (id)
);

create table if not exists lms_order_db.order_header (
	id int auto_increment,
    user_id int not null,
    enterprise_id int not null,
    number varchar(128) not null,
	opened_on timestamp,
    closed_on timestamp,
    comment varchar(255),
    sub_total float not null,
    total_deductions float default 0,
    total_additives float default 0,
    currency varchar(10) not null,
    payment_sw bigint default 0,
    hold_sw bigint default 0,
    self_pickup_sw bigint default 1,
    self_deliver_sw bigint default 1,
    created_on timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_order_header primary key (id),
    constraint chk_order_header_sub_total check (sub_total >= 0),
    constraint chk_order_header_total_deductions check (total_deductions >= 0),
    constraint chk_order_header_total_additives check (total_additives >= 0)
);

create table if not exists lms_order_db.order_additive_tracker (
	id int auto_increment,
    order_header_id int not null,
    order_additive_type_lov_id int not null,
    charge_name varchar(50) not null,
    charged_amount float not null,
    currency varchar(10) not null,
    created_on timestamp,
    closed_on timestamp, -- completed or falure
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_order_additive_tracker primary key (id),
    constraint fk_order_additive_tracker_order_additive_type foreign key (order_additive_type_lov_id) references lms_order_db.order_additive_type_lov(id),
    constraint fk_order_additive_tracker_order_header foreign key (order_header_id) references lms_order_db.order_header(id),
    constraint chk_order_additive_tracker_discounted_amount check (charged_amount >= 0),
    constraint uq_oat_order_header_additive_type_lov_charge_name unique (order_header_id, order_additive_type_lov_id, charge_name)
);

create table if not exists lms_order_db.order_deduction_tracker (
	id int auto_increment,
    order_header_id int not null,
    order_deduction_type_lov_id int not null,
    discount_name varchar(50) not null,
    discounted_amount float not null,
    currency varchar(10) not null,
    created_on timestamp,
    closed_on timestamp, -- completed or falure
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_order_deduction_tracker primary key (id),
    constraint fk_order_deduction_tracker_order_deduction_type foreign key (order_deduction_type_lov_id) references lms_order_db.order_deduction_type_lov(id),
    constraint fk_order_deduction_tracker_order_header foreign key (order_header_id) references lms_order_db.order_header(id),
    constraint chk_order_deduction_tracker_discounted_amount check (discounted_amount >= 0),
    constraint uq_odt_order_header_deduction_type_lov_discount_name unique (order_header_id, order_deduction_type_lov_id, discount_name)
);

create table if not exists lms_order_db.order_status_reason (
	id int auto_increment,
    text varchar(255), -- other, reason 1, reason 2
    order_status_lov_id int not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_order_status_reason primary key (id),
    constraint fk_order_status_reason_order_status_lov foreign key (order_status_lov_id) references lms_order_db.order_status_lov(id)
);

create table if not exists lms_order_db.order_status_history (
	id int auto_increment,
    order_header_id int not null,
    order_status_lov_id int not null,
    order_status_reason_id int not null,
    additional_reason varchar(128),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_order_status_history primary key (id),
    constraint fk_order_status_history_order_status_lov foreign key (order_status_lov_id) references lms_order_db.order_status_lov(id),
    constraint fk_order_status_history_order_header foreign key (order_header_id) references lms_order_db.order_header(id),
    constraint fk_order_status_history_order_status_reason foreign key (order_status_reason_id) references lms_order_db.order_status_reason(id)
);

create table if not exists lms_order_db.order_line (
	id int auto_increment,
    order_header_id int not null,
    lanudry_service_lov_id int not null,
    sequence int not null,
    comment varchar(255),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_order_line primary key (id),
    constraint fk_order_line_order_header foreign key (order_header_id) references lms_order_db.order_header(id),
    constraint chk_order_line_sequence check (sequence > 0),
    constraint chk_order_line_quantity check (quantity > 0),
    constraint chk_order_line_rate check (rate > 0)
);

create table if not exists lms_order_db.order_line_detail (
	id int auto_increment,
    order_line_id int not null,
    clothing_item_id int not null,
    sequence int not null,
    quantity float not null,
    rate float not null, -- quanity per unit / price per unit,
    instruction varchar(255),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_order_line_detail primary key (id),
    constraint fk_order_line_detail_order_line foreign key (order_line_id) references lms_order_db.order_line(id),
    constraint chk_order_line_detail_sequence check (sequence > 0),
    constraint chk_order_line_detail_quantity check (quantity > 0),
    constraint chk_order_line_detail_rate check (rate > 0)
);

-----------------------------------------------------------------------------------------------------------------
-------------------------------------------------- PAYMENT DB ---------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

create table if not exists lms_payment_db.transaction_status_lov (
	id int auto_increment,
    name varchar(50) not null, -- new, in-progress, finished, aborted, failure, hold
    description varchar(100),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_transaction_status_lov primary key (id)
);

create table if not exists lms_payment_db.payment_method_lov (
	id int auto_increment,
    name varchar(50) not null, -- card, cash, upi, net-banking
    description varchar(100),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_payment_method_lov primary key (id)
);

create table if not exists lms_payment_db.transaction_detail (
	id int auto_increment,
    payment_method_lov_id int not null,
    order_id int not null,
    number varchar(128) not null,
    payment_reference_number varchar(128),
    amount float not null,
    currency varchar(10) not null,
    started_on timestamp not null,
    finished_on timestamp,
    successful_sw bigint,
    hold_sw bigint,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_transaction_detail primary key (id),
	constraint fk_transaction_detail_payment_method foreign key (payment_method_lov_id) references lms_payment_db.payment_method_lov(id),
    constraint chk_transaction_detail_amount check (amount > 0)
);

create table if not exists lms_payment_db.transaction_status_reason (
	id int auto_increment,
    text varchar(255), -- other, reason 1, reason 2
    transaction_status_lov_id int not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_transaction_status_reason primary key (id),
    constraint fk_transaction_status_reason_transaction_status_lov foreign key (transaction_status_lov_id) references lms_payment_db.transaction_status_lov(id)
);

create table if not exists lms_payment_db.transaction_movement_history (
	id int auto_increment,
    transaction_detail_id int not null,
    transaction_status_lov_id int not null,
    transaction_status_reason_id int not null,
    additional_reason varchar(128),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_transaction_movement_history primary key (id),
	constraint fk_transaction_movement_history_transaction_detail foreign key (transaction_detail_id) references lms_payment_db.transaction_detail(id),
    constraint fk_transaction_movement_history_transaction_status_lov foreign key (transaction_status_lov_id) references lms_payment_db.transaction_status_lov(id),
    constraint fk_transaction_movement_history_transaction_status_reason foreign key (transaction_status_reason_id) references lms_payment_db.transaction_status_reason(id)
);

-----------------------------------------------------------------------------------------------------------------
-------------------------------------------------- PICKUP DB ----------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

create table if not exists lms_pickup_db.pickup_level_lov (
	id int auto_increment,
    name varchar(50) not null, -- same-day, standard, scheduled
    priority int not null,
    description varchar(100),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_pickup_level_lov primary key (id),
    constraint chk_pickup_level_lov_priority check (priority > 0)
);

create table if not exists lms_pickup_db.pickup_model (
	id int auto_increment,
    agent_id int not null,
    pickup_level_lov_id int not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_pickup_model primary key (id),
    constraint fk_pickup_model_pickup_level_lov foreign key (pickup_level_lov_id) references lms_pickup_db.pickup_level_lov(id)
);

create table if not exists lms_pickup_db.pickup_price_rule (
	id int auto_increment,
    pickup_model_id int not null,
    name varchar(50) not null, -- standard-xyz-N-inr, standard-abc-N-inr, same-day-xyz-N-inr, standard-zaw-N-inr
    description varchar(100),
	per_unit_price float not null,
    price_currency varchar(10) not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_pickup_price_rule primary key (id),
    constraint fk_pickup_price_rule_pickup_model foreign key (pickup_model_id) references lms_pickup_db.pickup_model(id),
    constraint chk_pickup_price_rule_per_unit_price check (per_unit_price > 0)
);

create table if not exists lms_pickup_db.pickup_rate (
	id int auto_increment,
    pickup_price_rule_id int not null,
    name varchar(50) not null, -- standard-xyz-N-inr-K-km, standard-xyz-N-inr-K-mile, standard-abc-N-inr-K-km, standard-abc-N-inr-K-mile, same-day-xyz-N-inr-M-km, same-day-xyz-N-inr-M-mile
    description varchar(100),
	per_unit_distance float not null,
    distance_unit varchar(10) not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_pickup_rate primary key (id),
    constraint fk_pickup_rate_pickup_price_rule foreign key (pickup_price_rule_id) references lms_pickup_db.pickup_price_rule(id),
    constraint chk_pickup_rate_per_unit_distance check (per_unit_distance > 0)
);

-----------------------------------------------------------------------------------------------------------------
--------------------------------------------------- PICKUP TRACKING DB ------------------------------------------
-----------------------------------------------------------------------------------------------------------------

create table if not exists lms_pickup_tracking_db.pickup_status_lov (
	id int auto_increment,
    name varchar(50) not null, -- pending, initiated, picked-up, aborted, completed, failed, hold
    description varchar(100),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_pickup_status_lov primary key (id)
);

create table if not exists lms_pickup_tracking_db.pickup_detail (
	id int auto_increment,
    order_id int not null,
    pickup_rate_id int not null,
    from_customer_id int not null,
    from_customer_address_id int not null,
    to_partner_id int,
    to_partner_address_id int,
    distance float not null,
    distance_unit varchar(10) not null,
    successful_sw bigint,
    hold_sw bigint,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_pickup_tracking_detail primary key (id),
    constraint chk_pickup_tracking_detail_distance check (distance > 0)
);

create table if not exists lms_pickup_tracking_db.pickup_agent_assignment (
	id int auto_increment,
    pickup_detail_id int not null,
    by_agent_id int not null,
    agent_job_reference_number varchar(128),
    agent_contact_person varchar(50) not null,
    agent_contact_phone_number varchar(50) not null,
    pin_hash varchar(128) not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_pickup_agent_assignment primary key (id),
    constraint fk_pickup_agent_assignment_pickup_detail foreign key (pickup_detail_id) references lms_pickup_tracking_db.pickup_detail(id)
);

create table if not exists lms_pickup_tracking_db.pickup_schedule (
	id int auto_increment,
    pickup_detail_id int not null,
    expected_from datetime not null,
    expected_to datetime not null,
    picked_up_at timestamp,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_pickup_schedule primary key (id),
    constraint fk_pickup_schedule_pickup_detail foreign key (pickup_detail_id) references lms_pickup_tracking_db.pickup_detail(id)
);

create table if not exists lms_pickup_tracking_db.pickup_status_reason (
	id int auto_increment,
    text varchar(255), -- other, reason 1, reason 2
    pickup_status_lov_id int not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_pickup_status_reason primary key (id),
    constraint fk_pickup_status_reason_pickup_status_lov foreign key (pickup_status_lov_id) references lms_pickup_tracking_db.pickup_status_lov(id)
);

create table if not exists lms_pickup_tracking_db.pickup_transit_history (
	id int auto_increment,
    pickup_detail_id int not null,
    pickup_status_lov_id int not null,
    pickup_status_reason_id int not null,
    additional_reason varchar(128),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_pickup_transit_history primary key (id),
	constraint fk_pickup_transit_history_pickup_detail foreign key (pickup_detail_id) references lms_pickup_tracking_db.pickup_detail(id),
    constraint fk_pickup_transit_history_pickup_status_lov foreign key (pickup_status_lov_id) references lms_pickup_tracking_db.pickup_status_lov(id),
    constraint fk_pickup_transit_history_pickup_status_reason foreign key (pickup_status_reason_id) references lms_pickup_tracking_db.pickup_status_reason(id)
);

-----------------------------------------------------------------------------------------------------------------
-------------------------------------------------- DELIVERY DB --------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

create table if not exists lms_delivery_db.delivery_level_lov (
	id int auto_increment,
    name varchar(50) not null, -- same-day, standard, scheduled
    priority int not null,
    description varchar(100),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_delivery_level_lov primary key (id),
    constraint chk_delivery_level_lov_priority check (priority > 0)
);

create table if not exists lms_delivery_db.delivery_model (
	id int auto_increment,
    agent_id int not null,
    delivery_level_lov_id int not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_delivery_model primary key (id),
    constraint fk_delivery_model_delivery_level_lov foreign key (delivery_level_lov_id) references lms_delivery_db.delivery_level_lov(id),
    constraint uq_delivery_model_agent_delivery_level unique (agent_id, delivery_level_lov_id)
);

create table if not exists lms_delivery_db.delivery_price_rule (
	id int auto_increment,
    delivery_model_id int not null,
    name varchar(50) not null, -- standard-xyz-N-inr, standard-abc-N-inr, same-day-xyz-N-inr, standard-zaw-N-inr
    description varchar(100),
	per_unit_price float not null,
    price_currency varchar(10) not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_delivery_price_rule primary key (id),
    constraint fk_delivery_price_rule_delivery_model foreign key (delivery_model_id) references lms_delivery_db.delivery_model(id),
    constraint chk_delivery_price_rule_per_unit_price check (per_unit_price > 0)
);

create table if not exists lms_delivery_db.delivery_rate (
	id int auto_increment,
    delivery_price_rule_id int not null,
    name varchar(50) not null, -- standard-xyz-N-inr-K-km, standard-xyz-N-inr-K-mile, standard-abc-N-inr-K-km, standard-abc-N-inr-K-mile, same-day-xyz-N-inr-M-km, same-day-xyz-N-inr-M-mile
    description varchar(100),
	per_unit_distance float not null,
    distance_unit varchar(10) not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_delivery_rate primary key (id),
    constraint fk_delivery_rate_delivery_price_rule foreign key (delivery_price_rule_id) references lms_delivery_db.delivery_price_rule(id),
    constraint chk_delivery_rate_per_unit_distance check (per_unit_distance > 0)
);

-----------------------------------------------------------------------------------------------------------------
-------------------------------------------------- DELIVERY TRACKING DB -----------------------------------------
-----------------------------------------------------------------------------------------------------------------

create table if not exists lms_delivery_tracking_db.delivery_status_lov (
	id int auto_increment,
    name varchar(50) not null, -- pending, initiated, in-transit, completed, aborted, failure, hold
    description varchar(100),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_pickup_status_lov primary key (id)
);

create table if not exists lms_delivery_tracking_db.delivery_detail (
	id int auto_increment,
    order_id int not null,
    delivery_rate_id int not null,
    from_partner_id int not null,
    from_partner_address_id int not null,
    to_customer_id int not null,
    to_customer_address_id int not null,
    distance float not null,
    distance_unit varchar(10) not null,
    successful_sw bigint,
    hold_sw bigint,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_delivery_details primary key (id),
    constraint chk_delivery_details_distance check (distance > 0)
);

create table if not exists lms_delivery_tracking_db.delivery_agent_assignment (
	id int auto_increment,
    delivery_detail_id int not null,
    by_agent_id int not null,
    agent_job_reference_number varchar(128),
    agent_contact_person varchar(50) not null,
    agent_contact_phone_number varchar(50) not null,
    pin_hash varchar(128) not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_delivery_agent_assignment primary key (id),
    constraint fk_delivery_agent_assignment_delivery_details foreign key (delivery_detail_id) references lms_delivery_tracking_db.delivery_detail(id)
);

create table if not exists lms_delivery_tracking_db.delivery_schedule (
	id int auto_increment,
    delivery_detail_id int not null,
    expected_from datetime not null,
    expected_to datetime not null,
    delivered_at timestamp,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_delivery_schedule primary key (id),
    constraint fk_delivery_schedule_delivery_detail foreign key (delivery_detail_id) references lms_delivery_tracking_db.delivery_detail(id)
);

create table if not exists lms_delivery_tracking_db.delivery_status_reason (
	id int auto_increment,
    text varchar(255), -- other, reason 1, reason 2
    delivery_status_lov_id int not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_delivery_status_reason primary key (id),
    constraint fk_delivery_status_reason_pickup_status_lov foreign key (delivery_status_lov_id) references lms_delivery_tracking_db.delivery_status_lov(id)
);

create table if not exists lms_delivery_tracking_db.delivery_transit_history (
	id int auto_increment,
    delivery_detail_id int not null,
    delivery_status_lov_id int not null,
    delivery_status_reason_id int not null,
    additional_reason varchar(128),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    constraint pk_delivery_transit_history primary key (id),
	constraint fk_delivery_transit_history_delivery_detail foreign key (delivery_detail_id) references lms_delivery_tracking_db.delivery_detail(id),
    constraint fk_delivery_transit_history_delivery_status_reason foreign key (delivery_status_reason_id) references lms_delivery_tracking_db.delivery_status_reason(id),
    constraint uq_delivery_transit_history_detail_status unique (delivery_detail_id, delivery_status_lov_id)
);
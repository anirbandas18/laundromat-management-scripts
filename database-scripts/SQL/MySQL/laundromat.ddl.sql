-----------------------------------------------------------------------------------------------------------------
-------------------------------------------------- TYPE DB --------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

create table if not exists lms_type_db.type_lov (
    id int auto_increment,
    name varchar(20) not null, 
    /*
    currency, duration, weight, distance, gender, shipping, laundry, enterprise, subscription, tax, discount, clothing-type, material, role, permission, address, consent, 
    verification, load, wash, iron, dry-clean, mildness, medium, temperature, pickup, delivery, payment, adjustment
    */
    description varchar(100),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_type_lov primary key (id),
    index idx_type_lov_name (name)
);

create table if not exists lms_type_db.type_model (
    id int auto_increment,
    type_lov_id int not null,
    name varchar(20) not null, 
    /*
    currency-inr, currency-usd, duration-month(s), duration-day(s), weight-kg, weight-lb, distance-km, distance-mile, gender-male, gender-female, gender-other, 
    shipping-pickup, shipping-delivery, laundry-wash, laundry-iron, laundry-dry-clean, enterprise-small, enterprise-medium, enterprise-large, temperature-celsius, temperature-fahrenheit
    subscription-basic, subscription-premium, tax-cgst, tax-gst, tax-sales-tax, discount-subscription, discount-deal, discount-coupon, address-home, address-work, address-other
    clothing-type-household, clothing-type-garment, material-silk, material-cotton, material-rayon, material-jute, role-customer, role-agent, role-partner, role-employee, 
    permission-order, permission-pickup, permission-wash, permission-iron, permission-dry-clean, permission-deliver, permission-manage, permission-operate,
    consent-customer, consent-agent, consent-partner, consent-employee, verification-basic, verification-intermediate, verification-advanced, load-weighted, load-individual, 
    wash-machine, wash-hand, iron-machine, iron-box, iron-none, dry-clean-hcs, dry-clean-pce, mildness-professional, mildness-normmal, mildness-gentle, mildness-very-gentle,

    medium-steam, medium-water, pickup-same-day, pickup-standard, pickup-scheduled, delivery-same-day, delivery-standard, delivery-scheduled, payment-card, payment-cash, payment-upi, payment-net-banking
    adjustment-discount, adjustment-deal, adjustment-subscription, adjustment-tax, adjustment-pickup, adjustment-delivery
    */
    description varchar(100),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_type_model primary key (id),
    constraint fk_type_model_type_lov_id foreign key (type_lov_id) references lms_type_db.type_lov(id),
    index idx_type_model_name (name),
    index idx_type_model_type_lov_id (type_lov_id)
);

-----------------------------------------------------------------------------------------------------------------
----------------------------------------------------- TAX DB ----------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

create table if not exists lms_tax_db.tax_lov ( -- cgst, gst, sales tax, vat, etc.
	id int auto_increment,
    name varchar(20) not null, -- discount, cashback
    description varchar(100),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_tax_lov primary key (id),
    constraint uq_tax_lov_name unique (name),
    index idx_tax_lov_id (id),
    index idx_tax_lov_name (name)
);

create table if not exists lms_tax_db.tax_model (
	id int auto_increment,
    tax_lov_id int not null,
    currency_type_model_id int not null,
    rate float not null,
    currency_name varchar(10) not null,
    name varchar(50) not null, -- gst-inr, cgst-inr
    description varchar(100),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_tax_model primary key (id),
    constraint fk_tax_model_tax_lov_id foreign key (coupon_lov_id) references lms_tax_db.tax_lov(id),
    constraint uq_tax_model_id_tax_lov_id_currency_type_model_id unique (id, tax_lov_id, currency_type_model_id),
    constraint chk_tax_model_rate check (rate > 0),
    index idx_tax_model_tax_lov_id (tax_lov_id),
    index idx_tax_model_currency_type_model_id (currency_type_model_id),
    index idx_tax_model_currency_name (currency_name)
);

-----------------------------------------------------------------------------------------------------------------
-------------------------------------------------- DISCOUNT DB --------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

create table if not exists lms_discount_db.discount_status_lov (
	id int auto_increment,
    name varchar(20) not null, -- draft, active, expired
    description varchar(100),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_discount_status_lov primary key (id)
);

/*create table if not exists lms_discount_db.discount_status_reason (
	id int auto_increment,
    discount_status_lov_id int not null,
    text varchar(255), -- other, reason 1, reason 2
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
	version int default 0,
	constraint pk_discount_status_reason primary key (id),
    constraint fk_discount_status_reason_discount_status_lov foreign key (discount_status_lov_id) references lms_discount_db.discount_status_lov(id)
);*/

create table if not exists lms_discount_db.discount_model (
	id int auto_increment,
    discount_type_model_id int not null,
    name varchar(20) not null,
    description varchar(100),
    subscription_level_sw bigint default 0,
    priority int not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_discount_model primary key (id),
    constraint chk_discount_model_priority check (priority > 0),
    index idx_discount_model_discount_type_model_id (discount_type_model_id),
    index idx_discount_model_name (name),
    index idx_discount_model_prority (priority)
);

/*create table if not exists lms_discount_db.discount_rate (
	id int auto_increment,
    discount_model_id int not null,
    value float not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_discount_rate primary key (id),
    constraint fk_discount_rate_discount_model foreign key (discount_model_id) references lms_discount_db.discount_model(id),
    constraint chk_discount_rate_value check (value > 0),
    index idx_discount_rate_discount_model_id (discount_model_id)
);*/

create table if not exists lms_discount_db.discount_rate (
	id int auto_increment,
    discount_model_id int not null,
    value float not null,
    minimum_value float not null,
    maximum_value float not null,
    currency_type_model_id int not null,
    currency_name varchar(10) not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_discount_rate primary key (id),
    constraint fk_discount_rate_discount_model foreign key (discount_model_id) references lms_discount_db.discount_model(id),
    constraint chk_discount_rate_value check (value > 0),
    constraint chk_discount_rate_minimum_value check (minimum_value >= 0),
    constraint chk_discount_rate_maximum_value check (maximum_value >= 0),
    constraint uq_discount_rate_discount_model_id_currency_type_model_id unique (discount_model_id, currency_type_model_id),
    index idx_discount_rate_discount_model_id (discount_model_id),
    index idx_discount_rate_currency_type_model_id (currency_type_model_id)
);

/*create table if not exists lms_discount_db.discount_percentage (
	id int auto_increment,
    discount_rate_id int not null,
    minimum_value float not null,
    maximum_value float not null,
    currency_type_model_id int not null,
    currency_name varchar(10) not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_discount_percentage primary key (id),
    constraint fk_discount_percentage_discount_rate foreign key (discount_rate_id) references lms_discount_db.discount_rate(id),
    constraint chk_discount_percentage_minimum_value check (minimum_value >= 0),
    constraint chk_discount_percentage_maximum_value check (maximum_value >= 0),
    index idx_discount_percentage_discount_rate_id (discount_rate_id)
);

create table if not exists lms_discount_db.discount_amount (
	id int auto_increment,
    discount_rate_id int not null,
    minimum_value float not null,
    currency varchar(10) not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_discount_amount primary key (id),
    constraint fk_discount_amount_discount_rate foreign key (discount_rate_id) references lms_discount_db.discount_rate(id),
    constraint chk_discount_amount_minimum_value check (minimum_value >= 0),
    index idx_discount_percentage_discount_rate_id (discount_rate_id)
);*/

-----------------------------------------------------------------------------------------------------------------
--------------------------------------------------- COUPON DB ---------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

create table if not exists lms_coupon_db.coupon_lov ( -- discount, cashback
	id int auto_increment,
    name varchar(20) not null, -- discount, cashback
    description varchar(100),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_coupon_lov primary key (id),
    constraint uq_coupon_lov_name unique (name),
    index idx_coupon_lov_id (id),
    index idx_coupon_lov_name (name)
);

create table if not exists lms_coupon_db.coupon_model ( -- true = 5 % upto 50, false = unlimited 2 %, false = 100
	id int auto_increment,
    coupon_lov_id int not null,
    code varchar(100) not null,
    description varchar(100),
	rate float not null,
    threshold float not null,
    constraints varchar(255),
    rate_sw bigint default 1,
	threshold_sw bigint default 1,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_coupon_model primary key (id),
    constraint fk_coupon_model_coupon_lov_id foreign key (coupon_lov_id) references lms_coupon_db.coupon_lov(id),
    constraint uq_coupon_model_id_coupon_lov_id_code unique (id, coupon_lov_id, code),
    index idx_coupon_model_id (id),
    index idx_coupon_model_code (code),
    index idx_coupon_model_coupon_lov_id (coupon_lov_id)
);

create table if not exists lms_coupon_db.validity_constraints (
	id int auto_increment,
    coupon_model_id int not null,
    valid_from timestamp not null,
    valid_till_days int not null,
    maximum_usage_limit int not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_validity_constraints primary key (id),
    constraint fk_validity_constraints_coupon_model_id foreign key (coupon_model_id) references lms_coupon_db.coupon_model(id),
    constraint uq_validity_constraints_id_coupon_model_valid_from_till_maximum_usage unique (id, coupon_model_id, valid_from, valid_till_days, maximum_usage_limit),
    index idx_validity_constraints_id (id),
    index idx_validity_constraints_coupon_model_id (coupon_model_id)
);

create table if not exists lms_coupon_db.eligibility_constraints (
	id int auto_increment,
    coupon_model_id int not null,
    service_type_model_id int not null,
    minimum_value_of_service float not null, -- value of selected service
    maximum_value_of_service float not null, -- value of selected service
    minimum_items_in_service int not null, -- items to be serviced
    maximum_items_in_service int not null, -- items to be serviced
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_eligibility_constraints primary key (id),
    constraint fk_eligibility_constraints_coupon_model_id foreign key (coupon_model_id) references lms_coupon_db.coupon_model(id),
    constraint uq_eligibility_constraints_id_coupon_model_id_service_min_max_value_item unique (id, coupon_model_id, service_type_model_id, minimum_value_of_service, maximum_value_of_service, minimum_items_in_service, maximum_items_in_service),
    index idx_eligibility_constraints_id (id),
    index idx_eligibility_constraints_coupon_model_id (coupon_model_id),
    index idx_eligibility_constraints_service_type_model_id (service_type_model_id)
);

-----------------------------------------------------------------------------------------------------------------
-------------------------------------------------- CLOTHING DB --------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

create table if not exists lms_clothing_db.material_type (
	id int auto_increment auto_increment,
    name varchar(20) not null, -- cotton, silk, rayon, wool, etc.
    description varchar(100),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_material_type primary key (id),
    constraint uq_material_type_name unique (name),
    index idx_material_type_id (id),
    index idx_material_type_name (name)
);

create table if not exists lms_clothing_db.material_model (
	id int auto_increment auto_increment,
    material_type_id int not null,
    minimum_temperature float not null,
    maximum_tempertaure float not null,
    temeprature_type_model_id varchar(10) not null,
    washing_sw bigint default 0,
    ironing_sw bigint default 0,
    folding_sw bigint default 0,
    dry_cleaning_sw bigint default 0,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_material_model primary key (id),
    constraint uq_material_model_mt_id_min_temp_max_temp_tt_model_id unique (material_type_id, minimum_temperature, maximum_tempertaure, temeprature_type_model_id),
    index idx_material_model_material_type_id (material_type_id),
    index idx_material_model_temeprature_type_model_id (temeprature_type_model_id)
);

create table if not exists lms_clothing_db.clothing_model (
	id int auto_increment auto_increment,
    material_model_id int not null,
    clothing_type_model_id int not null,
    description varchar(100),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_clothing_model primary key (id),
    constraint fk_clothing_model_material_id foreign key (material_model_id) references lms_clothing_db.material_model(id),
    constraint uq_clothing_model_clothing_type_model_id_material_id unique (clothing_type_model_id, material_model_id),
    index idx_clothing_model_clothing_type_model_id (clothing_type_model_id),
    index idx_clothing_model_material_model_id (material_model_id)
);

create table if not exists lms_clothing_db.clothing_item (
	id int auto_increment,
    clothing_model_id int not null,
    name varchar(50) not null, -- shirt, pant, saree, curtain, towel, t shirt, top, jeans, all
    description varchar(100),
    colour_conscious_sw bigint default 0,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_clothing_item_lov primary key (id),
    constraint fk_clothing_item_clothing_model foreign key (clothing_model_id) references lms_clothing_db.clothing_model(id),
    index idx_clothing_item_clothing_model_id (clothing_model_id),
    index idx_clothing_item_name (name)
);

-----------------------------------------------------------------------------------------------------------------
------------------------------------------------- ACCESS DB -----------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

create table if not exists lms_access_db.resource_lov ( -- type, tax, access, discount, user, etc.
	id int auto_increment,
	name varchar(20) not null, 
    description varchar(100),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_resource_lov primary key (id),
	constraint uq_resource_lov_name unique (name),
    index idx_resource_lov_id (id),
    index idx_resource_lov_name (name)
);

create table if not exists lms_access_db.operation_lov ( -- create, read, use, edit, all, none
	id int auto_increment,
	name varchar(20) not null, 
    description varchar(100),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_operation_lov primary key (id),
	constraint uq_operation_lov_name unique (name),
    index idx_operation_lov_id (id),
    index idx_operation_lov_name (name)
);

create table if not exists lms_access_db.permission_model (
	id int auto_increment,
    resource_lov_id int not null,
    operation_lov_id int not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_permission_model primary key (id),
    constraint fk_permission_model_resource_lov_id foreign key (resource_lov_id) references lms_access_db.resource_lov(id),
    constraint fk_permission_model_operation_lov_id foreign key (operation_lov_id) references lms_access_db.operation_lov(id),
	constraint uq_permission_model_resource_lov_id_operation_lov_id unique (resource_lov_id, operation_lov_id),
    index idx_permission_model_resource_lov_id (resource_lov_id),
    index idx_permission_model_operation_lov_id (operation_lov_id)
);

create table if not exists lms_access_db.user_lov ( --  internal - employee; external - 3rd party; registered - customer, partner; anonymous - guest
	id int auto_increment,
	name varchar(20) not null, 
    description varchar(100),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_user_lov primary key (id),
	constraint uq_user_lov_name unique (name),
    index idx_user_lov_id (id),
    index idx_user_lov_name (name)
);

create table if not exists lms_access_db.role_lov ( -- employee - admin, manager, operator; external - pickup, delivery; customer - basic, premium; partner - wash, iron, dry-clean; guest - freelook
	id int auto_increment,
	name varchar(20) not null, 
    description varchar(100),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_role_lov primary key (id),
	constraint uq_role_lov_name unique (name),
    index idx_role_lov_id (id),
    index idx_role_lov_name (name)
);

create table if not exists lms_access_db.user_role_model (
	id int auto_increment,
    user_lov_id int not null,
    role_lov_id int not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_user_role_model primary key (id),
    constraint fk_user_role_model_user_lov_id foreign key (user_lov_id) references lms_access_db.user_lov(id),
    constraint fk_user_role_model_role_lov_id foreign key (role_lov_id) references lms_access_db.role_lov(id),
	constraint uq_user_role_model_user_lov_id_role_lov_id unique (user_lov_id, role_lov_id),
    index idx_user_role_model_user_lov_id (user_lov_id),
    index idx_user_role_model_role_lov_id (role_lov_id)
);

create table if not exists lms_access_db.role_permission_model (
	id int auto_increment,
    role_lov_id int not null,
    permission_model_id int not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_role_permission_model primary key (id),
    constraint fk_role_permission_model_role_lov_id foreign key (role_lov_id) references lms_access_db.role_lov(id),
    constraint fk_role_permission_model_permission_model_id foreign key (permission_model_id) references lms_access_db.permission_model(id),
	constraint uq_role_permission_model_role_lov_id_permission_model_id unique (role_lov_id, permission_model_id),
    index idx_role_permission_model_role_lov_id (role_lov_id),
    index idx_role_permission_model_permission_model_id (permission_model_id)
);

create table if not exists lms_access_db.security_question_lov ( -- favourite color, mother's maiden name, etc.
	id int auto_increment,
	name varchar(255) not null, 
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_security_question_lov primary key (id),
	constraint uq_security_question_lov_name unique (name),
    index idx_security_question_lov_id (id),
    index idx_security_question_lov_name (name)
);

-----------------------------------------------------------------------------------------------------------------
-------------------------------------------------- USER DB ------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

create table if not exists lms_user_db.user_profile (
	id int auto_increment,
    user_model_id int not null,
    gender_type_model_id int not null,
    first_name varchar(50) not null,
    middle_name varchar(50),
    last_name varchar(50),
    date_of_birth datetime not null,
    email_id varchar(100),
    phone_number varchar(15) not null,
    lock_sw bigint default 1,
    verified_sw bigint default 0,
    suspend_sw bigint default 1,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_user_profile primary key (id),
    constraint uq_user_profile_phone_email unique (phone_number, email_id),
    index idx_user_profile_user_model_id (user_model_id),
    index idx_user_profile_phone_number (phone_number),
    index idx_user_profile_email_id (email_id)
);

create table if not exists lms_user_db.user_security_question (
	id int auto_increment,
    user_profile_id int not null,
    security_question_model_id int not null,
    answer varchar(100),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_user_security_question primary key (id),
    constraint fk_user_security_question_user_profile_id foreign key (user_profile_id) references lms_user_db.user_profile(id),
    constraint uq_user_security_question_user_profile_id_security_question_model_id unique (user_profile_id, security_question_model_id),
    index idx_user_profile_user_profile_id (user_profile_id),
    index idx_user_profile_user_profile_id_security_question_model_id (user_profile_id, security_question_model_id)
);

create table if not exists lms_user_db.user_password_history (
	id int not null auto_increment,
    user_profile_id int not null,
    password_hash varchar(255) not null,
    expires_on timestamp not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_user_password_history primary key (id),
    constraint fk_user_password_history_user_profile foreign key (user_profile_id) references lms_user_db.user_profile(id),
    constraint uq_user_password_history_user_profile_id_password_hash unique (user_profile_id, password_hash),
    index idx_user_password_history_user_profile_id (user_profile_id),
    index idx_user_password_history_password_hash (password_hash),
    index idx_user_password_history_user_profile_id_password_hash (user_profile_id, password_hash)
);

create table if not exists lms_user_db.user_preferences(
	id int not null auto_increment,
    user_profile_id int not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_user_preferences_history primary key (id),
    constraint fk_user_preferences_history_user_profile foreign key (user_profile_id) references lms_user_db.user_profile(id),
    index idx_user_preferences_history_user_profile_id (user_profile_id)
);


-----------------------------------------------------------------------------------------------------------------
-------------------------------------------------- ADDRESS DB ---------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

create table if not exists lms_address_db.address_lov ( -- home, work, facility, other
	id int auto_increment,
    name varchar(20) not null, -- discount, cashback
    description varchar(100),
    customer_sw bigint default 1,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_address_lov primary key (id),
    constraint uq_address_lov_name unique (name),
    index idx_address_lov_id (id),
    index idx_address_lov_name (name)
);

create table if not exists lms_address_db.user_address (
	id int auto_increment,
    address_lov_id int not null,
    user_profile_id int not null,
    shipping_sw bigint default 0,
    billing_sw bigint default 0,
    name varchar(100) not null,
    house_number varchar(100),
    floor varchar(100),
    street_name varchar(100),
    locality varchar(100) not null,
    additional_line_1 varchar(255),
    additional_line_2 varchar(255),
    city varchar(100) not null,
    district varchar(100),
    sub_division varchar(100),
    pin_code varchar(100) not null,
    state varchar(100) not null,
    country varchar(100) not null,
    latitude double,
    longitude double,
    default_sw bigint default 0,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_user_address primary key (id),
    constraint uq_user_address_address_lov_id_user_profile_id_name unique (address_lov_id, user_profile_id, name),
	index idx_user_address_user_profile (user_profile_id),
	index idx_user_address_address_lov_id (address_lov_id),
    index idx_user_address_name (name),
    index idx_user_address_locality (locality),
    index idx_user_address_pin_code (pin_code),
    index idx_user_address_city (city),
	index idx_user_address_state (state),
    index idx_user_address_country (country)
);

-----------------------------------------------------------------------------------------------------------------
-------------------------------------------------- RESET DB --------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

create table if not exists lms_reset_db.password_reset_status_lov (
	id int auto_increment,
    name varchar(20) not null, -- draft, active, expired, hold, aborted, cancelled
    description varchar(100),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_discount_status_lov primary key (id)
);

create table if not exists lms_reset_db.password_reset_status_reason (
	id int auto_increment,
    password_reset_status_lov_id int not null,
    text varchar(255), -- other, reason 1, reason 2
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
	version int default 0,
	constraint pk_password_reset_status_reason primary key (id),
    constraint fk_password_reset_status_reason_pr_status_lov foreign key (password_reset_status_lov_id) references lms_reset_db.password_reset_status_lov(id)
);

create table if not exists lms_reset_db.password_reset_request (
	id int auto_increment,
    user_detail_id int not null,
    code_hash varchar(128) not null,
    fulfilled_sw bigint default 0,
    expired_sw bigint default 0,
    hold_sw bigint default 0,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_password_reset_request primary key (id),
    index idx_password_reset_request_user_detail_id (user_detail_id)
);

create table if not exists lms_reset_db.password_reset_request_history (
	id int auto_increment,
    password_reset_request_id int not null,
    password_reset_status_lov_id int not null,
    password_reset_status_reason_id int not null,
    additional_reason varchar(128),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_password_reset_request_history primary key (id),
    constraint fk_password_reset_request_history_password_reset_request foreign key (password_reset_request_id) references lms_reset_db.password_reset_request(id),
    constraint fk_password_reset_request_history_password_reset_status_lov foreign key (password_reset_status_lov_id) references lms_reset_db.password_reset_status_lov(id),
    constraint fk_password_reset_request_history_password_reset_status_reason foreign key (password_reset_status_reason_id) references lms_reset_db.password_reset_status_reason(id),
    index idx_password_reset_request_history_pr_request_id (password_reset_request_id),
    index idx_password_reset_request_history_pr_status_lov_id (password_reset_status_lov_id),
    index idx_password_reset_request_history_pr_status_reason_id (password_reset_status_reason_id)
);

-----------------------------------------------------------------------------------------------------------------
-------------------------------------------------- CUSTOMER DB --------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

/*create table if not exists lms_customer_db.customer_detail (
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
    version int default 0,
    constraint pk_customer_detail primary key (id),
    index idx_customer_detail_user_detail_id (user_detail_id),
    index idx_customer_detail_full_name (first_name, last_name)
);

create table if not exists lms_customer_db.customer_address (
	id int auto_increment,
    address_type_model_id int not null,
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
    default_sw bigint default 0,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_customer_address primary key (id),
    constraint fk_customer_address_customer_detail foreign key (customer_detail_id) references lms_customer_db.customer_detail(id),
	index idx_customer_address_user_detail_id (customer_detail_id),
	index idx_customer_address_address_type_model_id (address_type_model_id),
    index idx_customer_address_locality (locality),
    index idx_customer_address_pin_code (pin_code),
    index idx_customer_address_district (district),
    index idx_customer_address_city (city),
	index idx_customer_address_state (state),
    index idx_customer_address_country (country),
    index idx_customer_address_coordinates (latitude, longitude)
);*/

-----------------------------------------------------------------------------------------------------------------
---------------------------------------------- SUBSCRIPTION DB --------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

create table if not exists lms_subscription_db.subscription_status_lov (
	id int auto_increment,
    name varchar(50) not null, -- draft, active, expired, hold, cancelled
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_subscription_level_lov primary key (id)
);

create table if not exists lms_subscription_db.subscription_status_reason (
	id int auto_increment,
    subscription_status_lov_id int not null,
    text varchar(255), -- other, reason 1, reason 2
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_subscription_status_reason primary key (id),
    constraint uq_subscription_status_reason_subscription_status_lov foreign key (subscription_status_lov_id) references lms_subscription_db.subscription_status_lov(id),
    index idx_subscription_status_reason_ss_lov_id (subscription_status_lov_id)
);

create table if not exists lms_subscription_db.subscription_model (
	id int auto_increment,
    subscription_type_model_id int not null,
    per_unit_of_duration int not null,
    duration_type_lov_id int not null,
    free_logistics_sw bigint not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_subscription_model primary key (id),
    constraint chk_subscription_model_per_unit_of_duration check (per_unit_of_duration > 0),
    index idx_subscription_model_subscription_type_model_id (subscription_type_model_id)
);

create table if not exists lms_subscription_db.subscription_tracker (
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
    version int default 0,
    constraint pk_subscription_tracker primary key (id),
    constraint fk_subscription_tracker_subscription_model foreign key (subscription_model_id) references lms_subscription_db.subscription_model(id),
    constraint uq_subscription_tracker_sm_id_cd_id_so_dt unique (subscription_model_id, customer_detail_id, subscribed_on),
    constraint chk_subscription_tracker_subscription_before_expiry check (subscribed_on < expires_on),
    index idx_subscription_tracker_subscription_model_id (subscription_model_id),
    index idx_subscription_tracker_customer_detail_id (customer_detail_id)
);

create table if not exists lms_subscription_db.subscription_tracking_history (
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
    version int default 0,
    constraint pk_subscription_tracking_history primary key (id),
    constraint fk_subscription_tracking_history_subscription_tracker foreign key (subscription_tracker_id) references lms_subscription_db.subscription_tracker(id),
    constraint fk_subscription_tracking_history_subscription_status_lov foreign key (subscription_status_lov_id) references lms_subscription_db.subscription_status_lov(id),
    constraint fk_subscription_tracking_history_subscription_status_reason foreign key (subscription_status_reason_id) references lms_subscription_db.subscription_status_reason(id),
    index idx_subscription_tracking_history_subscription_tracker_id (subscription_tracker_id),
    index idx_subscription_tracking_history_subscription_status_lov_id (subscription_status_lov_id),
    index idx_subscription_tracking_history_subscription_status_reason_id (subscription_status_reason_id)
);

-----------------------------------------------------------------------------------------------------------------
-------------------------------------------------- EMPLOYEE DB --------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

create table if not exists lms_employee_db.employee_detail (
	id int auto_increment,
    number varchar(64) not null,
    user_detail_id int not null,
    first_name varchar(50) not null,
    last_name varchar(50) not null,
    gender_id int not null,
    tax_number varchar(50) not null,
    dob date not null,
    verified_sw bigint default 0,
    consent_sw bigint default 0,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_customer_detail primary key (id),
    index idx_employee_detail_user_detail_id (user_detail_id),
    index idx_employee_detail_full_name (first_name, last_name)
);

create table if not exists lms_employee_db.employee_address (
	id int auto_increment,
    employee_detail_id int not null,
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
    version int default 0,
    constraint pk_employee_address primary key (id),
    constraint fk_employee_address_employee_detail foreign key (employee_detail_id) references lms_employee_db.employee_detail(id),
    index idx_employee_address_employee_detail_id (employee_detail_id),
    index idx_employee_address_locality (locality),
    index idx_employee_address_pin_code (pin_code),
    index idx_employee_address_district (district),
    index idx_employee_address_city (city),
	index idx_employee_address_state (state),
    index idx_employee_address_country (country),
    index idx_employee_address_coordinates (latitude, longitude)
);

create table if not exists lms_employee_db.employee_emergency_contact (
	id int auto_increment,
    employee_detail_id int not null,
    name varchar(100) not null,
    phone_number varchar(20) not null,
    email_id varchar(100),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_employee_emergency_contact primary key (id),
    constraint fk_employee_emergency_contact_employee_detail foreign key (employee_detail_id) references lms_employee_db.employee_detail(id),
    index idx_employee_address_employee_detail_id (employee_detail_id),
    index idx_employee_emergency_contact_name (name),
    index idx_employee_emergency_contact_phone_number (phone_number)
);

-----------------------------------------------------------------------------------------------------------------
-------------------------------------------------- AGENT DB -----------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

create table if not exists lms_agent_db.agent_model (
	id int auto_increment,
    enterprise_type_model_id int not null,
    user_detail_id int not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_agent_model primary key (id),
    constraint uq_agent_model_enterprise_type_model_id_user_detail_id unique (enterprise_type_model_id, user_detail_id),
     index idx_agent_model_user_detail_id (user_detail_id),
    index idx_agent_model_enterprise_type_model_id (enterprise_type_model_id)
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
    version int default 0,
    constraint pk_agent_detail primary key (id),
    constraint fk_agent_detail_agent_model foreign key (agent_model_id) references lms_agent_db.agent_model(id),
    index idx_agent_detail_agent_model_id (agent_model_id),
    index idx_agent_detail_poc_name (point_of_contact_name),
    index idx_agent_detail_poc_email_id (point_of_contact_email_id),
    index idx_agent_detail_poc_phone_number (point_of_contact_phone_number),
    index idx_agent_detail_tax_number (tax_number)
);

create table if not exists lms_agent_db.agent_service (
	id int auto_increment,
    shipping_type_model_id int not null,
    agent_detail_id int not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_agent_service primary key (id),
    constraint fk_agent_service_agent_detail foreign key (agent_detail_id) references lms_agent_db.agent_detail(id),
    constraint uq_agent_service_logistic_type_model_id_agent_detail_id unique (shipping_type_model_id, agent_detail_id),
    index idx_agent_service_agent_detail_id (agent_detail_id),
    index idx_agent_service_shipping_type_model_id (shipping_type_model_id)
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
    version int default 0,
    constraint pk_agent_address primary key (id),
    constraint fk_agent_address_agent_detail foreign key (agent_detail_id) references lms_agent_db.agent_detail(id),
    index idx_agent_address_partner_detail_id (agent_detail_id),
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
    version int default 0,
    constraint pk_agent_facility primary key (id),
    constraint fk_agent_facility_partner_detail foreign key (agent_detail_id) references lms_agent_db.agent_detail(id),
    index idx_agent_facility_establishment_registration_number (establishment_registration_number),
    index idx_agent_facility_agent_detail_id (agent_detail_id)
);

create table if not exists lms_agent_db.agent_facility_service (
	id int auto_increment,
    shipping_type_model_id int not null,
    agent_facility_id int not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_agent_facility_service primary key (id),
    constraint fk_agent_facility_service_agent_facility foreign key (agent_facility_id) references lms_agent_db.agent_facility(id),
    constraint uq_agent_facility_service_lt_model_id_af_id unique (shipping_type_model_id, agent_facility_id),
    index idx_agent_facility_service_agent_facility_id (agent_facility_id),
    index idx_agent_facility_service_shipping_type_model_id (shipping_type_model_id)
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
    version int default 0,
    constraint pk_agent_facility_address primary key (id),
    constraint fk_agent_facility_address_agent_facility foreign key (agent_facility_id) references lms_agent_db.agent_facility(id),
    index idx_agent_facility_agent_facility_id (agent_facility_id),
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
    enterprise_type_model_id int not null,
    user_detail_id int not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_partner_model primary key (id),
    constraint uq_partner_model_enterprise_type_model_id_user_detail_id unique (enterprise_type_model_id, user_detail_id),
    index idx_partner_model_user_detail_id (user_detail_id),
    index idx_partner_model_enterprise_type_model_id (enterprise_type_model_id)
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
    version int default 0,
    constraint pk_partner_detail primary key (id),
    constraint fk_partner_detail_partner_model foreign key (partner_model_id) references lms_partner_db.partner_model(id),
    index idx_partner_detail_partner_model_id (partner_model_id),
    index idx_partner_detail_poc_name (point_of_contact_name),
    index idx_partner_detail_poc_email_id (point_of_contact_email_id),
    index idx_partner_detail_poc_phone_number (point_of_contact_phone_number),
    index idx_partner_detail_tax_number (tax_number)
);

create table if not exists lms_partner_db.partner_service (
	id int auto_increment,
    laundry_type_model_id int not null,
    partner_detail_id int not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_partner_services primary key (id),
    constraint fk_partner_services_partner_detail foreign key (partner_detail_id) references lms_partner_db.partner_detail(id),
    constraint uq_partner_services_laundry_type_model_id_partner_detail_id unique (laundry_type_model_id, partner_detail_id),
    index idx_partner_service_partner_detail_id (partner_detail_id),
    index idx_partner_service_laundry_type_model_id (laundry_type_model_id)
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
	version int default 0,
	constraint pk_partner_address primary key (id),
    constraint fk_partner_address_partner_detail foreign key (partner_detail_id) references lms_partner_db.partner_detail(id),
    index idx_partner_address_partner_detail_id (partner_detail_id),
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
    version int default 0,
    constraint pk_partner_facility primary key (id),
    constraint fk_partner_facility_partner_detail foreign key (partner_detail_id) references lms_partner_db.partner_detail(id),
    index idx_partner_facility_establishment_registration_number (establishment_registration_number),
    index idx_partner_facility_partner_detail_id (partner_detail_id)
);

create table if not exists lms_partner_db.partner_facility_service (
	id int auto_increment,
    laundry_type_model_id int not null,
    partner_facility_id int not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_partner_facility_service primary key (id),
    constraint fk_partner_facility_service_partner_facility foreign key (partner_facility_id) references lms_partner_db.partner_facility(id),
    constraint uq_partner_facility_service_lt_model_id_pf_id unique (laundry_type_model_id, partner_facility_id),
    index idx_partner_facility_service_partner_facility_id (partner_facility_id),
    index idx_partner_facility_service_laundry_type_model_id (laundry_type_model_id)
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
    version int default 0,
    constraint pk_partner_facility_address primary key (id),
    constraint fk_partner_facility_address_partner_facility foreign key (partner_facility_id) references lms_partner_db.partner_facility(id),
    index idx_partner_facility_partner_facility_id (partner_facility_id),
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

create table if not exists lms_consent_db.consent_status_lov (
    id int auto_increment,
    name varchar(20) not null, -- waiting, accepted, declined, hold
    description varchar(100),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_consent_type_lov primary key (id),
    index idx_consent_type_lov_name (name)
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
    version int default 0,
    constraint pk_consent_status_reason primary key (id),
    constraint fk_consent_status_reason_consent_status_lov foreign key (consent_status_lov_id) references lms_consent_db.consent_status_lov(id),
    index idx_consent_status_reason_consent_status_lov_id (consent_status_lov_id)
);

create table if not exists lms_consent_db.consent_model (
	id int auto_increment,
    consent_type_model_id int not null,
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
    version int default 0,
    constraint pk_consent_model primary key (id),
	index idx_consent_model_consent_type_model_id (consent_type_model_id)
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
    version int default 0,
    constraint pk_consent_tracker primary key (id),
    constraint fk_consent_tracker_consent_model foreign key (consent_model_id) references lms_consent_db.consent_model(id),
    constraint uq_consent_tracker_consent_model_id_user_detail_id unique (consent_model_id, user_detail_id),
	index idx_consent_tracker_consent_model_id (consent_model_id),
    index idx_consent_tracker_user_model_id (user_detail_id)
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
    version int default 0,
    constraint pk_consent_tracker_history primary key (id),
    constraint fk_consent_tracker_history_consent_tracker foreign key (consent_tracker_id) references lms_consent_db.consent_tracker(id),
    constraint fk_consent_tracker_history_consent_status_lov foreign key (consent_status_lov_id) references lms_consent_db.consent_status_lov(id),
    constraint fk_consent_tracker_history_consent_status_reason foreign key (consent_status_reason_id) references lms_consent_db.consent_status_reason(id),
    index idx_consent_tracker_history_consent_tracker_id (consent_tracker_id),
    index idx_consent_tracker_history_consent_status_lov_id (consent_status_lov_id),
    index idx_consent_tracker_history_consent_status_reason_id (consent_status_reason_id)
);

-----------------------------------------------------------------------------------------------------------------
-------------------------------------------------- VERIFICATION DB ----------------------------------------------
-----------------------------------------------------------------------------------------------------------------

create table if not exists lms_verification_db.verification_status_lov (
	id int auto_increment,
    name varchar(20) not null, -- pending, completed, aborted, failed, hold
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_verification_status_lov primary key (id)
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
    version int default 0,
    constraint pk_verification_status_reason primary key (id),
	constraint uq_verification_status_reason_verification_status_lov foreign key (verification_status_lov_id) references lms_verification_db.verification_status_lov(id)
);

create table if not exists lms_verification_db.verification_model ( 
	/*v
    verification-basic-customer, verification-intermediate-customer, verification-basic-agent, verification-intermediate-agent, verification-advanced-agent, 
    verification-basic-partner, verification-intermediate-partner, verification-advanced-partner, verification-basic-employee, verification-intermediate-employee
	*/
    id int auto_increment,
    verification_type_model_id int not null,
    role_type_model_id int not null,
    requires_basic_verification_sw bigint default 0,
    requires_intermediate_verification_sw bigint default 1,
    requires_advanced_verification_sw bigint default 1,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_verification_model primary key (id),
    constraint uq_verification_model_vt_model_id_rt_model_id unique (verification_type_model_id, role_type_model_id),
    index idx_verification_model_verification_type_model_id (verification_type_model_id),
    index idx_verification_model_role_type_model_id (role_type_model_id)
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
    version int default 0,
    constraint pk_basic_verification_model primary key (id),
    constraint fk_basic_verification_model_verification_model foreign key (verification_model_id) references lms_verification_db.verification_model(id),
    index idx_basic_verification_model_verification_model_id (verification_model_id)
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
    version int default 0,
    constraint pk_intermediate_verification_model primary key (id),
    constraint fk_intermediate_verification_model_basic_verification_model foreign key (basic_verification_model_id) references lms_verification_db.basic_verification_model(id),
    index idx_intermediate_verification_model_bv_model_id (basic_verification_model_id)
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
    version int default 0,
    constraint pk_advanced_verification_model primary key (id),
    constraint fk_advanced_verification_model_im_model foreign key (intermediate_verification_model_id ) references lms_verification_db.intermediate_verification_model(id),
    index idx_advanced_verification_model_im_model_id (intermediate_verification_model_id)
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
    version int default 0,
    constraint pk_verification_tracker primary key (id),
    constraint fk_verification_tracker_verification_model foreign key (verification_model_id) references lms_verification_db.verification_model(id),
    constraint uq_verification_tracker_verification_model_user_detail unique (verification_model_id, user_detail_id),
	index idx_verification_tracker_verification_model_id (verification_model_id),
    index idx_verification_tracker_user_model_id (user_detail_id)
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
    version int default 0,
    constraint pk_verification_tracker_history primary key (id),
    constraint fk_verification_tracker_history_verification_tracker foreign key (verification_tracker_id) references lms_verification_db.verification_tracker(id),
    constraint fk_verification_tracker_history_verification_status_lov foreign key (verification_status_lov_id) references lms_verification_db.verification_status_lov(id),
    constraint fk_verification_tracker_history_verification_status_reason foreign key (verification_status_reason_id) references lms_verification_db.verification_status_reason(id),
    index idx_verification_tracker_history_verification_tracker_id (verification_tracker_id),
    index idx_verification_tracker_history_verification_status_lov_id (verification_status_lov_id),
    index idx_verification_tracker_history_vs_reason_id (verification_status_reason_id)
);

-----------------------------------------------------------------------------------------------------------------
-------------------------------------------------- WASH DB ------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

create table if not exists lms_wash_db.washing_model (
	id int auto_increment,
    wash_type_model_id int not null,
    load_type_model_id int not null,
    partner_id int not null,
    name varchar(50) not null, -- wash-machine-load-weighted-partner1, wash-machine-load-individual-partner1, wash-hand-load-individual-partner2
    description varchar(100),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_washing_model primary key (id),
    constraint uq_washing_model_wash_type_model_id_lt_model_id_partner_id unique (wash_type_model_id, load_type_model_id, partner_id),
    index idx_washing_model_wash_type_model_id (wash_type_model_id),
    index idx_washing_model_load_type_model_id (load_type_model_id),
    index idx_washing_model_partner_id (partner_id)
);


create table if not exists lms_wash_db.weighted_washing_model (
	id int auto_increment,
    washing_model_id int not null,
    clothing_type_model_id int not null,
    name varchar(50) not null, 
    /*
    wash-machine-load-weighted-partner1-household, wash-machine-load-individual-partner1-garment, wash-hand-load-individual-partner2-garment
    */
    description varchar(100),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_weighted_washing_model primary key (id),
    constraint fk_weighted_washing_model_washing_model_id foreign key (washing_model_id) references lms_wash_db.washing_model(id),
    constraint uq_weighted_washing_model_washing_model_id_ct_model_id unique (washing_model_id, clothing_type_model_id),
    index idx_weighted_washing_model_washing_model_id (washing_model_id),
    index idx_weighted_washing_model_clothing_type_model_id (clothing_type_model_id)
);

create table if not exists lms_wash_db.individual_washing_model (
	id int auto_increment,
    washing_model_id int not null,
    clothing_item_id int not null,
    name varchar(50) not null,
    /*
    wash-machine-load-weighted-household-partner1-curtain, wash-machine-load-individual-partner1-shirt, wash-hand-load-individual-partner2-saree
    */
    description varchar(100),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_individual_washing_model primary key (id),
	constraint fk_individual_washing_model_washing_model_id foreign key (washing_model_id) references lms_wash_db.washing_model(id),
    constraint uq_individual_washing_model_washing_model_id_ci_id unique (washing_model_id, clothing_item_id),
    index idx_individual_washing_model_washing_model_id (washing_model_id),
    index idx_individual_washing_model_clothing_item_id (clothing_item_id)
);

-----------------------------------------------------------------------------------------------------------------
-------------------------------------------------- WASH PRICING DB ---------------------------------------------
-----------------------------------------------------------------------------------------------------------------

create table if not exists lms_wash_pricing_db.washing_price_rule (
	id int auto_increment,
    washing_model_id int not null,
	name varchar(50) not null,
    /*
    wash-machine-load-weighted-partner1-N-inr, wash-machine-load-individual-partner1-K-inr, wash-hand-load-individual-partner2-L-inr
    */
    description varchar(100),
	per_unit_price float not null,
    price_currency varchar(10) not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_washing_price_rule primary key (id),
    constraint uq_washing_price_rule_washing_model_id_pu_price_p_currency unique (washing_model_id, per_unit_price, price_currency),
    constraint chk_washing_price_rule_per_unit_price check (per_unit_price > 0),
    index idx_washing_price_rule_washing_model_id (washing_model_id)
);

create table if not exists lms_wash_pricing_db.weighted_washing_rate (
	id int auto_increment,
    washing_price_rule_id int not null,
    weighted_washing_model_id int not null,
    /*
    wash-machine-load-weighted-partner1-N-inr-household-1-kg, wash-machine-load-weighted-partner1-M-inr-garment-1-kg
    */
	name varchar(50) not null,
    description varchar(100),
    per_unit_weight float not null,
	weight_unit varchar(10) not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_weighted_washing_rate primary key (id),
    constraint fk_weighted_washing_rate_washing_price_rule foreign key (washing_price_rule_id) references lms_wash_pricing_db.washing_price_rule(id),
    constraint uq_weighted_washing_rate_washing_price_rule_id_ww_model_id unique (washing_price_rule_id, weighted_washing_model_id),
    constraint chk_weighted_washing_rate_per_unit_weight check (per_unit_weight > 0),
    index idx_weighted_washing_rate_washing_price_rule_id (washing_price_rule_id),
    index idx_weighted_washing_rate_weighted_washing_model_id (weighted_washing_model_id)
);

create table if not exists lms_wash_pricing_db.individual_washing_rate (
	id int auto_increment, 
    washing_price_rule_id int not null,
    individual_washing_model_id int not null,
    /*
    wash-machine-load-individual-partner1-K-inr-1-shirt, wash-machine-load-individual-partner1-L-inr-1-curtain, wash-hand-load-individual-partner2-L-inr-1-saree, 
    wash-hand-load-individual-partner2-M-inr-1-towel
    */
    name varchar(50) not null,
    description varchar(100),
    per_unit_count int not null,
	created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_individual_washing_rate primary key (id),
    constraint fk_individual_washing_rate_washing_price_rule foreign key (washing_price_rule_id) references lms_wash_pricing_db.washing_price_rule(id),
    constraint uq_individual_washing_rate_washing_price_rule_id_iw_model_id unique (washing_price_rule_id, individual_washing_model_id),
    constraint chk_individual_washing_rate_per_unit_count check (per_unit_count > 0),
    index idx_individual_washing_rate_washing_price_rule_id (washing_price_rule_id),
    index idx_individual_washing_rate_individual_washing_model_id (individual_washing_model_id)
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
    version int default 0,
    constraint pk_weighted_washing_discount_model primary key (id),
    constraint uq_weighted_washing_discount_model_ww_model_id_discount_model_id  unique (weighted_washing_model_id, discount_model_id),
    index idx_weighted_washing_discount_model_weighted_washing_model_id (weighted_washing_model_id),
    index idx_weighted_washing_discount_model_discount_model_id (discount_model_id)
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
    version int default 0,
    constraint pk_weighted_washing_discount_rate primary key (id),
    constraint fk_ww_discount_rate_ww_discount_model foreign key (weighted_washing_discount_model_id) references lms_wash_discount_db.weighted_washing_discount_model(id),
    constraint uq_weighted_washing_discount_rate_name unique (weighted_washing_discount_model_id, name),
    constraint chk_weighted_washing_discount_rate_discount_value check (discount_value > 0),
    constraint chk_weighted_washing_discount_rate_minimum_expected_value check (minimum_expected_value > 0),
    constraint chk_weighted_washing_discount_rate_maximum_allowed_value check (maximum_allowed_value > 0),
    constraint chk_weighted_washing_discount_rate_start_before_expiry check (starts_on < expires_on),
    index idx_weighted_washing_discount_rate_ww_discount_model_id (weighted_washing_discount_model_id)
);

create table if not exists lms_wash_discount_db.weighted_washing_discount_shipping (
	id int auto_increment,
    weighted_washing_discount_rate_id int not null,
    free_pickup_sw bigint default 0,
    free_delivery_sw bigint default 0,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_weighted_washing_discount_shipping primary key (id),
    constraint fk_ww_discount_shipping_ww_discount_rate foreign key (weighted_washing_discount_rate_id) references lms_wash_discount_db.weighted_washing_discount_rate(id),
    constraint uq_ww_discount_shipping_rate_pickup_delivery unique (weighted_washing_discount_rate_id, free_pickup_sw, free_delivery_sw),
    index idx_weighted_washing_discount_shipping_ww_discount_rate_id (weighted_washing_discount_rate_id)
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
    version int default 0,
    constraint pk_weighted_washing_discount_rate_currency primary key (id),
    constraint fk_ww_discount_rate_currency_ww_discount_rate foreign key (weighted_washing_discount_rate_id) references lms_wash_discount_db.weighted_washing_discount_rate(id),
    constraint uq_weighted_washing_discount_rate_currency_ww_dr_id_ct_lov_id unique (weighted_washing_discount_rate_id, currency_type_lov_id),
	index idx_weighted_washing_discount_rate_currency_ww_dr_id (weighted_washing_discount_rate_id),
    index idx_weighted_washing_discount_rate_currency_ct_lov_id (currency_type_lov_id)
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
    version int default 0,
    constraint pk_weighted_washing_discount_rate_history primary key (id),
    constraint fk_ww_discount_rate_history_ww_discount_rate foreign key (weighted_washing_discount_rate_id) references lms_wash_discount_db.weighted_washing_discount_rate(id),
    index idx_weighted_washing_discount_rate_history_ww_discount_rate_id (weighted_washing_discount_rate_id),
    index idx_weighted_washing_discount_rate_history_ds_lov_id (discount_status_lov_id),
    index idx_weighted_washing_discount_rate_history_ds_reason_id (discount_status_reason_id)
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
    version int default 0,
    constraint pk_weighted_washing_discount_coupon primary key (id),
    constraint fk_ww_discount_coupon_ww_discount_rate foreign key (weighted_washing_discount_rate_id) references lms_wash_discount_db.weighted_washing_discount_rate(id),
    constraint uq_weighted_washing_discount_coupon_ww_dr_id_code_hash unique (weighted_washing_discount_rate_id, code_hash),
	index idx_weighted_washing_discount_coupon_ww_discount_rate_id (weighted_washing_discount_rate_id),
    index idx_weighted_washing_discount_coupon_code_hash (code_hash)
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
    version int default 0,
    constraint pk_individual_washing_discount_model primary key (id),
    constraint uq_individual_washing_discount_model_iw_model_id_dm_id  unique (individual_washing_model_id, discount_model_id),
    index idx_individual_washing_discount_model_ww_model_id (individual_washing_model_id),
    index idx_individual_washing_discount_model_discount_model_id (discount_model_id)
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
    version int default 0,
    constraint pk_individual_washing_discount_rate primary key (id),
    constraint fk_iw_discount_rate_iw_discount_model foreign key (individual_washing_discount_model_id) references lms_wash_discount_db.individual_washing_discount_model(id),
    constraint uq_individual_washing_discount_rate_name unique (individual_washing_discount_model_id, name),
    constraint chk_individual_washing_discount_rate_discount_value check (discount_value > 0),
    constraint chk_individual_washing_discount_rate_minimum_expected_value check (minimum_expected_value > 0),
    constraint chk_individual_washing_discount_rate_maximum_allowed_value check (maximum_allowed_value > 0),
    constraint chk_individual_washing_discount_rate_start_before_expiry check (starts_on < expires_on),
    index idx_individual_washing_discount_rate_iw_dm_id (individual_washing_discount_model_id)
);

create table if not exists lms_wash_discount_db.individual_washing_discount_shipping (
	id int auto_increment,
    individual_washing_discount_rate_id int not null,
    free_pickup_sw bigint default 0,
    free_delivery_sw bigint default 0,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_individual_washing_discount_shipping primary key (id),
    constraint fk_iw_discount_shipping_iw_discount_rate foreign key (individual_washing_discount_rate_id) references lms_wash_discount_db.individual_washing_discount_rate(id),
    constraint uq_individual_washing_discount_shipping_rate_pickup_delivery unique (individual_washing_discount_rate_id, free_pickup_sw, free_delivery_sw),
    index idx_individual_washing_discount_shipping_iw_dr_id (individual_washing_discount_rate_id)
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
    version int default 0,
    constraint pk_individual_washing_discount_rate_currency primary key (id),
    constraint fk_iw_discount_rate_currency_iw_discount_rate foreign key (individual_washing_discount_rate_id) references lms_wash_discount_db.individual_washing_discount_rate(id),
    constraint uq_individual_washing_discount_rate_currency_iw_dr_id_ct_lov_id unique (individual_washing_discount_rate_id, currency_type_lov_id),
    index idx_individual_washing_discount_rate_currency_iw_dr_id (individual_washing_discount_rate_id),
    index idx_individual_washing_discount_rate_currency_ct_lov_id (currency_type_lov_id)
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
    version int default 0,
    constraint pk_individual_washing_discount_rate_history primary key (id),
    constraint fk_iw_discount_rate_history_iw_discount_rate foreign key (individual_washing_discount_rate_id) references lms_wash_discount_db.individual_washing_discount_rate(id),
    index idx_individual_washing_discount_rate_history_iw_dr_id (individual_washing_discount_rate_id),
    index idx_individual_washing_discount_rate_history_ds_lov_id (discount_status_lov_id),
    index idx_individual_washing_discount_rate_history_ds_reason_id (discount_status_reason_id)
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
    version int default 0,
    constraint pk_individual_washing_discount_coupon primary key (id),
    constraint fk_iw_discount_coupon_iw_discount_rate foreign key (individual_washing_discount_rate_id) references lms_wash_discount_db.individual_washing_discount_rate(id),
    constraint uq_individual_washing_discount_coupon_iw_dr_id_code_hash unique (individual_washing_discount_rate_id, code_hash),
    index idx_individual_washing_discount_coupon_iw_dr_id (individual_washing_discount_rate_id),
    index idx_individual_washing_discount_coupon_code_hash (code_hash)
);

-----------------------------------------------------------------------------------------------------------------
-------------------------------------------------- WASH TRACKING DB ---------------------------------------------
-----------------------------------------------------------------------------------------------------------------

create table if not exists lms_wash_tracking_db.wash_status_lov (
	id int auto_increment,
    name varchar(50) not null, -- draft, inspecting, washing, drying, folding, ready, cancelled, failed, hold
    description varchar(100),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_wash_status_lov primary key (id)
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
    version int default 0,
    constraint pk_wash_status_reason primary key (id),
    index idx_wash_status_reason_wash_status_lov_id (wash_status_lov_id)
);

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
    version int default 0,
    constraint pk_washable_item_tracker primary key (id),
    constraint uq_washable_item_tracker_order_number_order_line_id_seq_tag_id unique (order_number, order_line_id, sequence, tag_id),
    constraint chk_washable_item_tracker_sequence check (sequence > 0),
    index idx_washable_item_tracker_order_number (order_number),
    index idx_washable_item_tracker_order_line_id (order_line_id),
    index idx_washable_item_tracker_tag_id (tag_id)
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
    version int default 0,
    constraint pk_washable_item_tracking_history primary key (id),
    constraint fk_washable_item_tracking_history_washable_item_tracker foreign key (washable_item_tracker_id) references lms_wash_tracking_db.washable_item_tracker(id),
    constraint fk_washable_item_tracking_history_wash_status_lov foreign key (wash_status_lov_id) references lms_wash_tracking_db.wash_status_lov(id),
    constraint fk_washable_item_tracking_history_wash_status_reason foreign key (wash_status_reason_id) references lms_wash_tracking_db.wash_status_reason(id),
    index idx_washable_item_tracking_history_washable_item_tracker_id (washable_item_tracker_id),
    index idx_washable_item_tracking_history_wash_status_lov_id (wash_status_lov_id),
    index idx_washable_item_tracking_history_wash_status_reason_id (wash_status_reason_id)
);

-----------------------------------------------------------------------------------------------------------------
-------------------------------------------------- IRON DB ------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

create table if not exists lms_iron_db.ironing_model (
	id int auto_increment,
    iron_type_lov_id int not null,
    partner_id int not null,
    name varchar(50) not null, -- iron-machine-steam-partner1, iron-machine-water-partner1, iron-machine-steam-partner2, iron-box-water-partner3
    description varchar(100),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_ironing_model primary key (id),
    index idx_ironing_model_iron_type_lov_id (iron_type_lov_id),
	index idx_ironing_model_partner_id (partner_id)
);

create table if not exists lms_iron_db.ironable_item_model (
	id int auto_increment,
    ironing_model_id int not null,
    clothing_item_id int not null,
    name varchar(50) not null,
    /*
    iron-machine-steam-partner1-shirt, iron-machine-steam-partner1-pant, iron-machine-steam-partner1-saree, iron-machine-steam-partner1-suit,
    iron-machine-water-partner1-shirt, iron-machine-water-partner1-pant, iron-machine-water-partner1-saree,
    iron-machine-steam-partner2-shirt, iron-machine-steam-partner2-pant, iron-machine-steam-partner2-saree, iron-machine-steam-partner2-suit,
    iron-box-water-partner3-shirt, iron-box-water-partner3-pant, iron-box-water-partner3-saree
    */
    description varchar(100),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_ironing_model primary key (id),
    constraint fk_ironable_item_model_ironing_model_id foreign key (ironing_model_id) references lms_iron_db.ironing_model(id),
    constraint uq_ironable_item_model_ironing_model_id_clothing_item_id unique (ironing_model_id, clothing_item_id),
    index idx_ironing_model_ironing_model_id (ironing_model_id),
    index idx_ironing_model_clothing_item_id (clothing_item_id)
);

-----------------------------------------------------------------------------------------------------------------
-------------------------------------------------- IRON PRICING DB ----------------------------------------------
-----------------------------------------------------------------------------------------------------------------

create table if not exists lms_iron_pricing_db.ironing_price_rule (
	id int auto_increment,
    ironable_item_model_id int not null,
    name varchar(50) not null,
    /*
    iron-machine-steam-partner1-shirt-N-inr, iron-machine-steam-partner1-pant-A-inr, iron-machine-steam-partner1-saree-E-inr, iron-machine-steam-partner1-suit-Q-inr,
    iron-machine-water-partner1-shirt-M-inr, iron-machine-water-partner1-pant-B-inr, iron-machine-water-partner1-saree-F-inr,
    iron-machine-steam-partner2-shirt-O-inr, iron-machine-steam-partner2-pant-C-inr, iron-machine-steam-partner2-saree-G-inr, iron-machine-steam-partner2-suit-R-inr,
    iron-box-water-partner3-shirt-P-inr, iron-box-water-partner3-pant-D-inr, iron-box-water-partner3-saree-H-inr
    */
    description varchar(100),
    per_unit_price float not null,
    price_currency varchar(10) not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_ironing_price_rule primary key (id),
    constraint uq_ironing_price_rule_ii_model_id_pu_price_p_currency unique (ironable_item_model_id, per_unit_price, price_currency),
	constraint chk_ironing_price_rule_per_unit_price check (per_unit_price > 0),
    index idx_ironing_price_rule_ironable_item_model_id (ironable_item_model_id)
);

create table if not exists lms_iron_pricing_db.ironing_rate (
	id int auto_increment,
    ironing_price_rule_id int not null,
    name varchar(50) not null, 
    description varchar(100),
    /*
    iron-machine-steam-partner1-shirt-N-inr-1-piece, iron-machine-steam-partner1-pant-A-inr-1-piece, iron-machine-steam-partner1-saree-E-inr-1-piece, iron-machine-steam-partner1-suit-Q-inr-1-piece,
    iron-machine-water-partner1-shirt-M-inr-2-piece, iron-machine-water-partner1-pant-B-inr-2-piece, iron-machine-water-partner1-saree-F-inr-2-piece,
    iron-machine-steam-partner2-shirt-O-inr-1-piece, iron-machine-steam-partner2-pant-C-inr-1-piece, iron-machine-steam-partner2-saree-G-inr, iron-machine-steam-partner2-suit-R-inr-1-piece,
    iron-box-water-partner3-shirt-P-inr-1-piece, iron-box-water-partner3-pant-D-inr-1-piece, iron-box-water-partner3-saree-H-inr-1-piece
    */
    per_unit_count int not null,
	created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_ironing_rate primary key (id),
    constraint fk_ironing_rate_ironing_price_rule foreign key (ironing_price_rule_id) references lms_iron_pricing_db.ironing_price_rule(id),
    constraint uq_ironing_rate_ironing_price_rule_id_per_unit_count unique (ironing_price_rule_id, per_unit_count),
    constraint chk_ironing_rate_per_unit_count check (per_unit_count > 0)
);

-----------------------------------------------------------------------------------------------------------------
-------------------------------------------------- IRON DISCOUNT DB ---------------------------------------------
-----------------------------------------------------------------------------------------------------------------

create table if not exists lms_iron_discount_db.ironing_discount_model (
	id int auto_increment,
    ironing_model_id int not null,
    discount_model_id int not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_ironing_discount_model primary key (id),
    index idx_ironing_discount_model_ironing_model_id (ironing_model_id),
    index idx_ironing_discount_model_discount_model_id (discount_model_id)
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
    version int default 0,
    constraint pk_ironing_discount_rate primary key (id),
    constraint fk_ironing_discount_rate_ironing_discount_model foreign key (ironing_discount_model_id) references lms_iron_discount_db.ironing_discount_model(id),
    constraint uq_ironing_discount_rate_name unique (ironing_discount_model_id, name),
    constraint chk_ironing_discount_rate_discount_value check (discount_value > 0),
    constraint chk_ironing_discount_rate_minimum_expected_value check (minimum_expected_value > 0),
    constraint chk_ironing_discount_rate_maximum_allowed_value check (maximum_allowed_value > 0),
    constraint chk_ironing_discount_rate_start_before_expiry check (starts_on < expires_on),
    index idx_ironing_discount_rate_ironing_discount_model_id (ironing_discount_model_id)
);

create table if not exists lms_iron_discount_db.ironing_discount_shipping (
	id int auto_increment,
    ironing_discount_rate_id int not null,
    free_pickup_sw bigint default 0,
    free_delivery_sw bigint default 0,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_ironing_discount_shipping primary key (id),
    constraint fk_iw_discount_shipping_iw_discount_rate foreign key (ironing_discount_rate_id) references lms_iron_discount_db.ironing_discount_rate(id),
    constraint uq_ironing_discount_shipping_rate_pickup_delivery unique (ironing_discount_rate_id, free_pickup_sw, free_delivery_sw),
    index idx_ironing_discount_shipping_ironing_discount_rate_id (ironing_discount_rate_id)
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
    version int default 0,
    constraint pk_ironing_discount_rate_currency primary key (id),
    constraint fk_ironing_discount_rate_currency_ironing_discount_rate foreign key (ironing_discount_rate_id) references lms_iron_discount_db.ironing_discount_rate(id),
    constraint uq_ironing_discount_rate_currency_id_rate_id_ct_lov_id unique (ironing_discount_rate_id, currency_type_lov_id),
    index idx_weighted_washing_discount_rate_currency_id_rate_id (ironing_discount_rate_id),
    index idx_weighted_washing_discount_rate_ct_lov_id (currency_type_lov_id)
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
    version int default 0,
    constraint pk_ironing_discount_rate_history primary key (id),
    constraint fk_ironing_discount_rate_history_ironing_discount_rate foreign key (ironing_discount_rate_id) references lms_iron_discount_db.ironing_discount_rate(id),
    index idx_ironing_discount_rate_history_ironing_discount_rate_id (ironing_discount_rate_id),
    index idx_ironing_discount_rate_history_discount_status_lov_id (discount_status_lov_id),
    index idx_ironing_discount_rate_history_discount_status_reason_id (discount_status_reason_id)
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
    version int default 0,
    constraint pk_ironing_discount_coupon primary key (id),
    constraint fk_ironing_discount_coupon_ironing_discount_rate foreign key (ironing_discount_rate_id) references lms_iron_discount_db.ironing_discount_rate(id),
    constraint uq_ironing_discount_coupon_ironing_discount_rate_id_code_hash unique (ironing_discount_rate_id, code_hash),
    index idx_ironing_discount_coupon_ironing_discount_rate_id (ironing_discount_rate_id),
    index idx_ironing_discount_coupon_code_hash (code_hash)
);

-----------------------------------------------------------------------------------------------------------------
-------------------------------------------------- IRON TRACKING DB ---------------------------------------------
-----------------------------------------------------------------------------------------------------------------

create table if not exists lms_iron_tracking_db.iron_status_lov (
	id int auto_increment,
    name varchar(50) not null, -- new, inspecting, ironing, folding, ready, failed, hold
    description varchar(100),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_wash_status_lov primary key (id)
);

create table if not exists lms_iron_tracking_db.iron_status_reason (
	id int auto_increment,
    text varchar(255), -- other, reason 1, reason 2
    iron_status_lov_id int not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
	version int default 0,
	active_sw bigint default 1,
    constraint pk_iron_status_reason primary key (id),
    constraint fk_iron_status_reason_iron_status_lov_id foreign key (iron_status_lov_id) references lms_iron_tracking_db.iron_status_lov(id),
    index idx_iron_status_reason_iron_status_lov_id (iron_status_lov_id)
);

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
    version int default 0,
    constraint pk_ironable_item_tracker primary key (id),
    constraint uq_ironable_item_tracker_order_number_order_line_id_seq_tag_id unique (order_number, order_line_id, sequence, tag_id),
	constraint chk_ironable_item_tracker_sequence check (sequence > 0),
    index idx_ironable_item_tracker_order_number (order_number),
    index idx_ironable_item_tracker_order_line_id (order_line_id),
    index idx_ironable_item_tracker_tag_id (tag_id)
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
    version int default 0,
    constraint pk_ironable_item_tracking_history primary key (id),
    constraint fk_ironable_item_tracking_history_ironable_item_tracker foreign key (ironable_item_tracker_id) references lms_iron_tracking_db.ironable_item_tracker(id),
    constraint fk_ironable_item_tracking_history_iron_status_lov foreign key (iron_status_lov_id) references lms_iron_tracking_db.iron_status_lov(id),
    constraint fk_ironable_item_tracking_history_iron_status_reason foreign key (iron_status_reason_id) references lms_iron_tracking_db.iron_status_reason(id),
    index idx_ironable_item_tracking_history_ironable_item_tracker_id (ironable_item_tracker_id),
    index idx_ironable_item_tracking_history_iron_status_lov_id (iron_status_lov_id),
    index idx_ironable_item_tracking_history_iron_status_reason_id (iron_status_reason_id)
);

------------------------------------------------------------------------------------------------------------------
-------------------------------------------------- DRY CLEAN DB --------------------------------------------------
------------------------------------------------------------------------------------------------------------------

create table if not exists lms_dry_clean_db.dry_cleaning_model (
	id int auto_increment,
    dry_clean_type_model_id int not null,
    mildness_type_model_id int not null,
    partner_id int not null,
    name varchar(50) not null, 
    /*
    dry-clean-hcs-professional-partner3, dry-clean-pce-professional-partner3,
    dry-clean-hcs-normal-partner1, dry-clean-hcs-gentle-partner1, dry-clean-hcs-very-gentle-partner1, 
    dry-clean-pce-normal-partner2, dry-clean-pce-gentle-partner2, dry-clean-pce-very-gentle-partner2
    */
    description varchar(100),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_washing_model primary key (id),
    constraint uq_washing_model_dc_model_id_wt_model_id_partner_id unique (dry_clean_type_model_id, mildness_type_model_id, partner_id),
    index idx_washing_model_dry_clean_type_model_id (dry_clean_type_model_id),
    index idx_washing_model_mildness_type_model_id (mildness_type_model_id),
    index idx_washing_model_partner_id (partner_id)
);

create table if not exists lms_dry_clean_db.dry_cleanable_item_model (
	id int auto_increment,
    dry_cleaning_model_id int not null,
    clothing_item_id int not null,
    name varchar(50) not null,
    /*
    dry-clean-hcs-professional-partner1-shirt, dry-clean-hcs-professional-partner1-pant, 
    dry-clean-pce-professional-partner2-carpet, dry-clean-pce-professional-partner2-saree,
    dry-clean-hcs-normal-partner1-shirt, dry-clean-hcs-normal-partner1-carpet, dry-clean-hcs-normal-partner1-suit, dry-clean-hcs-normal-partner1-saree 
    dry-clean-hcs-gentle-partner1-shirt, dry-clean-hcs-gentle-partner1-carpet, dry-clean-hcs-gentle-partner1-suit, dry-clean-hcs-gentle-partner1-saree 
    dry-clean-pce-very-gentle-partner1-shirt, dry-clean-hcs-very-gentle-partner1-carpet, dry-clean-hcs-very-gentle-partner1-suit, dry-clean-hcs-very-gentle-partner1-saree 
    dry-clean-pce-normal-partner2-shirt, dry-clean-pce-normal-partner2-carpet, dry-clean-pce-normal-partner2-suit, dry-clean-pce-normal-partner2-saree 
    dry-clean-pce-gentle-partner2-shirt, dry-clean-pce-gentle-partner2-carpet, dry-clean-pce-gentle-partner2-suit, dry-clean-pce-gentle-partner2-saree 
    dry-clean-pce-very-gentle-partner2-shirt, dry-clean-pce-very-gentle-partner2-carpet, dry-clean-pce-very-gentle-partner2-suit, dry-clean-pce-very-gentle-partner2-saree 
    */
    description varchar(100),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_dry_cleanable_item_model primary key (id),
    constraint fk_dry_cleanable_item_model_dry_cleaning_model foreign key (dry_cleaning_model_id) references lms_dry_clean_db.dry_cleaning_model(id),
    constraint uq_dry_cleanable_item_model_dc_model_id_ci_id unique (dry_cleaning_model_id, clothing_item_id),
    index idx_dry_cleanable_item_model_dry_cleaning_model_id (dry_cleaning_model_id),
    index idx_dry_cleanable_item_model_clothing_item_id (clothing_item_id)
);

------------------------------------------------------------------------------------------------------------------
-------------------------------------------------- DRY CLEAN PRICING DB --------------------------------------------
------------------------------------------------------------------------------------------------------------------

create table if not exists lms_dry_clean_pricing_db.dry_cleaning_price_rule (
	id int auto_increment,
    dry_cleanable_item_model_id int not null,
    name varchar(50) not null,
    /*
    dry-clean-hcs-professional-partner1-shirt-A-inr, dry-clean-hcs-professional-partner1-pant-I-inr, 
    dry-clean-pce-professional-partner2-carpet-B-inr, dry-clean-pce-professional-partner2-saree-J-inr,
    dry-clean-hcs-normal-partner1-shirt-C-inr, dry-clean-hcs-normal-partner1-carpet-K-inr, dry-clean-hcs-normal-partner1-suit-Q-inr, dry-clean-hcs-normal-partner1-saree-W-inr
    dry-clean-hcs-gentle-partner1-shirt-D-inr, dry-clean-hcs-gentle-partner1-carpet-L-inr, dry-clean-hcs-gentle-partner1-suit-R-inr, dry-clean-hcs-gentle-partner1-saree-X-inr
    dry-clean-pce-very-gentle-partner1-shirt-E-inr, dry-clean-hcs-very-gentle-partner1-carpet-M-inr, dry-clean-hcs-very-gentle-partner1-suit-S-inr, dry-clean-hcs-very-gentle-partner1-saree-Y-inr
    dry-clean-pce-normal-partner2-shirt-F-inr, dry-clean-pce-normal-partner2-carpet-N-inr, dry-clean-pce-normal-partner2-suit-T-inr, dry-clean-pce-normal-partner2-saree-Z-inr
    dry-clean-pce-gentle-partner2-shirt-G-inr, dry-clean-pce-gentle-partner2-carpet-O-inr, dry-clean-pce-gentle-partner2-suit-U-inr, dry-clean-pce-gentle-partner2-saree-AA-inr
    dry-clean-pce-very-gentle-partner2-shirt-H-inr, dry-clean-pce-very-gentle-partner2-carpet-P-inr, dry-clean-pce-very-gentle-partner2-suit-V-inr, dry-clean-pce-very-gentle-partner2-saree-AB-inr
    */
    description varchar(100),
    per_unit_price float not null,
    price_currency varchar(10) not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_dry_cleaning_price_rule primary key (id),
    constraint uq_dry_cleaning_price_rule_dc_im_id_pu_price_p_currency unique (dry_cleanable_item_model_id, per_unit_price, price_currency),
	constraint chk_dry_cleaning_price_rule_per_unit_price check (per_unit_price > 0),
    index idx_dry_cleaning_price_rule_dry_cleanable_item_model_id (dry_cleanable_item_model_id)
);

create table if not exists lms_dry_clean_pricing_db.dry_cleaning_rate (
	id int auto_increment,
    dry_cleaning_price_rule_id int not null,
    name varchar(50) not null,
    /*
    dry-clean-hcs-professional-partner1-shirt-A-inr-1-piece, dry-clean-hcs-professional-partner1-pant-I-inr-1-piece, 
    dry-clean-pce-professional-partner2-carpet-B-inr-1-piece, dry-clean-pce-professional-partner2-saree-J-inr-1-piece,
    dry-clean-hcs-normal-partner1-shirt-C-inr-1-piece, dry-clean-hcs-normal-partner1-carpet-K-inr-1-piece, dry-clean-hcs-normal-partner1-suit-Q-inr-1-piece, dry-clean-hcs-normal-partner1-saree-W-inr-1-piece
    dry-clean-hcs-gentle-partner1-shirt-D-inr-1-piece, dry-clean-hcs-gentle-partner1-carpet-L-inr-1-piece, dry-clean-hcs-gentle-partner1-suit-R-inr-1-piece, dry-clean-hcs-gentle-partner1-saree-X-inr-1-piece
    dry-clean-pce-very-gentle-partner1-shirt-E-inr-1-piece, dry-clean-hcs-very-gentle-partner1-carpet-M-inr-1-piece, dry-clean-hcs-very-gentle-partner1-suit-S-inr-1-piece, dry-clean-hcs-very-gentle-partner1-saree-Y-inr-1-piece
    dry-clean-pce-normal-partner2-shirt-F-inr-1-piece, dry-clean-pce-normal-partner2-carpet-N-inr-1-piece, dry-clean-pce-normal-partner2-suit-T-inr-1-piece, dry-clean-pce-normal-partner2-saree-Z-inr-1-piece
    dry-clean-pce-gentle-partner2-shirt-G-inr-1-piece, dry-clean-pce-gentle-partner2-carpet-O-inr-1-piece, dry-clean-pce-gentle-partner2-suit-U-inr-1-piece, dry-clean-pce-gentle-partner2-saree-AA-inr-1-piece
    dry-clean-pce-very-gentle-partner2-shirt-H-inr-1-piece, dry-clean-pce-very-gentle-partner2-carpet-P-inr-1-piece, dry-clean-pce-very-gentle-partner2-suit-V-inr-1-piece, dry-clean-pce-very-gentle-partner2-saree-AB-inr-1-piece
    */
    description varchar(100),
    per_unit_count int not null,
	created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_dry_cleaning_rate primary key (id),
    constraint fk_dry_cleaning_rate_dry_cleaning_price_rule foreign key (dry_cleaning_price_rule_id) references lms_dry_clean_pricing_db.dry_cleaning_price_rule(id),
    constraint uq_dry_cleaning_rate_dc_pr_id_per_unit_count unique (dry_cleaning_price_rule_id, per_unit_count),
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
    version int default 0,
    constraint pk_dry_cleaning_discount_model primary key (id),
	index idx_dry_cleaning_discount_model_dc_model_id (dry_cleaning_model_id),
    index idx_dry_cleaning_discount_model_dm_id (discount_model_id)
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
    version int default 0,
    constraint pk_dry_cleaning_discount_rate primary key (id),
    constraint fk_dry_cleaning_discount_rate_ironing_discount_model foreign key (dry_cleaning_discount_model_id) references lms_dry_clean_discount_db.dry_cleaning_discount_model(id),
    constraint uq_dry_cleaning_discount_rate_name unique (dry_cleaning_discount_model_id, name),
    constraint chk_dry_cleaning_discount_rate_discount_value check (discount_value > 0),
    constraint chk_dry_cleaning_discount_rate_minimum_expected_value check (minimum_expected_value > 0),
    constraint chk_dry_cleaning_discount_rate_maximum_allowed_value check (maximum_allowed_value > 0),
    constraint chk_dry_cleaning_discount_rate_start_before_expiry check (starts_on < expires_on),
    index idx_dry_cleaning_discount_rate_dc_discount_model_id (dry_cleaning_discount_model_id)
);

create table if not exists lms_dry_clean_discount_db.dry_cleaning_discount_shipping (
	id int auto_increment,
    dry_cleaning_discount_rate_id int not null,
    free_pickup_sw bigint default 0,
    free_delivery_sw bigint default 0,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_dry_cleaning_discount_shipping primary key (id),
    constraint fk_dc_discount_shipping_dc_discount_rate foreign key (dry_cleaning_discount_rate_id) references lms_dry_clean_discount_db.dry_cleaning_discount_rate(id),
    constraint uq_dry_cleaning_discount_shipping_rate_pickup_delivery unique (dry_cleaning_discount_rate_id, free_pickup_sw, free_delivery_sw),
    index idx_dry_cleaning_discount_shipping_dc_discount_rate_id (dry_cleaning_discount_rate_id)
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
    version int default 0,
    constraint pk_dry_cleaning_discount_rate_currency primary key (id),
    constraint fk_dc_discount_rate_currency_dc_discount_rate foreign key (dry_cleaning_discount_rate_id) references lms_dry_clean_discount_db.dry_cleaning_discount_rate(id),
    constraint uq_dry_cleaning_discount_rate_currency_dc_dr_id_ct_lov_id unique (dry_cleaning_discount_rate_id, currency_type_lov_id),
    index idx_dry_cleaning_discount_rate_currency_dc_discount_rate_id (dry_cleaning_discount_rate_id),
    index idx_dry_cleaning_discount_rate_currency_type_lov_id (currency_type_lov_id)
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
    version int default 0,
    constraint pk_dry_cleaning_discount_rate_history primary key (id),
    constraint fk_dc_discount_rate_history_dc_discount_rate foreign key (dry_cleaning_discount_rate_id) references lms_dry_clean_discount_db.dry_cleaning_discount_rate(id),
    index idx_ironing_discount_rate_history_dry_cleaning_discount_rate_id (dry_cleaning_discount_rate_id),
    index idx_ironing_discount_rate_history_discount_status_lov_id (discount_status_lov_id),
    index idx_ironing_discount_rate_history_discount_status_reason_id (discount_status_reason_id)
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
    version int default 0,
    constraint pk_dry_cleaning_discount_coupon primary key (id),
    constraint fk_dc_discount_coupon_dc_discount_rate foreign key (dry_cleaning_discount_rate_id) references lms_dry_clean_discount_db.dry_cleaning_discount_rate(id),
    constraint uq_dry_cleaning_discount_coupon_dc_dr_id_code_hash unique (dry_cleaning_discount_rate_id, code_hash),
    index idx_dry_cleaning_discount_coupon_dc_dr_id (dry_cleaning_discount_rate_id),
    index idx_dry_cleaning_discount_coupon_code_hash (code_hash)
);

------------------------------------------------------------------------------------------------------------------
-------------------------------------------------- DRY CLEAN TRACKING DB --------------------------------------------
------------------------------------------------------------------------------------------------------------------

create table if not exists lms_dry_clean_tracking_db.dry_cleaning_status_lov (
	id int auto_increment,
    name varchar(50) not null, -- new, inspecting, cleaning, rinsing, drying, folding, ready, failed, hold
    description varchar(100),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_dry_cleaning_status_lov primary key (id)
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
    version int default 0,
    constraint pk_dry_cleaning_status_reason primary key (id),
    constraint fk_dry_cleaning_status_reason_dc_status_lov_id foreign key (dry_cleaning_status_lov_id) references lms_dry_clean_tracking_db.dry_cleaning_status_lov(id),
    index idx_dry_cleaning_status_reason_dc_status_lov_id (dry_cleaning_status_lov_id)
);

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
    version int default 0,
    constraint pk_dry_cleanable_item_tracker primary key (id),
    constraint uq_dry_cleanable_item_tracker_on_ol_id_seq_tag_id unique (order_number, order_line_id, sequence, tag_id),
	constraint chk_dry_cleanable_item_tracker_sequence check (sequence > 0),
    index idx_dry_cleanable_item_tracker_order_number (order_number),
    index idx_dry_cleanable_item_tracker_order_line_id (order_line_id),
    index idx_dry_cleanable_item_tracker_tag_id (tag_id)
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
    version int default 0,
    constraint pk_dry_cleanable_item_tracking_history primary key (id),
    constraint fk_dryc_item_tracking_history_dryc_item_tracker foreign key (dry_cleanable_item_tracker_id) references lms_dry_clean_tracking_db.dry_cleanable_item_tracker(id),
    constraint fk_dryc_item_tracking_history_dryc_status_lov foreign key (dry_cleaning_status_lov_id) references lms_dry_clean_tracking_db.dry_cleaning_status_lov(id),
    constraint fk_dryc_item_tracking_history_dryc_status_reason foreign key (dry_cleaning_status_reason_id) references lms_dry_clean_tracking_db.dry_cleaning_status_reason(id),
    index ix_dry_cleanable_item_tracking_history_dc_item_tracker_id (dry_cleanable_item_tracker_id),
    index idx_dry_cleanable_item_tracking_history_dc_status_lov_id (dry_cleaning_status_lov_id),
    index idx_dry_cleanable_item_tracking_history_dc_status_reason_id (dry_cleaning_status_reason_id)
);

-----------------------------------------------------------------------------------------------------------------
-------------------------------------------------- PICKUP DB ----------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

create table if not exists lms_pickup_db.pickup_model (
	id int auto_increment,
    pickup_type_model_id int not null,
    agent_id int not null,
    /*
    pickup-scheduled-partner1, pickup-same-day-partner1, pickup-standard-partner1,
    pickup-scheduled-partner2, pickup-same-day-partner2, pickup-standard-partner2
    */
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_pickup_model primary key (id),
    constraint uq_pickup_model_pickup_type_model_id_agent_id unique (pickup_type_model_id, agent_id),
    index idx_pickup_model_pickup_type_model_id (pickup_type_model_id),
    index idx_pickup_model_pickup_type_agent_id (agent_id)
);

-----------------------------------------------------------------------------------------------------------------
----------------------------------------------- PICKUP PRICE DB -------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

create table if not exists lms_pickup_pricing_db.pickup_price_rule (
	id int auto_increment,
    pickup_model_id int not null,
    name varchar(50) not null,
    /*
    pickup-scheduled-partner1-A-inr, pickup-same-day-partner1-C-inr, pickup-standard-partner1-E-inr,
    pickup-scheduled-partner2-B-inr, pickup-same-day-partner2-D-inr, pickup-standard-partner2-F-inr
    */
    description varchar(100),
	per_unit_price float not null,
    price_currency varchar(10) not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_pickup_price_rule primary key (id),
    constraint uq_pickup_price_rule_pickup_model_id_pu_price_p_currency unique (pickup_model_id, per_unit_price, price_currency),
    constraint chk_pickup_price_rule_per_unit_price check (per_unit_price > 0),
    index idx_pickup_price_rule_pickup_model_id (pickup_model_id)
);

create table if not exists lms_pickup_db.pickup_rate (
	id int auto_increment,
    pickup_price_rule_id int not null,
    name varchar(50) not null,
    /*
    pickup-scheduled-partner1-A-inr-Q-km, pickup-same-day-partner1-C-inr-E-km, pickup-standard-partner1-E-inr-T-km,
    pickup-scheduled-partner2-B-inr-W-km, pickup-same-day-partner2-D-inr-R-km, pickup-standard-partner2-F-inr-Y-km
    */
    description varchar(100),
	per_unit_distance float not null,
    distance_unit varchar(10) not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_pickup_rate primary key (id),
    constraint fk_pickup_rate_pickup_price_rule foreign key (pickup_price_rule_id) references lms_pickup_pricing_db.pickup_price_rule(id),
    constraint uq_pickup_rate_pickup_price_rule_id_pu_distance_du unique (pickup_price_rule_id, per_unit_distance, distance_unit),
    constraint chk_pickup_rate_per_unit_distance check (per_unit_distance > 0),
    index idx_pickup_rate_pickup_price_rule_id (pickup_price_rule_id)
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
    version int default 0,
    constraint pk_pickup_status_lov primary key (id)
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
    version int default 0,
    constraint pk_pickup_status_reason primary key (id),
    constraint fk_pickup_status_reason_pickup_status_lov foreign key (pickup_status_lov_id) references lms_pickup_tracking_db.pickup_status_lov(id),
    index idx_pickup_status_reason_pickup_status_lov_id (pickup_status_lov_id)
);

create table if not exists lms_pickup_tracking_db.pickup_detail (
	id int auto_increment,
    order_number varchar(128) not null,
    pickup_rate_id int not null,
    distance float not null,
    distance_unit varchar(10) not null,
    successful_sw bigint,
    hold_sw bigint,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_pickup_detail primary key (id),
    constraint uq_pickup_detail_order_number_pickup_rate_id unique (order_number, pickup_rate_id),
    constraint chk_pickup_detail_distance check (distance > 0),
    index idx_pickup_detail_order_number (order_number),
    index idx_pickup_detail_pickup_rate_id (pickup_rate_id)
);

create table if not exists lms_pickup_tracking_db.pickup_from_customer (
	id int auto_increment,
    pickup_detail_id int not null,
    customer_id int not null,
    customer_address_id int not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_pickup_from_customer primary key (id),
    constraint fk_pickup_from_customer_pickup_detail foreign key (pickup_detail_id) references lms_pickup_tracking_db.pickup_detail(id),
    constraint uq_pickup_from_customer_pickup_detail_id_c_id_ca_id unique (pickup_detail_id, customer_id, customer_address_id),
    index idx_pickup_from_customer_pickup_detail_id (pickup_detail_id),
    index idx_pickup_from_customer_customer_id (customer_id),
    index idx_pickup_from_customer_customer_address_id (customer_address_id)
);

create table if not exists lms_pickup_tracking_db.pickup_to_partner (
	id int auto_increment,
    pickup_detail_id int not null,
    partner_id int not null,
    partner_address_id int not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_pickup_to_partner primary key (id),
    constraint fk_pickup_to_partner_pickup_detail foreign key (pickup_detail_id) references lms_pickup_tracking_db.pickup_detail(id),
    constraint uq_pickup_to_partner_pickup_detail_id_p_id_pa_id unique (pickup_detail_id, partner_id, partner_address_id),
    index idx_pickup_to_partner_pickup_detail_id (pickup_detail_id),
    index idx_pickup_to_partner_partner_id (partner_id),
    index idx_pickup_to_partner_partner_address_id (partner_address_id)
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
    version int default 0,
    constraint pk_pickup_agent_assignment primary key (id),
    constraint fk_pickup_agent_assignment_pickup_detail foreign key (pickup_detail_id) references lms_pickup_tracking_db.pickup_detail(id),
    constraint uq_pickup_agent_assignment_pickup_detail_id_by_agent_id unique (pickup_detail_id, by_agent_id),
    index idx_pickup_agent_assignment_pickup_detail_id (pickup_detail_id),
    index idx_pickup_agent_assignment_by_agent_id (by_agent_id)
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
    version int default 0,
    constraint pk_pickup_schedule primary key (id),
    constraint fk_pickup_schedule_pickup_detail foreign key (pickup_detail_id) references lms_pickup_tracking_db.pickup_detail(id),
    constraint uq_pickup_schedule_expected_from_expected_to unique (pickup_detail_id, expected_from, expected_to),
    index idx_pickup_schedule_pickup_detail_id (pickup_detail_id)
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
    version int default 0,
    constraint pk_pickup_transit_history primary key (id),
	constraint fk_pickup_transit_history_pickup_detail foreign key (pickup_detail_id) references lms_pickup_tracking_db.pickup_detail(id),
    constraint fk_pickup_transit_history_pickup_status_lov foreign key (pickup_status_lov_id) references lms_pickup_tracking_db.pickup_status_lov(id),
    constraint fk_pickup_transit_history_pickup_status_reason foreign key (pickup_status_reason_id) references lms_pickup_tracking_db.pickup_status_reason(id),
    index idx_pickup_transit_history_pickup_detail_id (pickup_detail_id),
    index idx_pickup_transit_history_pickup_status_lov_id (pickup_status_lov_id),
    index idx_pickup_transit_history_pickup_status_reason_id (pickup_status_reason_id)
);

-----------------------------------------------------------------------------------------------------------------
-------------------------------------------------- DELIVERY DB --------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

create table if not exists lms_delivery_db.delivery_model (
	id int auto_increment,
    delivery_type_model_id int not null,
    agent_id int not null,
    /*
    delivery-scheduled-partner1, delivery-same-day-partner1, delivery-standard-partner1,
    delivery-scheduled-partner2, delivery-same-day-partner2, delivery-standard-partner2
    */
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_delivery_model primary key (id),
    constraint uq_delivery_model_delivery_type_model_id_agent_id unique (delivery_type_model_id, agent_id),
    index idx_delivery_model_delivery_type_model_id (delivery_type_model_id),
    index idx_delivery_model_delivery_type_agent_id (agent_id)
);

-----------------------------------------------------------------------------------------------------------------
----------------------------------------------- DELIVERY PRICE DB -----------------------------------------------
-----------------------------------------------------------------------------------------------------------------


create table if not exists lms_delivery_pricing_db.delivery_price_rule (
	id int auto_increment,
    delivery_model_id int not null,
    name varchar(50) not null,
    /*
    delivery-scheduled-partner1-A-inr, delivery-same-day-partner1-C-inr, delivery-standard-partner1-E-inr,
    delivery-scheduled-partner2-B-inr, delivery-same-day-partner2-D-inr, delivery-standard-partner2-F-inr
    */
    description varchar(100),
	per_unit_price float not null,
    price_currency varchar(10) not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_delivery_price_rule primary key (id),
    constraint uq_delivery_price_rule_delivery_model_id_pu_price_p_currency unique (delivery_model_id, per_unit_price, price_currency),
    constraint chk_delivery_price_rule_per_unit_price check (per_unit_price > 0),
    index idx_delivery_price_rule_delivery_model_id (delivery_model_id)
);

create table if not exists lms_delivery_pricing_db.delivery_rate (
	id int auto_increment,
    delivery_price_rule_id int not null,
    name varchar(50) not null,
    /*
    delivery-scheduled-partner1-A-inr-Q-km, delivery-same-day-partner1-C-inr-E-km, delivery-standard-partner1-E-inr-T-km,
    delivery-scheduled-partner2-B-inr-W-km, delivery-same-day-partner2-D-inr-R-km, delivery-standard-partner2-F-inr-Y-km
    */
    description varchar(100),
	per_unit_distance float not null,
    distance_unit varchar(10) not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_delivery_rate primary key (id),
    constraint fk_delivery_rate_delivery_price_rule foreign key (delivery_price_rule_id) references lms_delivery_pricing_db.delivery_price_rule(id),
    constraint uq_delivery_rate_delivery_price_rule_id_pu_distance_du unique (delivery_price_rule_id, per_unit_distance, distance_unit),
    constraint chk_delivery_rate_per_unit_distance check (per_unit_distance > 0),
    index idx_delivery_rate_delivery_price_rule_id (delivery_price_rule_id)
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
    version int default 0,
    constraint pk_pickup_status_lov primary key (id)
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
    version int default 0,
    constraint pk_delivery_status_reason primary key (id),
    constraint fk_delivery_status_reason_pickup_status_lov foreign key (delivery_status_lov_id) references lms_delivery_tracking_db.delivery_status_lov(id),
    index idx_delivery_status_reason_delivery_status_lov_id (delivery_status_lov_id)
);

create table if not exists lms_delivery_tracking_db.delivery_detail (
	id int auto_increment,
    order_number varchar(128) not null,
    delivery_rate_id int not null,
    distance float not null,
    distance_unit varchar(10) not null,
    successful_sw bigint,
    hold_sw bigint,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_delivery_detail primary key (id),
    constraint uq_delivery_detail_order_number_delivery_rate_id unique (order_number, delivery_rate_id),
    constraint chk_delivery_detail_distance check (distance > 0),
    index idx_delivery_detail_order_number (order_number),
    index idx_delivery_detail_delivery_rate_id (delivery_rate_id)
);

create table if not exists lms_delivery_tracking_db.delivery_from_partner (
	id int auto_increment,
    delivery_detail_id int not null,
    partner_id int not null,
    partner_address_id int not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_pickup_from_partner primary key (id),
    constraint fk_pickup_from_partner_delivery_detail foreign key (delivery_detail_id) references lms_delivery_tracking_db.delivery_detail(id),
    constraint uq_pickup_from_partner_delivery_detail_id_p_id_pa_id unique (delivery_detail_id, partner_id, partner_address_id),
    index idx_pickup_from_partner_delivery_detail_id (delivery_detail_id),
    index idx_pickup_from_partner_partner_id (partner_id),
    index idx_pickup_from_partner_partner_address_id (partner_address_id)
);

create table if not exists lms_delivery_tracking_db.deliver_to_customer (
	id int auto_increment,
    delivery_detail_id int not null,
    customer_id int not null,
    customer_address_id int not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_deliver_to_customer primary key (id),
    constraint fk_deliver_to_customer_delivery_detail foreign key (delivery_detail_id) references lms_delivery_tracking_db.delivery_detail(id),
    constraint uq_deliver_to_customer_delivery_detail_id_c_id_ca_id unique (delivery_detail_id, customer_id, customer_address_id),
    index idx_deliver_to_customer_delivery_detail_id (delivery_detail_id),
    index idx_deliver_to_customer_customer_id (customer_id),
    index idx_deliver_to_customer_customer_address_id (customer_address_id)
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
    version int default 0,
    constraint pk_delivery_agent_assignment primary key (id),
    constraint fk_delivery_agent_assignment_delivery_detail foreign key (delivery_detail_id) references lms_delivery_tracking_db.delivery_detail(id),
    constraint uq_delivery_agent_assignment_delivery_detail_id_by_agent_id unique (delivery_detail_id, by_agent_id),
    index idx_delivery_agent_assignment_delivery_detail_id (delivery_detail_id),
    index idx_delivery_agent_assignment_by_agent_id (by_agent_id)
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
    version int default 0,
    constraint pk_delivery_schedule primary key (id),
    constraint fk_delivery_schedule_delivery_detail foreign key (delivery_detail_id) references lms_delivery_tracking_db.delivery_detail(id),
    constraint uq_delivery_schedule_expected_from_expected_to unique (delivery_detail_id, expected_from, expected_to),
    index idx_delivery_schedule_delivery_detail_id (delivery_detail_id)
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
    version int default 0,
    constraint pk_delivery_transit_history primary key (id),
	constraint fk_delivery_transit_history_delivery_detail foreign key (delivery_detail_id) references lms_delivery_tracking_db.delivery_detail(id),
    constraint fk_delivery_transit_history_delivery_status_lov foreign key (delivery_status_lov_id) references lms_delivery_tracking_db.delivery_status_lov(id),
    constraint fk_delivery_transit_history_delivery_status_reason foreign key (delivery_status_reason_id) references lms_delivery_tracking_db.delivery_status_reason(id),
    index idx_delivery_transit_history_delivery_detail_id (delivery_detail_id),
    index idx_delivery_transit_history_delivery_status_lov_id (delivery_status_lov_id),
    index idx_delivery_transit_history_delivery_status_reason_id (delivery_status_reason_id)
);

-----------------------------------------------------------------------------------------------------------------
------------------------------------------------- ADJUSTMENT DB -------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

/*
adjustment-discount, adjustment-deal, adjustment-subscription, adjustment-tax, adjustment-pickup, adjustment-delivery
*/

create table if not exists lms_adjustment_db.adjustment_model (
	id int auto_increment,
    adjustment_type_model_id int not null,
    adjustment_nature enum('ADDITIVE', 'DEDUCTIVE') not null,
    name varchar(20) not null, -- adjustment-deductive-discount, adjustment-deductive-deal, adjustment-deductive-subscription, adjustment-additive-tax, adjustment-additive-pickup, adjustment-additive-delivery
    description varchar(100),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_adjustment_model primary key (id),
    constraint uq_adjustment_model_at_model_id_adjustment_nature unique (adjustment_type_model_id, adjustment_nature),
    index idx_adjustment_model_adjustment_type_model_id (adjustment_type_model_id)
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
    version int default 0,
    constraint pk_order_status_lov primary key (id)
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
    version int default 0,
    constraint pk_order_status_reason primary key (id),
    constraint fk_order_status_reason_order_status_lov foreign key (order_status_lov_id) references lms_order_db.order_status_lov(id),
    index idx_order_status_reason_order_status_lov_id (order_status_lov_id)
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
    version int default 0,
    constraint pk_order_header primary key (id),
    constraint uq_order_header_user_id_enterprise_id_number unique (user_id, enterprise_id, number),
    constraint chk_order_header_sub_total check (sub_total >= 0),
    constraint chk_order_header_total_deductions check (total_deductions >= 0),
    constraint chk_order_header_total_additives check (total_additives >= 0),
    index idx_order_header_user_id (user_id),
    index idx_order_header_enterprise_id (enterprise_id),
    index idx_order_header_number (number)
);

/*
adjustment-deductive-discount, adjustment-deductive-deal, adjustment-deductive-subscription, adjustment-additive-tax, adjustment-additive-pickup, adjustment-additive-delivery
*/

create table if not exists lms_order_db.order_adjustment_deduction (
	id int auto_increment,
    order_header_id int not null,
    adjustment_model_id int not null,
    deduction_name varchar(50) not null,
    deducted_amount float not null,
    created_on timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_order_adjustment_deduction primary key (id),
    constraint fk_order_adjustment_deduction_order_header foreign key (order_header_id) references lms_order_db.order_header(id),
    constraint chk_order_adjustment_deduction_deducted_amount check (deducted_amount >= 0),
    constraint uq_order_adjustment_deduction_oh_am_id_deduction_name unique (order_header_id, adjustment_model_id, deduction_name),
    index idx_order_adjustment_deduction_order_header_id (order_header_id),
    index idx_order_adjustment_deduction_adjustment_model_id (adjustment_model_id),
    index idx_order_adjustment_deduction_deduction_name (deduction_name)
);

create table if not exists lms_order_db.order_adjustment_addition (
	id int auto_increment,
    order_header_id int not null,
    adjustment_model_id int not null,
    addition_name varchar(50) not null,
    added_amount float not null,
    created_on timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_order_adjustment_addition primary key (id),
    constraint fk_order_adjustment_addition_order_header foreign key (order_header_id) references lms_order_db.order_header(id),
    constraint chk_order_adjustment_addition_added_amount check (added_amount >= 0),
    constraint uq_order_adjustment_addition_oh_am_id_addition_name unique (order_header_id, adjustment_model_id, addition_name),
    index idx_order_adjustment_addition_order_header_id (order_header_id),
    index idx_order_adjustment_addition_adjustment_model_id (adjustment_model_id),
    index idx_order_adjustment_addition_adjustment_name (addition_name)
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
    version int default 0,
    constraint pk_order_status_history primary key (id),
    constraint fk_order_status_history_order_header foreign key (order_header_id) references lms_order_db.order_header(id),
    constraint fk_order_status_history_order_status_lov foreign key (order_status_lov_id) references lms_order_db.order_status_lov(id),
    constraint fk_order_status_history_order_status_reason foreign key (order_status_reason_id) references lms_order_db.order_status_reason(id),
    index idx_order_status_history_order_header_id (order_header_id),
    index idx_order_status_history_order_status_lov_id (order_status_lov_id),
    index idx_order_status_history_order_status_reason_id (order_status_reason_id)
);

create table if not exists lms_order_db.order_line (
	id int auto_increment,
    order_header_id int not null,
    lanudry_type_model_id int not null,
    sequence int not null,
    comment varchar(255),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_order_line primary key (id),
    constraint fk_order_line_order_header foreign key (order_header_id) references lms_order_db.order_header(id),
    constraint uq_order_line_order_header_id_lt_model_id_sequence unique (order_header_id, lanudry_type_model_id, sequence),
    constraint chk_order_line_sequence check (sequence > 0),
    index idx_order_line_order_header_id (order_header_id),
    index idx_order_line_lanudry_type_model_id (lanudry_type_model_id)
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
    version int default 0,
    constraint pk_order_line_detail primary key (id),
    constraint fk_order_line_detail_order_line foreign key (order_line_id) references lms_order_db.order_line(id),
    constraint uq_order_line_detail_ol_id_ci_id_sequence unique (order_line_id, clothing_item_id, sequence),
    constraint chk_order_line_detail_sequence check (sequence > 0),
    constraint chk_order_line_detail_quantity check (quantity > 0),
    constraint chk_order_line_detail_rate check (rate > 0),
    index idx_order_line_detail_order_line_id (order_line_id),
    index idx_order_line_detail_clothing_item_id (clothing_item_id)
);

-----------------------------------------------------------------------------------------------------------------
-------------------------------------------------- TRANSACTION DB ---------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

create table if not exists lms_transaction_db.transaction_status_lov (
	id int auto_increment,
    name varchar(50) not null, -- new, in-progress, finished, aborted, failure, hold
    description varchar(100),
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_transaction_status_lov primary key (id)
);

create table if not exists lms_transaction_db.transaction_status_reason (
	id int auto_increment,
    text varchar(255), -- other, reason 1, reason 2
    transaction_status_lov_id int not null,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_transaction_status_reason primary key (id),
    constraint fk_transaction_status_reason_transaction_status_lov foreign key (transaction_status_lov_id) references lms_transaction_db.transaction_status_lov(id),
    index idx_transaction_status_reason_transaction_status_lov_id (transaction_status_lov_id)
);

create table if not exists lms_transaction_db.transaction_detail (
	id int auto_increment,
    payment_type_model_id int not null,
    order_number int not null,
    number varchar(128) not null,
    payment_reference_number varchar(128),
    amount float not null,
    currency varchar(10) not null,
    started_on timestamp not null,
    finished_on timestamp,
    payment_sw bigint default 0,
    successful_sw bigint default 0,
    hold_sw bigint default 0,
    created_on timestamp default current_timestamp,
    created_by int not null,
    modified_on timestamp default current_timestamp,
    modified_by int,
    active_sw bigint default 1,
    version int default 0,
    constraint pk_transaction_detail primary key (id),
    constraint uq_transaction_detail_pt_model_id_on_number unique (payment_type_model_id, order_number, number),
    constraint chk_transaction_detail_amount check (amount > 0),
    index idx_transaction_detail_payment_type_model_id (payment_type_model_id),
    index idx_transaction_detail_order_number (order_number),
    index idx_transaction_detail_number (number)
);

create table if not exists lms_transaction_db.transaction_movement_history (
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
    version int default 0,
    constraint pk_transaction_movement_history primary key (id),
	constraint fk_transaction_movement_history_transaction_detail foreign key (transaction_detail_id) references lms_transaction_db.transaction_detail(id),
    constraint fk_transaction_movement_history_ts_lov foreign key (transaction_status_lov_id) references lms_transaction_db.transaction_status_lov(id),
    constraint fk_transaction_movement_history_ts_reason foreign key (transaction_status_reason_id) references lms_transaction_db.transaction_status_reason(id),
    index idx_transaction_movement_history_transaction_detail_id (transaction_detail_id),
    index idx_transaction_movement_history_ts_lov_id (transaction_status_lov_id),
    index idx_transaction_movement_history_ts_reason_id (transaction_status_reason_id)
);
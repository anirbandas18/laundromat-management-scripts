create user 'lmm'@'%' identified by '|\/|3t@daTA'; -- Metadata
create user 'lwm'@'%' identified by '\/\/@$#!NG'; -- Wash
create user 'lclm'@'%' identified by 'Cl0t#!|\|g'; -- Clothing
create user 'lim'@'%' identified by '!r0Ni|\|G'; -- Ironing
create user 'ldcm'@'%' identified by 'DrYCL3A|\|'; -- Dry Clean
create user 'lum'@'%' identified by 'U$3r'; -- User
create user 'lcum'@'%' identified by 'Cu$t0|\/|3r'; -- Customer
create user 'lagm'@'%' identified by '/\G3|\|t'; -- Agent
create user 'lprtm'@'%' identified by 'P@rt|\|3R'; -- Partner
create user 'ldim'@'%' identified by 'D!$c0u|\|t'; -- Discount
create user 'ltm'@'%' identified by 'T@x'; -- Tax
create user 'lom'@'%' identified by 'o5d3R'; -- Order
create user 'lpm'@'%' identified by 'P@y|\/|3|\|t'; -- Payment
create user 'lpkm'@'%' identified by 'P!cKUp'; -- Pickup
create user 'ldelm'@'%' identified by 'D3L!\/eRy'; --  Delivery
create user 'ldtm'@'%' identified by 'P!cKUp--Tr@ckI|\|G'; -- Pickup Tracking
create user 'lptm'@'%' identified by 'D3L!\/eRy-Tr@ckI|\|G'; --  Delivery Tracking
create user 'lcm'@'%' identified by 'C0|\|$3nT'; -- Consent
create user 'lvm'@'%' identified by '\/3R!fY'; -- Verify
create user 'lwdm'@'%' identified by '\/\/@$#!NG-D!$c0u|\|t'; -- Wash Discount
create user 'lwpm'@'%' identified by '\/\/@$#!NG-Pr!cI|\|g'; -- Wash Pricing
create user 'lwtm'@'%' identified by '\/\/@$#!NG-Tr@ckI|\|G'; -- Wash Tracking
create user 'lidm'@'%' identified by '!r0Ni|\|G-D!$c0u|\|t'; -- Iron Discount
create user 'lipm'@'%' identified by '!r0Ni|\|G-Pr!cI|\|g'; --  Iron Pricing
create user 'litm'@'%' identified by '!r0Ni|\|G-Tr@ckI|\|G'; -- Iron Tracking
create user 'ldcdm'@'%' identified by 'DrYCL3A|\|-D!$c0u|\|t'; -- Dry Clean Discount
create user 'ldcpm'@'%' identified by 'DrYCL3A|\|-Pr!cI|\|g'; -- Dry Clean Pricing
create user 'ldctm'@'%' identified by 'DrYCL3A|\|-Tr@ckI|\|G'; -- Dry Clean Tracking
create user 'ldm'@'%' identified by 'D!$c0u|\|t'; -- Discount


create database lms_metadata_db;
create database lms_tax_db;
create database lms_discount_db;
create database lms_clothing_db;
create database lms_user_db;
create database lms_customer_db;
create database lms_agent_db;
create database lms_partner_db;
create database lms_consent_db;
create database lms_verification_db;
create database lms_wash_db;
create database lms_wash_discount_db;
create database lms_wash_tracking_db;
create database lms_wash_pricing_db;
create database lms_iron_db;
create database lms_iron_discount_db;
create database lms_iron_tracking_db;
create database lms_iron_pricing_db;
create database lms_dry_clean_db;
create database lms_dry_clean_discount_db;
create database lms_dry_clean_tracking_db;
create database lms_dry_clean_pricing_db;
create database lms_order_db;
create database lms_payment_db;
create database lms_pickup_db;
create database lms_pickup_tracking_db;
create database lms_delivery_db;
create database lms_delivery_tracking_db;


grant select, insert, update on lms_metadata_db.* to 'lmm'@'%';
grant select, insert, update on lms_tax_db.* to 'ldim'@'%';
grant select, insert, update on lms_discount_db.* to 'ldim'@'%';
grant select, insert, update on lms_clothing_db.* to 'lclm'@'%';
grant select, insert, update on lms_user_db.* to 'lum'@'%';
grant select, insert, update on lms_customer_db.* to 'lcum'@'%';
grant select, insert, update on lms_agent_db.* to 'lagm'@'%';
grant select, insert, update on lms_partner_db.* to 'lprtm'@'%';
grant select, insert, update on lms_consent_db.* to 'lcm'@'%';
grant select, insert, update on lms_verification_db.* to 'lvm'@'%';
grant select, insert, update on lms_wash_db.* to 'lwm'@'%';
grant select, insert, update on lms_wash_discount_db.* to 'lwdm'@'%';
grant select, insert, update on lms_wash_tracking_db.* to 'lwtm'@'%';
grant select, insert, update on lms_wash_pricing_db.* to 'lwpm'@'%';
grant select, insert, update on lms_iron_db.* to 'lim'@'%';
grant select, insert, update on lms_iron_pricing_db.* to 'lipm'@'%';
grant select, insert, update on lms_iron_discount_db.* to 'lidm'@'%';
grant select, insert, update on lms_iron_tracking_db.* to 'litm'@'%';
grant select, insert, update on lms_dry_clean_db.* to 'ldcm'@'%';
grant select, insert, update on lms_dry_clean_discount_db.* to 'ldcdm'@'%';
grant select, insert, update on lms_dry_clean_pricing_db.* to 'ldcpm'@'%';
grant select, insert, update on lms_dry_clean_tracking_db.* to 'ldctm'@'%';
grant select, insert, update on lms_order_db.* to 'lom'@'%';
grant select, insert, update on lms_payment_db.* to 'lpm'@'%';
grant select, insert, update on lms_pickup_db.* to 'lpkm'@'%';
grant select, insert, update on lms_pickup_tracking_db.* to 'lptm'@'%';
grant select, insert, update on lms_delivery_db.* to 'ldelm'@'%';
grant select, insert, update on lms_delivery_tracking_db.* to 'ldtm'@'%';


drop database lms_metadata_db;
drop database lms_tax_db;
drop database lms_discount_db;
drop database lms_clothing_db;
drop database lms_user_db;
drop database lms_customer_db;
drop database lms_agent_db;
drop database lms_partner_db;
drop database lms_consent_db;
drop database lms_verification_db;
drop database lms_wash_db;
drop database lms_wash_pricing_db;
drop database lms_wash_discount_db;
drop database lms_wash_tracking_db;
drop database lms_iron_db;
drop database lms_iron_pricing_db;
drop database lms_iron_discount_db;
drop database lms_iron_tracking_db;
drop database lms_dry_clean_db;
drop database lms_dry_clean_pricing_db;
drop database lms_dry_clean_discount_db;
drop database lms_dry_clean_tracking_db;
drop database lms_order_db;
drop database lms_payment_db;
drop database lms_pickup_db;
drop database lms_pickup_tracking_db;
drop database lms_delivery_db;
drop database lms_delivery_tracking_db;


drop user 'ldm'@'%';
drop user 'lmm'@'%';
drop user 'lwm'@'%';
drop user 'lim'@'%';
drop user 'ldcm'@'%';
drop user 'lum'@'%';
drop user 'lcum'@'%';
drop user 'lagm'@'%';
drop user 'lprtm'@'%';
drop user 'lom'@'%';
drop user 'lpm'@'%';
drop user 'lpkm'@'%';
drop user 'ldelm'@'%';
drop user 'lcm'@'%';
drop user 'lvm'@'%';
drop user 'ldim'@'%';
drop user 'lclm'@'%';
drop user 'ltm'@'%';
drop user 'lwdm'@'%';
drop user 'lidm'@'%';
drop user 'ldcdm'@'%';
drop user 'lptm'@'%';
drop user 'ldtm'@'%';
drop user 'lwpm'@'%';
drop user 'lipm'@'%';
drop user 'ldcpm'@'%';
drop user 'lwtm'@'%';
drop user 'litm'@'%';
drop user 'ldctm'@'%';
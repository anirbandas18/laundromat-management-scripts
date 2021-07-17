create user 'lms_type_manager'@'%' identified by '|\/|3t@daTA'; -- Metadata
create user 'lms_tax_manager'@'%' identified by '\/\/@$#!NG'; -- Wash
create user 'lms_discount_manager'@'%' identified by 'Cl0t#!|\|g'; -- Clothing
create user 'lms_clothing_manager'@'%' identified by '!r0Ni|\|G'; -- Ironing
create user 'lms_access_manager'@'%' identified by '/\Cc3s$'; -- Access
create user 'lms_user_manager'@'%' identified by 'DrYCL3A|\|'; -- Dry Clean
create user 'lms_reset_manager'@'%' identified by 'U$3r'; -- User
create user 'lms_customer_manager'@'%' identified by 'Cu$t0|\/|3r'; -- Customer
create user 'lms_subscription_manager'@'%' identified by '/\G3|\|t'; -- Agent
create user 'lms_employee_db'@'%' identified by 'P@rt|\|3R'; -- Partner
create user 'lms_agent_manager'@'%' identified by 'D!$c0u|\|t'; -- Discount
create user 'lms_partner_manager'@'%' identified by 'T@x'; -- Tax
create user 'lms_consent_manager'@'%' identified by 'o5d3R'; -- Order
create user 'lms_verification_manager'@'%' identified by 'P@y|\/|3|\|t'; -- Payment
create user 'lms_wash_manager'@'%' identified by 'P!cKUp'; -- Pickup
create user 'lms_wash_pricing_manager'@'%' identified by 'D3L!\/eRy'; --  Delivery
create user 'lms_wash_discount_manager'@'%' identified by 'P!cKUp--Tr@ckI|\|G'; -- Pickup Tracking
create user 'lms_wash_tracking_manager'@'%' identified by 'D3L!\/eRy-Tr@ckI|\|G'; --  Delivery Tracking
create user 'lms_iron_manager'@'%' identified by 'C0|\|$3nT'; -- Consent
create user 'lms_iron_pricing_manager'@'%' identified by '\/3R!fY'; -- Verify
create user 'lms_iron_discount_manager'@'%' identified by '\/\/@$#!NG-D!$c0u|\|t'; -- Wash Discount
create user 'lms_iron_tracking_manager'@'%' identified by '\/\/@$#!NG-Pr!cI|\|g'; -- Wash Pricing
create user 'lms_dry_clean_manager'@'%' identified by '\/\/@$#!NG-Tr@ckI|\|G'; -- Wash Tracking
create user 'lms_dry_clean_pricing_manager'@'%' identified by '!r0Ni|\|G-D!$c0u|\|t'; -- Iron Discount
create user 'lms_dry_clean_discount_manager'@'%' identified by '!r0Ni|\|G-Pr!cI|\|g'; --  Iron Pricing
create user 'lms_dry_clean_tracking_manager'@'%' identified by '!r0Ni|\|G-Tr@ckI|\|G'; -- Iron Tracking
create user 'lms_pickup_manager'@'%' identified by 'DrYCL3A|\|-D!$c0u|\|t'; -- Dry Clean Discount
create user 'lms_pickup_pricing_manager'@'%' identified by 'DrYCL3A|\|-Pr!cI|\|g'; -- Dry Clean Pricing
create user 'lms_pickup_tracking_manager'@'%' identified by 'DrYCL3A|\|-Tr@ckI|\|G'; -- Dry Clean Tracking
create user 'lms_delivery_manager'@'%' identified by 'D!$c0u|\|t'; -- Discount
create user 'lms_delivery_pricing_manager'@'%' identified by 'D!$c0u|\|t'; -- Discount
create user 'lms_delivery_tracking_manager'@'%' identified by 'D!$c0u|\|t'; -- Discount
create user 'lms_adjustment_manager'@'%' identified by 'D!$c0u|\|t'; -- Discount
create user 'lms_order_manager'@'%' identified by 'D!$c0u|\|t'; -- Discount
create user 'lms_transaction_manager'@'%' identified by 'D!$c0u|\|t'; -- Discount




create database lms_type_db;
create database lms_tax_db;
create database lms_discount_db;
create database lms_clothing_db;
create database lms_access_db;
create database lms_user_db;
create database lms_reset_db;
create database lms_customer_db;
create database lms_subscription_db;
create database lms_employee_db;
create database lms_agent_db;
create database lms_partner_db;
create database lms_consent_db;
create database lms_verification_db;
create database lms_wash_db;
create database lms_wash_pricing_db;
create database lms_wash_discount_db;
create database lms_wash_tracking_db;
create database lms_iron_db;
create database lms_iron_pricing_db;
create database lms_iron_discount_db;
create database lms_iron_tracking_db;
create database lms_dry_clean_db;
create database lms_dry_clean_pricing_db;
create database lms_dry_clean_discount_db;
create database lms_dry_clean_tracking_db;
create database lms_pickup_db;
create database lms_pickup_pricing_db;
create database lms_pickup_tracking_db;
create database lms_delivery_db;
create database lms_delivery_pricing_db;
create database lms_delivery_tracking_db;
create database lms_adjustment_db;
create database lms_order_db;
create database lms_transaction_db;



grant select, insert, update on lms_type_db.* to 'lms_type_manager'@'%';
grant select, insert, update on lms_tax_db.* to 'lms_tax_manager'@'%';
grant select, insert, update on lms_discount_db.* to 'lms_discount_manager'@'%';
grant select, insert, update on lms_clothing_db.* to 'lms_clothing_manager'@'%';
grant select, insert, update on lms_access_db.* to 'lms_access_manager'@'%';
grant select, insert, update on lms_user_db.* to 'lms_user_manager'@'%';
grant select, insert, update on lms_reset_db.* to 'lms_reset_manager'@'%';
grant select, insert, update on lms_customer_db.* to 'lms_customer_manager'@'%';
grant select, insert, update on lms_subscription_db.* to 'lms_subscription_manager'@'%';
grant select, insert, update on lms_employee_db.* to 'lms_employee_db'@'%';
grant select, insert, update on lms_agent_db.* to 'lms_agent_manager'@'%';
grant select, insert, update on lms_partner_db.* to 'lms_partner_manager'@'%';
grant select, insert, update on lms_consent_db.* to 'lms_consent_manager'@'%';
grant select, insert, update on lms_verification_db.* to 'lms_verification_manager'@'%';
grant select, insert, update on lms_wash_db.* to 'lms_wash_manager'@'%';
grant select, insert, update on lms_wash_pricing_db.* to 'lms_wash_pricing_manager'@'%';
grant select, insert, update on lms_wash_discount_db.* to 'lms_wash_discount_manager'@'%';
grant select, insert, update on lms_wash_tracking_db.* to 'lms_wash_tracking_manager'@'%';
grant select, insert, update on lms_iron_db.* to 'lms_iron_manager'@'%';
grant select, insert, update on lms_iron_pricing_db.* to 'lms_iron_pricing_manager'@'%';
grant select, insert, update on lms_iron_discount_db.* to 'lms_iron_discount_manager'@'%';
grant select, insert, update on lms_iron_tracking_db.* to 'lms_iron_tracking_manager'@'%';
grant select, insert, update on lms_dry_clean_db.* to 'lms_dry_clean_manager'@'%';
grant select, insert, update on lms_dry_clean_discount_db.* to 'lms_dry_clean_pricing_manager'@'%';
grant select, insert, update on lms_dry_clean_pricing_db.* to 'lms_dry_clean_discount_manager'@'%';
grant select, insert, update on lms_dry_clean_tracking_db.* to 'lms_dry_clean_tracking_manager'@'%';
grant select, insert, update on lms_pickup_db.* to 'lms_pickup_manager'@'%';
grant select, insert, update on lms_pickup_pricing_db.* to 'lms_pickup_pricing_manager'@'%';
grant select, insert, update on lms_pickup_tracking_db.* to 'lms_pickup_tracking_manager'@'%';
grant select, insert, update on lms_delivery_db.* to 'lms_delivery_manager'@'%';
grant select, insert, update on lms_delivery_pricing_db.* to 'lms_delivery_pricing_manager'@'%';
grant select, insert, update on lms_delivery_tracking_db.* to 'lms_delivery_tracking_manager'@'%';
grant select, insert, update on lms_adjustment_db.* to 'lms_adjustment_manager'@'%';
grant select, insert, update on lms_order_db.* to 'lms_order_manager'@'%';
grant select, insert, update on lms_transaction_db.* to 'lms_transaction_manager'@'%';



drop database lms_type_db;
drop database lms_tax_db;
drop database lms_discount_db;
drop database lms_clothing_db;
drop database lms_access_db;
drop database lms_user_db;
drop database lms_reset_db;
drop database lms_customer_db;
drop database lms_subscription_db;
drop database lms_employee_db;
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
drop database lms_pickup_db;
drop database lms_pickup_pricing_db;
drop database lms_pickup_tracking_db;
drop database lms_delivery_db;
drop database lms_delivery_pricing_db;
drop database lms_delivery_tracking_db;
drop database lms_adjustment_db;
drop database lms_order_db;
drop database lms_transaction_db;


drop user 'lms_access_manager'@'%';
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
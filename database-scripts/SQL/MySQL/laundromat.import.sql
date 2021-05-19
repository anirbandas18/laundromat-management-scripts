insert into laundromat_metadata_db.weight_type_lov (name, created_by) values ('LB', 1);
insert into laundromat_metadata_db.weight_type_lov (name, created_by) values ('KG', 1);
insert into laundromat_metadata_db.weight_type_lov (name, created_by) values ('N', 1);

insert into laundromat_metadata_db.currency_type_lov (name, created_by) values ('INR',  1);
insert into laundromat_metadata_db.currency_type_lov (name, created_by) values ('USD', 1);
insert into laundromat_metadata_db.currency_type_lov (name, created_by) values ('EUR', 1);

insert into laundromat_metadata_db.service_type_lov (name, description, created_by) values ('MACHINE WASH', 'AUTOMATED WASHING IN MACHINE', 1);
insert into laundromat_metadata_db.service_type_lov (name, description, created_by) values ('HAND WASHED', 'MANUALLY HAND WASHED SERVICE', 1);
insert into laundromat_metadata_db.service_type_lov (name, description, created_by) values ('IRONING', 'IRONING AND FOLDING SERVICE', 1);
insert into laundromat_metadata_db.service_type_lov (name, description, created_by) values ('DRY CLEAN', 'DRY CLEANING SERVICE', 1);
insert into laundromat_metadata_db.service_type_lov (name, description, created_by) values ('FOLDING', 'CLOTH FOLDING SERVICE', 1);

insert into laundromat_metadata_db.clothing_type_lov (name, description, created_by) values ('HOUSEHOLD', 'FURNITURE, ROOM BASED CLOTHES', 1);
insert into laundromat_metadata_db.clothing_type_lov (name, description, created_by) values ('GARMENT', 'HUMAN WEARABLE CLOTHES', 1);

insert into laundromat_metadata_db.clothing_item (clothing_type_lov_id, name, created_by) values (2, 'SHIRT', 1);
insert into laundromat_metadata_db.clothing_item (clothing_type_lov_id, name, created_by) values (2, 'PANT', 1);
insert into laundromat_metadata_db.clothing_item (clothing_type_lov_id, name, created_by) values (2, 'T-SHIRT', 1);
insert into laundromat_metadata_db.clothing_item (clothing_type_lov_id, name, created_by) values (2, 'SALWAR', 1);
insert into laundromat_metadata_db.clothing_item (clothing_type_lov_id, name, created_by) values (2, 'SAREE', 1);
insert into laundromat_metadata_db.clothing_item (clothing_type_lov_id, name, created_by) values (2, 'TOP', 1);
insert into laundromat_metadata_db.clothing_item (clothing_type_lov_id, name, created_by) values (2, 'HANDKERCEHEIF', 1);
insert into laundromat_metadata_db.clothing_item (clothing_type_lov_id, name, created_by) values (2, 'HALF-PANT', 1);
insert into laundromat_metadata_db.clothing_item (clothing_type_lov_id, name, created_by) values (1, 'CURTAIN', 1);
insert into laundromat_metadata_db.clothing_item (clothing_type_lov_id, name, created_by) values (1, 'PILLOW COVER', 1);
insert into laundromat_metadata_db.clothing_item (clothing_type_lov_id, name, created_by) values (1, 'TOWEL', 1);

insert into laundromat_wash_db.wash_load_type_lov (name, created_by) values ('WEIGHTED', 1);
insert into laundromat_wash_db.wash_load_type_lov (name, created_by) values ('INDIVIDUAL', 1);
insert into laundromat_wash_db.wash_load_type_lov (name, created_by) values ('PREMIUM', 1);

insert into laundromat_wash_db.washing_model (name, service_type_lov_id, wash_load_type_lov_id, created_by) values ('machine-weighted', 1, 1, 1);
insert into laundromat_wash_db.washing_model (name, service_type_lov_id, wash_load_type_lov_id, created_by) values ('machine-individual', 1, 2, 1);
insert into laundromat_wash_db.washing_model (name, service_type_lov_id, wash_load_type_lov_id, created_by) values ('hand-washed-individual', 2, 2, 1);

insert into laundromat_wash_db.washing_model_weighted (name, washing_model_id, clothing_type_lov_id, created_by) values ('machine-weighted-garments', 1, 1, 1);
insert into laundromat_wash_db.washing_model_weighted (name, washing_model_id, clothing_type_lov_id, created_by) values ('machine-weighted-household', 1, 1, 2);

insert into laundromat_wash_db.washing_model_individual (name, washing_model_id, clothing_item_id, created_by) values ('machine-individual-shirt', 2, 1, 1);
insert into laundromat_wash_db.washing_model_individual (name, washing_model_id, clothing_item_id, created_by) values ('machine-individual-towel', 2, 11, 1);
insert into laundromat_wash_db.washing_model_individual (name, washing_model_id, clothing_item_id, created_by) values ('hand-washed-individual-curtain', 2, 9, 1);
insert into laundromat_wash_db.washing_model_individual (name, washing_model_id, clothing_item_id, created_by) values ('hand-washed-individual-saree', 2, 5, 1);
insert into laundromat_wash_db.washing_model_individual (name, washing_model_id, clothing_item_id, created_by) values ('hand-washed-individual-pant', 2, 2, 1);

insert into laundromat_price_db.pricing_rule_weighted (name, washing_model_weighted_id, per_unit_weight, weight_unit, per_unit_price, price_currency, created_by) values ('machine-weighted-garments-kg-inr', 1, 1, 'KG', 50, 'INR', 1);
insert into laundromat_price_db.pricing_rule_weighted (name, washing_model_weighted_id, per_unit_weight, weight_unit, per_unit_price, price_currency, created_by) values ('machine-weighted-household-kg-inr', 2, 1, 'KG', 80, 'INR', 1);
insert into laundromat_price_db.pricing_rule_weighted (name, washing_model_weighted_id, per_unit_weight, weight_unit, per_unit_price, price_currency, created_by) values ('machine-weighted-garments-usd-inr', 1, 1, 'LB', 2.5, 'USD', 1);
insert into laundromat_price_db.pricing_rule_weighted (name, washing_model_weighted_id, per_unit_weight, weight_unit, per_unit_price, price_currency, created_by) values ('machine-weighted-household-usd-inr', 2, 1, 'LB', 4, 'USD', 1);

insert into laundromat_price_db.pricing_rule_individual (name, washing_model_individual_id, per_unit_count, per_unit_price, price_currency, created_by) values ('machine-individual-N-shirt-inr', 1, 1, 10, 'INR', 1);
insert into laundromat_price_db.pricing_rule_individual (name, washing_model_individual_id, per_unit_count, per_unit_price, price_currency, created_by) values ('machine-individual-N-towel-inr', 2, 1, 17, 'INR', 1);
insert into laundromat_price_db.pricing_rule_individual (name, washing_model_individual_id, per_unit_count, per_unit_price, price_currency, created_by) values ('hand-washed-individual-N-saree-inr', 4, 1, 25, 'INR', 1);
insert into laundromat_price_db.pricing_rule_individual (name, washing_model_individual_id, per_unit_count, per_unit_price, price_currency, created_by) values ('hand-washed-individual-N-curtain-inr', 3, 1, 40, 'INR', 1);
insert into laundromat_price_db.pricing_rule_individual (name, washing_model_individual_id, per_unit_count, per_unit_price, price_currency, created_by) values ('machine-individual-N-shirt-inr', 1, 1, 0.4, 'USD', 1);
insert into laundromat_price_db.pricing_rule_individual (name, washing_model_individual_id, per_unit_count, per_unit_price, price_currency, created_by) values ('machine-individual-N-towel-inr', 2, 1, 0.6, 'USD', 1);
insert into laundromat_price_db.pricing_rule_individual (name, washing_model_individual_id, per_unit_count, per_unit_price, price_currency, created_by) values ('hand-washed-individual-N-saree-inr', 4, 1, 1, 'USD', 1);
insert into laundromat_price_db.pricing_rule_individual (name, washing_model_individual_id, per_unit_count, per_unit_price, price_currency, created_by) values ('hand-washed-individual-N-curtain-inr', 3, 1, 1.25, 'USD', 1);

const String TABLE_SOUNDING = "table_sounding";
const String TABLE_QUALITY = "table_quality";
const String TABLE_QUALITY_DOC = "table_quality_doc";
const String TABLE_KERNEL = "table_kernel";
const String TABLE_BULK_SILO = "table_bulk_silo";
const String TABLE_SOUNDING_CPO = "table_sounding_cpo";
const String TABLE_STORAGE_TANK = "table_storage_tank";
const String TABLE_MILL = "table_mill";
const String TABLE_USER = "table_user";
const String TABLE_VERIFIER = "table_verifier";

/*TABLE SOUNDING*/
const String ID_SOUNDING = "number";
const String DATE_SOUNDING = "tr_time";
const String TOTAL_STOCK_SOUNDING = "total_stock";
const String ADDITIONAL_SOUNDING = "additional";
const String CREATED_BY_SOUNDING = "created_by";
const String NOTE_SOUNDING = "note";
const String CLARIFIER_PURE_OIL = "clarifier_pure_oil";
const String CLARIFIER_TANK_1 = "clarifier_tank_1";
const String CLARIFIER_TANK_2 = "clarifier_tank_2";
const String PRODUCTION_SOUNDING = "production";
const String SOUNDING_SENT = "sounding_sent";

/*TABLE SOUNDING CPO*/
const String ID_TANK = "number";
const String ID_SOUNDING_TANK = "id_sounding_tank";
const String SIZE_SOUNDING_TANK = "size";
const String DATE_SOUNDING_TANK = "tr_time";
const String SOUNDING_FIRST = "sounding_1";
const String SOUNDING_SECOND = "sounding_2";
const String SOUNDING_THIRD = "sounding_3";
const String SOUNDING_FOURTH = "sounding_4";
const String SOUNDING_FIFTH = "sounding_5";
const String SOUNDING_MAX = "max_sounding";
const String SOUNDING_AVERAGE = "avg_sounding";
const String SOUNDING_M_TANK_ID = "m_storage_tank_id";
const String SOUNDING_M_TANK_CODE = "m_storage_tank_code";
const String SOUNDING_TEMPERATURE = "temperature";
const String SOUNDING_VOLUME_CM = "volume_cm";
const String SOUNDING_VOLUME_MM = "volume_mm";
const String SOUNDING_TOTAL_VOLUME = "total_volume";
const String SOUNDING_ROUNDING_VOLUME = "rounding_volume";
const String SOUNDING_CONST_EXPAND = "constanta_expansion";
const String SOUNDING_HIGH_TABLE = "high_table";
const String SOUNDING_DENSITY = "density";
const String SOUNDING_IS_MANUAL = "is_manual";
const String SOUNDING_USING_COPY_DATA = "using_copy_data";
const String SOUNDING_WEIGHT_STORAGE = "weight_storage";
const String SOUNDING_CPO_CREATED_BY = "created_by";
const String SOUNDING_ROUNDING_TONNAGE = "rounding_tonnage";

/*TABLE QUALITY DOC*/
const String ID_QUALITY_DOC = "number";
const String DATE_QUALITY_DOC = "tr_time";
const String QUALITY_SENT_DOC = "sent";
const String CREATED_BY_QUALITY_DOC = "created_by";

/*TABLE QUALITY CHECK*/
const String ID_QUALITY = "number";
const String ID_QUALITY_DOC_CHECK = "id_quality_doc";
const String M_PRODUCT_ID_QUALITY = "m_product_id";
const String M_PRODUCT_CODE_QUALITY = "m_product_code";
const String DATE_QUALITY = "tr_time";
const String FFA_QUALITY = "ffa";
const String MOIST_QUALITY = "moist";
const String DIRT_QUALITY = "dirt";
const String DOBI_QUALITY = "dobi";
const String B_QUALITY_KERNEL = "broken_kernel";
const String QUALITY_CREATED_BY = "created_by";

/*TABLE BULK SILO*/
const String ID_KERNEL = "id_kernel";
const String DATE_KERNEL = "date_kernel";
const String BULK_SILO_ONE = "bulk_silo_one";
const String BULK_SILO_TWO = "bulk_silo_two";
const String BULK_SILO_THREE = "bulk_silo_three";
const String BULK_SILO_FOUR = "bulk_silo_four";
const String KERNEL_SENT = "kernel_sent";
const String KERNEL_CREATED_BY = "created_by";

/*TABLE MILL*/
const String ID_MILL = "id";
const String NAME_MILL = "name";
const String CODE_MILL = "code";
const String ADDRESS_MILL = "address";
const String M_COMPANY_ID = "m_company_id";
const String MAX_SOUNDING = "total_sample_sounding_cpo";
const String TOTAL_QUALITY = "total_sample_quality";
const String LABEL_QUALITY = "label_sample_quality";
const String TOTAL_SOUNDING_KERNEL = "total_sample_sounding_kernel";

/*STORAGE TANK*/
const String ID_STORAGE_TANK = 'id';
const String CODE_STORAGE_TANK = 'code';
const String NAME_STORAGE_TANK = 'name';
const String CAPACITY = 'capacity';
const String SURFACE_PLATE = 'surface_plate';
const String STANDARD_TEMPERATURE = 'standard_temperature';
const String HEIGHT_TANK = 'height';
const String DENSITY = 'density_cpo';
const String RING = 'ring';
const String EXPANSION_COEFFICIENT = 'expansion_coefficient';
const String MILL_ID_STORAGE_TANK = 'm_mill_id';
const String CREATED_BY_STORAGE_TANK = 'created_by';
const String CREATED_AT_STORAGE_TANK = 'created_at';

/*TABLE USER*/
const String ID_USER = "id";
const String NAME_USER = "name";
const String EMAIL_USER = "email";
const String ROLE_USER = "m_role_id";
const String USERNAME_USER = "username";
const String ADDRESS = "address";
const String GENDER = "gender";
const String TOKEN = "token";
const String MILL_ID = "m_mill_id";
const String COMPANY_NAME = "company_name";
const String COMPANY_ID_USER = "m_company_id";
const String SEQUENCE_NUMBER = "sequence_number";
const String PHONE_NUMBER = "phone_number";
const String PROFILE_PICTURE = "profile_picture";

/*TABLE VERIFIER*/
const String ID_VERIFIER = "m_user_id";
const String ID_FORM = "id_form";
const String NAME_VERIFIER = "name";
const String LEVEL_LABEL = "level_label";
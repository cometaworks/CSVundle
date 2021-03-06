require 'spec_helper'

describe CSVundle::AccessCSV do
  context "Generic parent CSV class" do
    let(:csv) { CSVundle::AccessCSV.new(:lienalytics) }

    it "has rows, columns and column values" do
      expect(csv.columns.sort).to eq csv.setup_data['headers'].keys.sort
      expect(csv.column_values).to eq(csv.setup_data['headers'].values)
      expect(csv.rows).to eq [[]] # lienalytics has a filler row
    end

    it "has headers" do
      expect(csv.headers).to eq csv.setup_data['headers']
    end

    it "can viperize (convert to snakecase) a given symbol" do
      expect(csv.viperize(:PrimaryKey)).to eq :primary_key
    end

    it "can normalize columns to ruby guidelines" do
      csv.columns = ["lien_ID", "AccessPants"]
      expect(csv.normalized_columns).to eq [:lien_id, :access_pants]
    end
  end

  context "Access CSV generation" do
    let(:access_csv) { CSVundle::AccessCSV.new(:lienalytics) }
    let(:bloxtrade_csv) { CSVundle::AccessCSV.new(:blox_trade) }

    it "does a thing" do
      mapped_data = []
      final_csv = access_csv.serve([[1],[2],[3],[4]])
      downloaded_date = Date.today
      expect(final_csv).to eq "Lienalytics Custom List,Downloaded On #{downloaded_date}\n\nlien_ID,row_number,state_name,county_name,full_fips_code,apn,parcel_id,block,lot,qualifier,addl_lots,tax_type,list_item_reference,client_provided_parcel_id,certificate_no,face_value,redemptive_value,principal,tax_year,total_yearly_tax,location_street_address_1,location_street_address_2,location_city_state_zip,location_city,location_zip,longitude,latitude,county_land_use,county_land_use_desc,standardized_land_use,standardized_land_use_desc,county_held,prop_record_year,lien_rollup,location_house_number,location_street_dir_left,location_street_name,location_street_suffix,location_street_dir_right,location_unit_number,legal_status,interest_rate,penalty_rate,penalty_amount,premium_overbid,overbid_interest_rate,original_sale_auction_date,date_purchased_from_issuer,issuer,sub,assessment_year,assessed_land_value,assessed_improvement_value,total_assessed_value,market_value_year,market_land_value,market_improvement_value,total_market_value,lot_frontage,lot_depth,lot_size_unit,zoning,building_class,year_built,no_of_stories,no_of_units,last_sale_date,last_sale_price,last_arms_length_sale_date,last_arms_length_sale_price,prior_arms_length_sale_date,prior_arms_length_sale_price,legal_city,legal_block,legal_lot_number,legal_section,legal_district,legal_unit,legal_subdivision_name,legal_phase_number,legal_tract_number,legal_section_township_range_meridian,legal_assessors_map_ref,legal_brief_desc,current_owner,mailing_care_of,mailing_street_address,mailing_city_state,mailing_zip,owner_occupied,loan1_contract_date,loan1_recording_date,loan1_amount,loan1_due_date,loan1_type,loan2_contract_date,loan2_recording_date,loan2_amount,loan2_due_date,loan2_type,municipality,tags,bids,notes,photos,surveys,additional_csv_data\n1\n2\n3\n4\n"
    end

    it "supports Bloxtrade format" do
      mapped_data = []
      final_csv = bloxtrade_csv.serve([[1],[2],[3],[4]])
      downloaded_date = Date.today
      expect(final_csv).to eq "Bloxtrade Custom List,Downloaded On #{downloaded_date}\n\n\n\n\n\n\nSORT_NO,LIST_ITEM_ID,STATE,COUNTY,MUNICIPALITY,FULL_FIPS_CODE,PARCEL_ID,LIST_BATCH_NO,LIST_ITEM_REF,AMOUNT,LIST_ITEM_TYPE,LIST_NOTE_1,LIST_NOTE_2,LIST_NOTE_3,LIST_NOTE_4,LOCATION_FULL_STREET_ADDRESS,LOCATION_CITY_STATE_ZIP,ASSESSMENT_YEAR,ASSESSED_LAND_VALUE,ASSESSED_IMPROVEMENT_VALUE,TOTAL_ASSESSED_VALUE,MARKET_VALUE_YEAR,MARKET_LAND_VALUE,MARKET_IMPROVEMENT_VALUE,TOTAL_MARKET_VALUE,TAX_YEAR,TAX_AMOUNT,COUNTY_LAND_USE,COUNTY_LAND_USE_DESC,STANDARDIZED_LAND_USE,STANDARDIZED_LAND_USE_DESC,CURRENT_OWNER,MAILING_CARE_OF,MAILING_STREET_ADDRESS,MAILING_CITY_STATE,MAIL_ZIP_4,OWNER_OCCUPIED,APN,TAX_ID,ID_1,ID_2,ID_3,ID_4,ID_5,ID_6,ID_7,ID_8,ID_9,ID_10,LOCATION_HOUSE_NUMBER,LOCATION_STREET_DIR_LEFT,LOCATION_STREET_NAME,LOCATION_STREET_SUFFIX,LOCATION_STREET_DIR_RIGHT,LOCATION_UNIT_NUMBER,LOCATION_CITY,LOCATION_STATE,LOCATION_ZIP_4,LONGITUDE,LATITUDE,LOT_FRONTAGE,LOT_DEPTH,LOT_SIZE,LOT_SIZE_UNIT,ZONING,BUILDING_CLASS,YEAR_BUILT,NO_OF_STORIES,NO_OF_UNITS,LATEST_SALE_DATE,LATEST_SALE_PRICE,LATEST_ARMS_LENGTH_SALE_DATE,LATEST_ARMS_LENGTH_SALE_PRICE,PRIOR_ARMS_LENGTH_SALE_DATE,PRIOR_ARMS_LENGTH_SALE_PRICE,LOAN1_CONTRACT_DATE,LOAN1_RECORDING_DATE,LOAN1_AMOUNT,LOAN1_DUE_DATE,LOAN1_TYPE,LOAN2_CONTRACT_DATE,LOAN2_RECORDING_DATE,LOAN2_AMOUNT,LOAN2_DUE_DATE,LOAN2_TYPE,LEGAL_CITY,LEGAL_BLOCK,LEGAL_LOT_NUMBER,LEGAL_SECTION,LEGAL_DISTRICT,LEGAL_UNIT,LEGAL_SUBDIVISION_NAME,LEGAL_PHASE_NUMBER,LEGAL_TRACT_NUMBER,LEGAL_SECTION_TOWNSHIP_RANGE_MERIDIAN,LEGAL_ASSESSORS_MAP_REF,LEGAL_BRIEF_DESC,INSPECT_URL,LIEN_CERTIFICATE,CLIENT_PARCEL_CERTIFICATE_NUMBER,LEGAL_STATUS,PENALTY_RATE,PENALTY_AMOUNT,PREMIUM_OVERBID,TOTAL_RECOVERABLE_FEES,LIEN_TAX_YEAR,ORIGINAL_SALE_AUCTION_DATE,DATE_PURCHASED_FROM_ISSUER,ISSUER,LIEN_FACE_VALUE,INTEREST_RATE,DAYS_OUTSTANDING,MONTHS_OUTSTANDING,PERIODS_OUTSTANDING,ACCRUED_INTEREST,REDEMPTIVE_VALUE_DATE,REDEMPTIVE_VALUE,RV_ASSESSED,LIEN_SUB,COMBINED_RV,TDA_DATE,TDA_MONTHS_OUTSTANDING,NOTES,AMOUNT_TO_REDEEM,ROLL_UP,DEED_CERTIFIED_DATE,DEED_SALE_DATE,TDA_APPLICATION_NUMBER,OPTIONAL_FIELD_1,OPTIONAL_FIELD_2,OPTIONAL_FIELD_3,OPTIONAL_FIELD_4,OPTIONAL_FIELD_5,OPTIONAL_FIELD_6,OPTIONAL_FIELD_7,OPTIONAL_FIELD_8,OPTIONAL_FIELD_9,OPTIONAL_FIELD_10\n1\n2\n3\n4\n"
    end
  end
end

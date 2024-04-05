# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_12_13_181101) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "campaign_requests", force: :cascade do |t|
    t.string "description"
    t.integer "status", default: 0
    t.bigint "org_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.index ["org_id"], name: "index_campaign_requests_on_org_id"
  end

  create_table "campaigns", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.integer "shopify_product_id"
    t.integer "donorbox_campaign_id"
    t.integer "donorbox_campaign_url"
    t.bigint "org_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "goal_amount", default: 0
    t.index ["org_id"], name: "index_campaigns_on_org_id"
  end

  create_table "donations", force: :cascade do |t|
    t.integer "action", default: 0
    t.string "amount", default: "0.0"
    t.string "formatted_amount"
    t.string "converted_amount"
    t.string "formatted_converted_amount"
    t.string "converted_net_amount"
    t.string "formatted_converted_net_amount"
    t.boolean "recurring", default: false
    t.boolean "first_recurring_donation", default: false
    t.string "amount_refunded"
    t.string "formatted_amount_refunded"
    t.string "stripe_charge_id"
    t.integer "donorbox_id"
    t.integer "status", default: 0
    t.string "donation_type"
    t.datetime "donation_date"
    t.boolean "anonymous_donation"
    t.boolean "gift_aid"
    t.string "designation"
    t.boolean "join_mailing_list"
    t.string "comment"
    t.string "donating_company"
    t.string "currency", default: "USD"
    t.string "converted_currency", default: "USD"
    t.boolean "offline", default: false
    t.string "utm_campaign"
    t.string "utm_source"
    t.string "utm_medium"
    t.string "utm_term"
    t.string "utm_content"
    t.float "processing_fee"
    t.string "formatted_processing_fee"
    t.boolean "fee_covered"
    t.float "app_fee"
    t.string "formatted_app_fee"
    t.float "converted_app_fee"
    t.string "formatted_converted_app_fee"
    t.text "questions", default: [], array: true
    t.bigint "campaign_id"
    t.bigint "donor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "donorbox_webhook_id"
    t.index ["campaign_id"], name: "index_donations_on_campaign_id"
    t.index ["donor_id"], name: "index_donations_on_donor_id"
    t.index ["donorbox_webhook_id"], name: "index_donations_on_donorbox_webhook_id"
  end

  create_table "donorbox_webhooks", force: :cascade do |t|
    t.string "event_name"
    t.json "payload"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "donors", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", default: ""
    t.string "first_name", default: ""
    t.string "last_name", default: ""
    t.string "phone", default: ""
    t.string "address", default: ""
    t.string "address_line_2", default: ""
    t.string "city", default: ""
    t.string "state", default: ""
    t.string "zip_code", default: ""
    t.string "country", default: ""
    t.string "occupation", default: ""
    t.integer "donorbox_id"
    t.index ["email"], name: "index_donors_on_email", unique: true
    t.index ["reset_password_token"], name: "index_donors_on_reset_password_token", unique: true
  end

  create_table "email_templates", force: :cascade do |t|
    t.bigint "org_id"
    t.string "title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["org_id"], name: "index_email_templates_on_org_id"
  end

  create_table "orgs", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", default: ""
    t.bigint "shopify_collection_id"
    t.index ["email"], name: "index_orgs_on_email", unique: true
    t.index ["reset_password_token"], name: "index_orgs_on_reset_password_token", unique: true
  end

  create_table "requests", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "address1", default: "", null: false
    t.string "city", default: "", null: false
    t.string "state", default: "", null: false
    t.string "country", default: "", null: false
    t.string "zip", default: "", null: false
    t.string "ein"
    t.string "mission"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
    t.string "address2"
    t.binary "logo"
    t.string "email", default: "", null: false
    t.string "phone", default: ""
    t.string "contact", default: ""
    t.string "password_digest"
  end

  create_table "templates", force: :cascade do |t|
    t.bigint "shopify_collection_id", null: false
    t.string "title", default: "", null: false
    t.text "content", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "update_campaign_requests", force: :cascade do |t|
    t.string "description"
    t.integer "status", default: 0
    t.bigint "campaign_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["campaign_id"], name: "index_update_campaign_requests_on_campaign_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
end

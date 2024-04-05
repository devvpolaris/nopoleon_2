# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
non_profits = [
  {
    name: '4 Dogs Farm Rescue',
    shopify_collection_id: 448889323821,
    email: '4dogsfarmrescue@gmail.com',
    campaigns: [
      {
        name: '4 Dogs Farm Rescue',
        type: 0,
        donorbox_campaign_id: 466542,
        donorbox_campaign_url: '4-dogs-farm-rescue-1',
      }
    ]
  },
  {
    name: 'Almost Eden Rescue',
    shopify_collection_id: 451605823789,
    email: 'info@almostedenrescue.com',
    campaigns: [
      {
        name: 'Almost Eden Rescue',
        type: 0,
        donorbox_campaign_id: 473704,
        donorbox_campaign_url: 'almost-eden-rescue-1',
      }
    ]
  },
  {
    name: 'American Cairo Animal Rescue Foundation',
    shopify_collection_id: 451898966317,
    email: 'vickimbrown2017@gmail.com',
    campaigns: [
      {
        name: 'American Cairo Animal Rescue Foundation',
        type: 0,
        donorbox_campaign_id: 473926,
        donorbox_campaign_url: 'american-cairo-animal-rescue-foundation',
      }
    ]
  },
  {
    name: 'Animal Party Rescue',
    shopify_collection_id: 451895165229,
    email: 'jescolon917@hotmail.com',
    campaigns: [
      {
        name: 'Animal Party Rescue',
        type: 0,
        donorbox_campaign_id: 473918,
        donorbox_campaign_url: 'animal-party-rescue',
      }
    ]
  },
  {
    name: 'Bark Rescue CA',
    shopify_collection_id: 451606118701,
    email: 'lusiana.hadi@barkrescueca.org',
    campaigns: [
      {
        name: 'Bark Rescue CA',
        type: 0,
        donorbox_campaign_id: 473911,
        donorbox_campaign_url: 'bark-rescue-ca-1',
      }
    ]
  },
  {
    name: 'Black Cat Holistic Rescue Inc',
    shopify_collection_id: 451894608173,
    email: 'blackcatholisticrescue@gmail.com',
    campaigns: [
      {
        name: 'Black Cat Holistic Rescue Inc',
        type: 0,
        donorbox_campaign_id: 473913,
        donorbox_campaign_url: 'black-cat-holistic-rescue-inc',
      }
    ]
  },
  {
    name: 'Cantu Foundation',
    shopify_collection_id: 451895394605,
    email: 'thecantufoundation@gmail.com',
    campaigns: [
      {
        name: 'Cantu Foundation',
        type: 0,
        donorbox_campaign_id: 473921,
        donorbox_campaign_url: 'cantu-foundation',
      }
    ]
  },
  {
    name: 'Fur & Feather',
    shopify_collection_id: 451895525677,
    email: 'info@furfeather.org',
    campaigns: [
      {
        name: 'Fur & Feather',
        type: 0,
        donorbox_campaign_id: 473923,
        donorbox_campaign_url: 'fur-feather',
      }
    ]
  },
  {
    name: 'Hooks Home Bound Rescue',
    shopify_collection_id: 451606380845,
    email: 'contact@hhbrescue.com',
    campaigns: [
      {
        name: 'Hooks Home Bound Rescue inc',
        type: 0,
        donorbox_campaign_id: 473908,
        donorbox_campaign_url: 'hooks-home-bound-rescue-inc-1',
      }
    ]
  },
  {
    name: 'Hueys Rescue',
    shopify_collection_id: 451606446381,
    email: 'hueysrescue@gmail.com',
    campaigns: [
      {
        name: 'Hueys Rescue',
        type: 0,
        donorbox_campaign_id: 473906,
        donorbox_campaign_url: 'huey-s-rescue',
      }
    ]
  },
  {
    name: 'Locks 4 Paws',
    shopify_collection_id: 451895755053,
    email: 'info@locks4paws.org',
    campaigns: [
      {
        name: 'Locks 4 Paws',
        type: 0,
        donorbox_campaign_id: 473924,
        donorbox_campaign_url: 'locks-4-paws',
      }
    ]
  },
  {
    name: 'Match Made in Heaven Animal Rescue',
    shopify_collection_id: 451606577453,
    email: 'matchmadeinheavenrescue@gmail.com',
    campaigns: [
      {
        name: 'Match Made in Heaven Animal Rescue',
        type: 0,
        donorbox_campaign_id: 473912,
        donorbox_campaign_url: 'match-made-in-heaven-animal-rescue',
      }
    ]
  },
  {
    name: 'Northern California Sled Dog Rescue',
    shopify_collection_id: 451894903085,
    email: 'rescue@norsled.org',
    campaigns: [
      {
        name: 'Northern California Sled Dog Rescue',
        type: 0,
        donorbox_campaign_id: 473915,
        donorbox_campaign_url: 'northern-california-sled-dog-rescue',
      }
    ]
  },
  {
    name: 'Viva Rescue Inc',
    shopify_collection_id: 451606905133,
    email: 'vivaglobalrescue@gmail.com',
    campaigns: [
      {
        name: 'Viva Rescue Inc',
        type: 0,
        donorbox_campaign_id: 473907,
        donorbox_campaign_url: 'viva-rescue-inc-1',
      }
    ]
  },
  {
    name: 'Pet Star',
    shopify_collection_id: 457601417517,
    email: 'petstar@gmail.com',
    campaigns: [
      {
        name: 'Pet Star',
        type: 0,
        donorbox_campaign_id: 488357,
        donorbox_campaign_url: 'pet-star',
      }
    ]
  },
  {
    name: 'SPA Non Profit',
    shopify_collection_id: 465906565421,
    email: 'test@sponsorapet.org',
    campaigns: [
      {
        name: 'SPA Non Profit',
        type: 0,
        donorbox_campaign_id: 539127,
        donorbox_campaign_url: 'spa-non-profit',
      },
      {
        name: 'SPA Max',
        type: 0,
        donorbox_campaign_id: 539133,
        donorbox_campaign_url: 'spa-max',
        shopify_product_id: 9062159974701,
      }
    ]
  },
]

# Donation.destroy_all
# Donor.destroy_all
# Org.destroy_all

non_profits.each do |non_profit|
  org = Org.find_by(email: non_profit[:email])

  if org.present?
    puts "Org #{non_profit[:email]} already exists!"
  else
    org = Org.find_or_create_by(email: non_profit[:email], name: non_profit[:name], shopify_collection_id: non_profit[:shopify_collection_id])
    org.password = '#$taawktljasktlw4aaglj'
    org.save!

    if org.id
      non_profit[:campaigns].each do |campaign|
        campaign = org.campaigns.find_or_create_by(
          name: campaign[:name],
          goal: 'general',
          donorbox_campaign_id: campaign[:donorbox_campaign_id],
          donorbox_campaign_url: campaign[:donorbox_campaign_url]
        )
        campaign.save!
      end
    end
    puts "Org #{non_profit[:name]} has been created!"
  end
end

non_profits.each do |non_profit|
  org = Org.find_or_create_by(email: non_profit[:email], name: non_profit[:name], shopify_collection_id: non_profit[:shopify_collection_id])
  org.password = '#$taawktljasktlw4aaglj'
  org.save!
  if org.id
    non_profit[:campaigns].each do |campaign|
      campaign = org.campaigns.find_or_create_by(
        name: campaign[:name],
        goal: 'general',
        donorbox_campaign_id: campaign[:donorbox_campaign_id],
        donorbox_campaign_url: campaign[:donorbox_campaign_url]
      )
      campaign.save!
    end
  end
end

# admins = [
#   {
#     email: 'andylee.dreamsoft@gmail.com',
#     password: '#$taawktljasktlw4aaglj'
#   },
#   {
#     email: 'lrrxng@gmail.com',
#     password: '#$taawktljasktlw4aaglj'
#   },
#   {
#     email: 'jamescalison428@gmail.com',
#     password: '#$taawktljasktlw4aaglj'
#   },
#   {
#     email: 'sdefries@sponsorapet.org',
#     password: '#$taawktljasktlw4aaglj'
#   },
#   {
#     email: 'lrrxng@gmail.com',
#     password: '#$taawktljasktlw4aaglj'
#   }
# ]
# 
# admins.each do |admin|
#   User.find_or_create_by(email: admin[:email]) do |user|
#     user.password = admin[:password]
#   end
# end

# active_ids = []

# Request.all.each do |request|
#   request.destroy! unless active_ids.include? request.id
# end

# Add email templates
# templates = [
#   {
#     title: "Campaign Launch: Introducing a New Animal in Need",
#     content: "<div>Subject: Meet [Animal's Name] – Our Newest Rescue in Need of Your Support&nbsp;<br><br>Dear [Donor's Name],&nbsp;<br><br>We hope this email finds you well. Today, we introduce you to [Animal's Name], a [brief description of the animal and its situation, e.g., &quot;young puppy who was found abandoned and injured&quot;].&nbsp;<br><br>[Animal's Name] desperately needs [specific care or treatment, e.g., &quot;urgent medical attention for a broken leg and rehabilitation support&quot;]. But with your generosity, we can change [his/her] story.&nbsp;<br><br>[Link: Learn more about [Animal's Name] and donate]&nbsp;<br><br>Together, we can make a difference in [Animal's Name]'s life. Thank you for being a beacon of hope.&nbsp;<br><br>Warmly, [Your Organization's Name]&nbsp;</div>"
#   },
#   {
#     title: "Mid-Campaign Update: Progress and Continued Need ",
#     content: "<div>Subject: Update on [Animal's Name] – We're Making Progress!&nbsp;<br><br>Dear [Donor's Name],&nbsp;<br><br>Thanks to supporters like you, we've managed to raise [amount raised so far] for [Animal's Name]! We are [percentage towards goal]% towards our goal.&nbsp;<br><br>While [Animal's Name] is showing signs of improvement, we still have a journey ahead of us. [Update on animal's condition, e.g., &quot;The surgery was successful, but the rehabilitation process is crucial.&quot;]&nbsp;<br><br>[Link: See photos and latest updates on [Animal's Name]]&nbsp;<br><br>Please consider sharing [Animal's Name]'s story with friends and family. Every share brings us closer to our goal.&nbsp;<br><br>Gratefully, [Your Organization's Name]&nbsp;</div>"
#   },
#   {
#     title: "Urgent Push: Final Days of Campaign",
#     content: "<div>Subject: Final Days to Support [Animal's Name] – Let's Reach Our Goal!&nbsp;<br><br>Dear [Donor's Name],&nbsp;<br><br>Time is running out, and we're so close to reaching our goal for [Animal's Name]. We are just [amount left to raise] away!&nbsp;<br><br>Your continued support can make all the difference. Whether it's a small donation or simply sharing the campaign with others, every bit helps.&nbsp;<br><br>[Link: Donate and share [Animal's Name]'s story]&nbsp;<br><br>Together, we can give [Animal's Name] the future [he/she] deserves.&nbsp;<br><br>With hope, [Your Organization's Name]&nbsp;</div>"
#   },
#   {
#     title: "Campaign Success: Thank You and Celebrating Achievements",
#     content: "<div>Subject: We Did It! [Animal's Name]'s Journey to Recovery&nbsp;<br><br>Dear [Donor's Name],&nbsp;<br><br>Thanks to your incredible support, we've reached our goal for [Animal's Name]! Your generosity has directly impacted [Animal's Name]'s recovery and future.&nbsp;<br><br>[Link: View [Animal's Name]'s journey and thank you video]&nbsp;<br><br>Stay tuned for more updates as [Animal's Name] embarks on this new chapter. You've truly made a difference.&nbsp;<br><br>With immense gratitude, [Your Organization's Name]&nbsp;</div>"
#   },
#   {
#     title: "Success Story Follow-Up: Sharing the Impact ",
#     content: "<div>Subject: Look at [Animal's Name] Now – A Success Story Thanks to You!&nbsp;<br><br>Dear [Donor's Name],&nbsp;<br><br>Remember [Animal's Name], whom you so generously supported a few months ago? We're thrilled to share [his/her] latest update.&nbsp;<br><br>[Update on animal's condition, e.g., &quot;With a healed leg and a loving forever home, [Animal's Name] is thriving like never before.&quot;]&nbsp;<br><br>[Link: View photos and a heartwarming video of [Animal's Name]]&nbsp;<br><br>Your support has truly transformed a life. Thank you for being a part of this beautiful journey.&nbsp;<br><br>Warmly, [Your Organization's Name]&nbsp;</div>"
#   }
# ]
# 
# templates.each do |template|
#   Org.first.email_templates.create(template)
#   puts "Template #{template[:title]} has been created successfully!"
# end

# Create campaigns for animals

# org = Org.find(1)
# 
# percy = org.campaigns.create!(
#   name: 'Northern California Sled Dog Rescue',
#   goal: 'animal',
#   donorbox_campaign_id: 528347,
#   donorbox_campaign_url: 'percy',
#   shopify_product_id: 8419504652589,
# )

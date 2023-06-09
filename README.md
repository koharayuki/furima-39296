# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...



# furima-39296のER図

## usersテーブル

|  Column            |  Type      |  Options                       |
| ------------------ | ---------- | ------------------------------ |
| nickname           | string     | null: false                    |
| email              | string     | null: false, unique: true      |
| encrypted_password | string     | null: false                    |
| last_name          | string     | null: false                    |
| first_name         | string     | null: false                    |
| suv_last_name      | string     | null: false                    |
| suv_first_name     | string     | null: false                    |
| date_of_birth      | date       | null: false                    |


### Association

- has_many :items
- has_many :orders


## itemsテーブル

|  Column            |  Type      |  Options                       |
| ------------------ | ---------- | ------------------------------ |
| title              | string     | null: false                    |
| content            | text       | null: false                    |
| category_id        | integer    | null: false                    |
| status_id          | integer    | null: false                    |
| delivery_charge_id | integer    | null: false                    |
| shipping_origin_id | integer    | null: false                    |
| date_of_shipment_id| integer    | null: false                    |
| price              | integer    | null: false                    |
| user               | references | null: false, foreign_key: true |

### Association

- has_one :order
- belongs_to :user



## ordersテーブル

|  Column            |  Type      |  Options                       |
| ------------------ | ---------- | ------------------------------ |
| item               | references | null: false, foreign_key: true |
| user               | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :delivery


## deliveriesテーブル

|  Column            |  Type      |  Options                       |
| ------------------ | ---------- | ------------------------------ |
| post_code          | string     | null: false                    |
| shipping_origin_id | integer    | null: false                    |
| city               | string     | null: false                    |
| brock              | string     | null: false                    |
| building           | string     |                                |
| phone_number       | string     | null: false                    |
| order              | references | null: false, foreign_key: true |

### Association

- belongs_to :order
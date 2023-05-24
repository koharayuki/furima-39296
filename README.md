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
| nickname           | string     | null: false,                   |
| email              | string     | null: false, unique            |
| encrypted_password | string     | null: false                    |
| last_name          | string     | null: false                    |
| first_name         | string     | null: false                    |
| suv_last_name      | string     | null: false                    |
| suv_first_name     | string     | null: false                    |
| date_of_birth      | string     | null: false                    |


### Association

- has_many :items
- has_many :orders
- has_one :deliveries



## itemsテーブル

|  Column            |  Type      |  Options                       |
| ------------------ | ---------- | ------------------------------ |
| title              | string     | null: false                    |
| text               | text       | null: false                    |
| category           | text       | null: false                    |
| status             | text       | null: false                    |
| price              | text       | null: false                    |
| user               | references | null: false, foreign_key: true |

### Association

- has_many :comments
- belongs_to :user


## commentsテーブル

|  Column            |  Type      |  Options                       |
| ------------------ | ---------- | ------------------------------ |
| content            | text       | null: false                    |
| user               | references | null: false, foreign_key: true |
| order              | references | null: false, foreign_key: true |

### Association

- belongs_to :item
- belongs_to :user


## ordersテーブル

|  Column            |  Type      |  Options                       |
| ------------------ | ---------- | ------------------------------ |
| credit_card        | text       | null: false                    |
| user               | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :deliveries


## deliveriesテーブル

|  Column            |  Type      |  Options                       |
| ------------------ | ---------- | ------------------------------ |
| date_of_shipment   | string     | null: false                    |
| delivery_charge    | text       | null: false                    |
| region             | string     | null: false                    |
| user               | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :order
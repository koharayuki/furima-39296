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
| email              | string     | null: false, unique: true      |
| encrypted_password | string     | null: false                    |
| last_name          | string     | null: false                    |
| first_name         | string     | null: false                    |
| suv_last_name      | string     | null: false                    |
| suv_first_name     | string     | null: false                    |
| date_of_birth      | date       | null: false                    |


### Association

- has_many :items
- has_one :deliveries


## itemsテーブル

|  Column            |  Type      |  Options                       |
| ------------------ | ---------- | ------------------------------ |
| name               | string     | null: false                    |
| title              | string     | null: false                    |
| saller             | string     | null: false                    |
| category_id        | integer    | null: false                    |
| status_id          | integer    | null: false                    |
| price              | integer    | null: false                    |
| comment            | text       | null: false                    |
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
| date_of_shipment   | string     | null: false                    |
| delivery_charge    | text       | null: false                    |
| address            | string     | null: false                    |
| number             | integer    | null: false                    |

### Association

- belongs_to :order
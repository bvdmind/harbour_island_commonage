# Commonage Land Management System (Rails 8)

## Overview

This application is a Rails 8 web platform designed to manage **commonage land users (commoners)**, their **verification status**, **supporting documents**, and **associated land parcels**.

It provides:

* An **admin-controlled announcement feed**
* **User profiles** with verification tracking
* **Document upload system** for proof of ownership/eligibility
* **Property and parcel management system** (with future map integration)

---

## Core Features

### 1. Authentication

* Built using Rails 8 authentication generator
* Session-based login system
* `Current.user` used across controllers

---

### 2. Admin Feed (Posts)

* Only users with `admin: true` can create/edit/delete posts
* All users can view posts
* Used for:

  * Notices
  * Deadlines
  * Meetings
  * Policy updates

---

### 3. User Profiles

Each user has:

* First name, last name
* Phone and address
* Profile photo (Active Storage)
* `is_verified` status (boolean)

Users can:

* View their profile
* Edit their information
* Upload supporting documents

---

### 4. Document Management

* Users upload verification documents (e.g. proof of land rights)
* Stored using Active Storage
* Each document includes:

  * `document_type`
  * optional notes
  * attached file

---

### 5. Property System

* Properties represent commonage land records
* Each property can:

  * Be linked to multiple users
  * Contain one or more parcels

---

### 6. Parcel System (Planned / In Progress)

* Parcels represent actual land boundaries
* Stored as polygon data (`JSONB`)
* Will integrate with Google Maps

Workflow:

1. Geocode property location
2. Draw parcel boundary (polygon)
3. Save polygon coordinates
4. Associate parcel → property → users

---

## Tech Stack

* Ruby 3.2+
* Rails 8
* PostgreSQL
* Active Storage (file uploads)
* Hotwire / Turbo (default Rails)
* Google Maps API (planned)

---

## Database Structure

### Users

* `first_name`
* `last_name`
* `email_address`
* `phone`
* `address`
* `admin:boolean`
* `is_verified:boolean`

### Posts

* `title`
* `body`
* `user_id`

### Properties

* `name`
* `commonage_reference`
* `address`
* `latitude`
* `longitude`
* `notes`

### Parcels

* `property_id`
* `name`
* `center_latitude`
* `center_longitude`
* `polygon_geojson:jsonb`
* `area_acres`

### PropertyOwnerships

* `user_id`
* `property_id`
* `ownership_type`
* `started_on`
* `ended_on`

### Documents

* `user_id`
* `document_type`
* `notes`
* file attachment via Active Storage

---

## Associations

* User:

  * has many posts
  * has many documents
  * has many properties through property_ownerships

* Property:

  * has many users through property_ownerships
  * has many parcels

* Parcel:

  * belongs to property

* Document:

  * belongs to user

---

## Setup Instructions

### 1. Clone and install dependencies

```bash
bundle install
```

---

### 2. Database setup

```bash
bin/rails db:create
bin/rails db:migrate
```

---

### 3. Active Storage (if not already installed)

```bash
bin/rails active_storage:install
bin/rails db:migrate
```

---

### 4. Run server

```bash
bin/rails server
```

Visit:

```
http://localhost:3000
```

---

## Creating an Admin User

Open Rails console:

```bash
bin/rails console
```

Then:

```ruby
user = User.first
user.update(admin: true)
```

---

## Project Structure

* `PostsController` → admin feed
* `UsersController` → profile management
* `DocumentsController` → document uploads
* `PropertiesController` → land records
* `ParcelsController` → parcel boundaries (in progress)

---

## Development Roadmap

### Phase 1 (Complete / In Progress)

* Authentication
* Admin feed
* User profiles
* Document uploads
* Verification flag

### Phase 2

* Property CRUD
* User ↔ property linking

### Phase 3

* Parcel mapping (Google Maps)
* Polygon drawing + storage

### Phase 4

* Admin verification workflow
* Document approval system

---

## Key Design Decisions

* `is_verified` used instead of complex status system for MVP
* Join table (`PropertyOwnership`) allows flexible relationships
* Parcel geometry stored as JSON for simplicity (upgrade to PostGIS later if needed)
* Admin logic handled via boolean flag (no roles system yet)

---

## Future Improvements

* Full admin dashboard
* Role-based permissions
* Parcel editing UI
* Map-based property search
* Notifications system
* Audit logs for document verification

---

## Summary

This system provides a structured way to:

* Track commonage land users
* Verify their eligibility through documents
* Associate them with land parcels
* Communicate updates through a controlled admin feed

It is designed to start simple, then scale into a full land management platform.

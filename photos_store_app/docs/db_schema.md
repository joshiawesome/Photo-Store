# Database Schema

```
                ┌───────────────┐
                │   products    │
                ├───────────────┤
                │ id (PK)       │
                │ name          │
                │ slug          │
                │ description   │
                │ state         │
                │ access        │
                │ created_at    │
                │ updated_at    │
                └──────┬────────┘
                       │
        ┌──────────────┼──────────────┐
        │              │              │
        ▼              ▼              ▼

┌───────────────┐  ┌───────────────┐  ┌────────────────────────┐
│   variants    │  │    images     │  │ additional_informations│
├───────────────┤  ├───────────────┤  ├────────────────────────┤
│ id (PK)       │  │ id (PK)       │  │ id (PK)                │
│ product_id FK │  │ url           │  │ product_id (FK)        │
│ name          │->│ transformed   │  │ info_type              │
│ sku           │  │ width         │  │ title                  │
│ price_value   │  │ height        │  │ body_html              │
│ currency      │  │ imageable_id  │  └────────────────────────┘
│ stock_type    │  │ imageable_type│
│ weight        │  └───────────────┘
│ dimensions    │
└──────┬────────┘
       │
       ▼

┌──────────────────────┐
│ variant_attributes   │
├──────────────────────┤
│ variant_id (FK)      │
│ description          │
│ color_name           │
│ color_swatch         │
│ size_name            │
└──────────────────────┘
```

## Relationships

- **products** → has many **variants**, **images**, **additional_informations**
- **variants** → belongs to **products**, has one **variant_attributes**
- **images** → polymorphic (imageable_id, imageable_type) - can belong to either **products** or **variants**

### Rails Models & Database Basics

1. **Naming Conventions**
   - Model names are **singular** (e.g., `Product`).
   - Table names are **plural** (e.g., `products`).
   - Foreign keys are usually **singular** (e.g., `product_id`).

2. **Migrations vs Models**
   - **Migrations** define the **table structure** and **relationships** in the database.
   - **Models** define **associations** and **business logic** in Rails.

3. **Associations**
   - Defined in models using naming conventions:
     - `has_many :variants` → one-to-many
     - `has_one :variant_attribute` → one-to-one

   - Rails automatically provides helper methods based on the association (e.g., `build_variant_attribute`, `product.variants`).

4. **Database Defaults**
   - Columns store `NULL` by default unless specified.
   - Rails automatically creates `id`, `created_at`, and `updated_at` columns.
   - `id` is usually **auto-incremented**, but custom IDs can be defined if needed (as in your app).

5. **Creating Records**
   - Records can be created by passing parameters:

     ```ruby
     Product.create!(name: "Toy", slug: "toy")
     ```

   - If validations are defined in the model, the required parameters must be present or Rails will raise an error.

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
│ name          │  │ transformed   │  │ info_type              │
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

## In Rails

- model name is singular
- table name is plural
- foreign key is singular
- migrations define table structure and relationships
- models define relationships between database tables
- associations are defined in models - They use naming conventions based on the target model + cardinality (one vs many)
- db stores values as NIL by default
- to create a db record, we can pass params - if validation is defined for the model, then those params must be passed mandatorily
- by default rails creates the id, created_at, updated_at columns
- ids are auto-incremented
- in our case, we have defined custom ids for most of the models

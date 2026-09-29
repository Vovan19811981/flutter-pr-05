# Architecture

```mermaid
flowchart TD
  App[MaterialApp] --> Scope[AppStateScope]
  Scope --> Shell[Main shell]
  Shell --> Home[HomeScreen]
  Shell --> Products[ProductsScreen]
  Shell --> Profile[ProfileScreen]
  Products --> Card[ProductCard]
  Home --> Components[ProfileWidget / CustomButton / AnimatedCounter]
  Scope --> State[AppState]
```

## State flow

```mermaid
flowchart LR
  UI[ProductCard] -->|toggleFavorite / addToCart| State[AppState]
  State -->|notifyListeners| Scope[AppStateScope]
  Scope --> UI2[Dependent widgets rebuild]
```

## Mock API contract

- `Product`: `id`, `name`, `description`, `price`, `category`.
- `User`: `id`, `name`, `email`, `subtitle`.
- Дані локальні, мережевий API не використовується.

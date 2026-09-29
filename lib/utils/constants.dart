import '../models/product.dart';
import '../models/user.dart';

const demoUser = User(
  id: 'u1',
  name: 'Ірина Коваль',
  email: 'iryna.koval@example.com',
  subtitle: 'Flutter developer',
);

const demoProducts = <Product>[
  Product(
    id: 'p1',
    name: 'Notebook',
    description: 'Твердий блокнот для щоденних нотаток.',
    price: 220,
    category: 'Stationery',
  ),
  Product(
    id: 'p2',
    name: 'Desk lamp',
    description: 'Компактна настільна лампа з регулюванням яскравості.',
    price: 890,
    category: 'Home',
  ),
  Product(
    id: 'p3',
    name: 'Travel mug',
    description: 'Термочашка для роботи та поїздок.',
    price: 540,
    category: 'Accessories',
  ),
  Product(
    id: 'p4',
    name: 'Wireless stand',
    description: 'Підставка для телефона з бездротовою зарядкою.',
    price: 1250,
    category: 'Electronics',
  ),
];

# README

This is a sandbox application, implementing
very simple shopping cart with 3 discounts applied.

### Notes

- I've used a bit of event-based approach, to extract callbacks into encapsulated, maintainable and extendable objects.
- This is not complete DDD due to the minimalistic nature of this application.
- I've created tests for high-level request for buying the products and for applying discounts. I've done this mostly in TDD, except scaffolding and had not in mind 100% test coverage.
- I've focused on presenting how I structure the application, how I encapsulate objects and write tests.
- Important: I haven't updated github history even though it is valued, to show better how I think and how the proces of creating the app went.

### Todo

1. Add an endpoint to close the order
2. Add an endpoint to list closed orders
3. Deploy to heroku
4. Fix 2 tests failing due to the Rails Event Store-Rspec helpers installed

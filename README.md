# Ruby On Rails Ticker API

This app was built to parse and format Ticker data from the Polygon API.

Tooling:
- Ruby On Rails(API-only app)
- Github Actions(Rubocop and Rspec)
- OpenAPI(Rswag)

Demo: [apidemo.webm](https://github.com/christianpaez/rails--demo/assets/45642493/10e1d2c4-c5ed-4064-9f74-0ce4f54c0d4f)

Live App: [Heroku](https://tranquil-lake-27668-dfbdcf2ac845.herokuapp.com/)

More Ticker Symbols: [Ticker symbols list](https://stockanalysis.com/stocks/)

Notes about summaries calculated:
- Price metrics were calculated in this manner:
   - "average": Calculated from properties "o" (open) and "c" (close).
   - "high": Calculated from property "h" (high).
   - "low": Calculated from property "l" (low).
- Volume metrics were calculated in this manner:
    - "average": Calculated from property "vw" (volume-weighted).
    - "high": Maximum value from property "vw".
    - "low": Minimum value from property "vw".

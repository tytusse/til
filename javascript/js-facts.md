Having the code
```javascript
function Apple() {
  this.x = 42;
}
Apple.prototype.foo = function(){ return "bar"; }

TBD
```

Facts
- `x instanceof Y` => `Object.getPrototypeOf(x) === Y.prototype`
- TBS

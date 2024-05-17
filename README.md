# incr.nvim

Increment values in a selection

![Example](assets/example.gif)

## Commands

### :IncrInt

For all highlighted values, the first row's value will be used and then incremented by the row offset.

Example:
```
x0 -> x0
x0 -> x1
x0 -> x2
x0 -> x3
x0 -> x4
x0 -> x5
```
Because only the first value is used, the values of subsequent rows are blindly overwritten with their new value

Example:
```
x0 -> x0
x0 -> x1
x1 -> x2
x2 -> x3
x3 -> x4
x4 -> x5
```

### :IncrIntBy

This is like `:IncrInt` but you specify the delta per row

Example with delta 2:
```
x0 -> x0
x0 -> x2
x0 -> x4
x0 -> x6
x0 -> x8
x0 -> x10
```

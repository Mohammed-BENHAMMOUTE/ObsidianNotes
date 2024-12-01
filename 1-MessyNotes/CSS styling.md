# CSS Fundamentals Review
[[Frontend]]

## 1. Selectors

### Basic Selectors
- Element selector: `p`
- Class selector: `.classname`
- ID selector: `#idname`
- Universal selector: `*`

### Combinators
- Descendant selector: `div p`
- Child selector: `div > p`
- Adjacent sibling selector: `h1 + p`
- General sibling selector: `h1 ~ p`

### Attribute Selectors
- `[attribute]`: Elements with the attribute
- `[attribute="value"]`: Exact match
- `[attribute~="value"]`: Contains word
- `[attribute^="value"]`: Starts with
- `[attribute$="value"]`: Ends with
- `[attribute*="value"]`: Contains substring

### Pseudo-classes
- `:hover`, `:active`, `:focus`
- `:first-child`, `:last-child`, `:nth-child(n)`
- `:not(selector)`

### Pseudo-elements
- `::before`, `::after`
- `::first-line`, `::first-letter`

### Advanced Selectors
- `:is()` - matches any of the selectors in the list
- `:where()` - similar to `:is()`, but with 0 specificity
- `:has()` - parent selector (not yet widely supported)

## 2. Box Model

The CSS box model describes the rectangular boxes generated for elements in the document tree.

### Components
1. Content: The inner content of the element (text, images, etc.)
2. Padding: Clear space around the content (inside the border)
3. Border: A border that goes around the padding and content
4. Margin: Clear space outside the border

### Properties
- `width`, `height`: Dimensions of the content area
- `padding`, `padding-top`, `padding-right`, `padding-bottom`, `padding-left`
- `border`, `border-width`, `border-style`, `border-color`
- `margin`, `margin-top`, `margin-right`, `margin-bottom`, `margin-left`

### Box-sizing
- `box-sizing: content-box;` (default): Width and height apply to content only
- `box-sizing: border-box;`: Width and height include padding and border

## 3. Display Property

The `display` property specifies how an element should be displayed.

### Common Values
- `block`: Takes up full width, starts on a new line
- `inline`: Takes up only as much width as needed, doesn't start on a new line
- `inline-block`: Inline, but can have width and height
- `none`: Removes the element from the document flow
- `flex`: Creates a flex container
- `grid`: Creates a grid container

### Advanced Values
- `table`, `table-row`, `table-cell`: For creating table-like layouts
- `flow-root`: Creates a block-level element with its own block formatting context

## 4. Positioning

The `position` property specifies the positioning method for an element.

### Values
- `static` (default): Normal flow
- `relative`: Positioned relative to its normal position
- `absolute`: Positioned relative to its nearest positioned ancestor
- `fixed`: Positioned relative to the viewport
- `sticky`: Positioned based on the user's scroll position

### Related Properties
- `top`, `right`, `bottom`, `left`: Specify the positioning
- `z-index`: Controls the stacking order of elements

## 5. Floats and Clears

### Float
The `float` property specifies whether an element should float to the left, right, or not at all.

- `float: left;`
- `float: right;`
- `float: none;` (default)

### Clear
The `clear` property specifies which sides of an element where other floating elements are not allowed.

- `clear: left;`
- `clear: right;`
- `clear: both;`
- `clear: none;` (default)

### Modern Alternatives
While floats are still used, modern layout techniques like Flexbox and Grid are often preferred for complex layouts.

### Clearfix Hack
To contain floated elements within a parent:

```css
.clearfix::after {
  content: "";
  display: table;
  clear: both;
}
```

Remember, while these are fundamental concepts, CSS has evolved. Many modern layout challenges are now better solved using Flexbox, Grid, and other advanced techniques. However, understanding these basics is crucial for mastering CSS and understanding legacy code.